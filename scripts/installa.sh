#!/usr/bin/env bash
#
# Installa la software house dentro un progetto, copiando agenti e discipline
# in .claude/ — senza passare dal marketplace.
#
# Perché serve: la dichiarazione del marketplace in .claude/settings.json non
# installa davvero il plugin (difetto noto di Claude Code, issue #32606). Con
# la copia diretta gli agenti e le discipline sono file del progetto, e vengono
# caricati sempre: in locale, in cloud, da chiunque, senza installazioni.
#
# Uso, dalla cartella del progetto:
#   curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/installa.sh | bash
#
# Rieseguibile: rimuove la copia precedente prima di riscrivere, e non tocca
# gli agenti e le discipline propri del progetto.

set -euo pipefail

REPO="https://github.com/ganzomoreno/software-house.git"
MANIFESTO=".claude/.software-house"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

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

if [ ! -d .git ]; then
  echo "✗ Va eseguito dalla cartella principale di un progetto (non trovo .git)." >&2
  exit 1
fi

echo "→ Scarico la software house…"
git clone --depth 1 --quiet "$REPO" "$TMP/sh"
VERSIONE="$(grep -o '"version": *"[^"]*"' "$TMP/sh/plugins/software-house/.claude-plugin/plugin.json" | head -1 | cut -d'"' -f4)"

# ── rimuove solo ciò che avevamo installato noi la volta scorsa ──────────
if [ -f "$MANIFESTO" ]; then
  echo "→ Rimuovo la copia precedente…"
  while IFS= read -r voce; do
    [ -n "$voce" ] && rm -rf "$voce"
  done < "$MANIFESTO"
fi

mkdir -p .claude/agents .claude/skills
: > "$MANIFESTO"

echo "→ Copio i cinque agenti…"
for f in "$TMP/sh/plugins/software-house/agents/"*.md; do
  cp "$f" .claude/agents/
  echo ".claude/agents/$(basename "$f")" >> "$MANIFESTO"
done

echo "→ Copio le discipline…"
for d in "$TMP/sh/plugins/software-house/skills/"*/; do
  nome="$(basename "$d")"
  cp -R "$d" ".claude/skills/$nome"
  echo ".claude/skills/$nome" >> "$MANIFESTO"
done

sistema_gitignore

AGENTI=$(grep -c "^.claude/agents/" "$MANIFESTO")
DISCIPLINE=$(grep -c "^.claude/skills/" "$MANIFESTO")

cat >> "$MANIFESTO" <<EOF

# ─────────────────────────────────────────────────────────────
# Software house portatile v${VERSIONE}
# Copia installata da ganzomoreno/software-house.
# NON modificare questi file qui: le correzioni si fanno nel repository
# della software house, poi si riesegue questo script.
# Per aggiornare:
#   curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/installa.sh | bash
# ─────────────────────────────────────────────────────────────
EOF

echo
echo "✓ Software house v${VERSIONE} installata: ${AGENTI} agenti, ${DISCIPLINE} discipline."
echo
echo "  Ora:"
echo "  1. fai commit di .claude/ e portalo sul ramo da cui partono le tue sessioni"
echo "  2. apri una sessione NUOVA su quel ramo"
echo
echo "  Gli agenti e le discipline sono file del progetto: si caricano sempre,"
echo "  senza installazioni e senza marketplace."
