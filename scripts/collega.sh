#!/usr/bin/env bash
#
# Collega la software house a un progetto SENZA copiarla:
#   - la aggancia come sottomodulo git in .software-house/  (nella storia del
#     progetto resta un puntatore a un commit, non i file)
#   - crea in .claude/agents/ e .claude/skills/ dei collegamenti che puntano lì
#
# Aggiornare significa spostare il puntatore di un commit, non ricopiare file.
#
# Uso, dalla cartella principale del progetto:
#   curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/collega.sh | bash
#
# Per aggiornare alla versione più recente:
#   bash .software-house/scripts/collega.sh --aggiorna
#
# Per staccare tutto:
#   bash .software-house/scripts/collega.sh --stacca

set -euo pipefail

REPO="https://github.com/ganzomoreno/software-house.git"
SUB=".software-house"
MANIFESTO=".claude/.software-house"
MODO="${1:-installa}"

# ── controllo: il .gitignore del progetto ingoia .claude/? ──────────────
# Difetto scoperto sul campo il 26/08/2026: un .gitignore con ".claude/*" e la
# sola eccezione "!.claude/settings.json" rende la squadra INVISIBILE a git.
# "git add .claude/" aggiunge zero file e il commit riesce senza portare nulla:
# il fallimento è silenzioso, e si scopre solo a sessione nuova.
sistema_gitignore() {
  local ignorati=0 voce
  while IFS= read -r voce; do
    case "$voce" in ''|'#'*) continue ;; esac
    if git check-ignore -q "$voce" 2>/dev/null; then ignorati=$((ignorati+1)); fi
  done < "$MANIFESTO"

  [ "$ignorati" -eq 0 ] && return 0

  echo
  echo "⚠  Il .gitignore di questo progetto esclude .claude/: ${ignorati} voci"
  echo "   sarebbero invisibili a git, e il commit riuscirebbe senza portare nulla."
  echo "→ Aggiungo le eccezioni necessarie a .gitignore…"

  cat >> .gitignore <<'IGN'

# Software house portatile — la squadra deve essere versionata, altrimenti non
# arriva alle sessioni (in cloud, e a chiunque altro apra il progetto).
!.claude/agents/
!.claude/agents/**
!.claude/skills/
!.claude/skills/**
!.claude/.software-house
IGN

  local rimasti=0
  while IFS= read -r voce; do
    case "$voce" in ''|'#'*) continue ;; esac
    git check-ignore -q "$voce" 2>/dev/null && rimasti=$((rimasti+1))
  done < "$MANIFESTO"

  if [ "$rimasti" -gt 0 ]; then
    echo "✗ ${rimasti} voci restano ignorate: il .gitignore ha regole più forti."
    echo "  Sistemalo a mano prima di fare commit, altrimenti la squadra non arriva."
  else
    echo "✓ Eccezioni aggiunte: ora la squadra è versionabile."
  fi
}

[ -d .git ] || { echo "✗ Eseguilo dalla cartella principale di un progetto." >&2; exit 1; }

# Rimuove l'installazione precedente, QUALUNQUE forma avesse: collegamenti
# (installazione a puntamento) oppure file e cartelle veri (installazione per
# copia). Senza questo, passando dalla copia al collegamento i file vecchi
# resterebbero e il collegamento finirebbe DENTRO la cartella esistente.
rimuovi_installazione_precedente() {
  [ -f "$MANIFESTO" ] || return 0
  local voce
  while IFS= read -r voce; do
    case "$voce" in ''|'#'*) continue ;; esac
    # su un collegamento rm agisce sul collegamento, mai sulla destinazione
    rm -rf "$voce"
  done < "$MANIFESTO"
  rm -f "$MANIFESTO"
}

if [ "$MODO" = "--stacca" ]; then
  echo "→ Rimuovo i collegamenti…"
  rimuovi_installazione_precedente
  if [ -d "$SUB" ]; then
    git submodule deinit -f "$SUB" >/dev/null 2>&1 || true
    git rm -f "$SUB" >/dev/null 2>&1 || rm -rf "$SUB"
    rm -rf ".git/modules/$SUB"
  fi
  echo "✓ Software house staccata. Fai commit."
  exit 0
fi

if [ "$MODO" = "--aggiorna" ]; then
  [ -d "$SUB" ] || { echo "✗ Non è collegata: usa lo script senza argomenti." >&2; exit 1; }
  echo "→ Sposto il puntatore all'ultima versione…"
  git submodule update --remote --quiet "$SUB"
else
  if [ -d "$SUB" ]; then
    echo "→ Già collegata: aggiorno il puntatore."
    git submodule update --remote --quiet "$SUB"
  else
    echo "→ Aggancio la software house come sottomodulo…"
    git submodule add --quiet -b main "$REPO" "$SUB"
    git submodule update --init --quiet "$SUB"
  fi
fi

SORGENTE="$SUB/plugins/software-house"
VERSIONE="$(grep -o '"version": *"[^"]*"' "$SORGENTE/.claude-plugin/plugin.json" | head -1 | cut -d'"' -f4)"

echo "→ Rifaccio i collegamenti…"
rimuovi_installazione_precedente
mkdir -p .claude/agents .claude/skills
: > "$MANIFESTO"

for f in "$SORGENTE/agents/"*.md; do
  nome="$(basename "$f")"
  ln -sfn "../../$SORGENTE/agents/$nome" ".claude/agents/$nome"
  echo ".claude/agents/$nome" >> "$MANIFESTO"
done

for d in "$SORGENTE/skills/"*/; do
  nome="$(basename "$d")"
  ln -sfn "../../$SORGENTE/skills/$nome" ".claude/skills/$nome"
  echo ".claude/skills/$nome" >> "$MANIFESTO"
done

sistema_gitignore

AG=$(grep -c "^.claude/agents/" "$MANIFESTO")
DI=$(grep -c "^.claude/skills/" "$MANIFESTO")

cat >> "$MANIFESTO" <<EOF

# ─────────────────────────────────────────────────────────────
# Software house portatile v${VERSIONE} — COLLEGATA, non copiata.
# I file veri stanno in ${SUB}/ (sottomodulo git).
# Nella storia di questo progetto c'è solo un puntatore a un commit.
# Aggiornare:  bash ${SUB}/scripts/collega.sh --aggiorna
# Staccare:    bash ${SUB}/scripts/collega.sh --stacca
# ─────────────────────────────────────────────────────────────
EOF

echo
echo "✓ Software house v${VERSIONE} collegata: ${AG} agenti, ${DI} discipline."
echo
echo "  ⚠️  VERIFICA PRIMA DI FIDARTI: apri una sessione NUOVA e controlla che"
echo "     agenti e discipline compaiano davvero. I collegamenti simbolici sono"
echo "     supportati per le discipline; per gli agenti e per il recupero del"
echo "     sottomodulo in ambiente cloud va verificato sul campo."
echo
echo "  Poi: commit di .gitmodules, ${SUB} e .claude/, e porta sul ramo giusto."
