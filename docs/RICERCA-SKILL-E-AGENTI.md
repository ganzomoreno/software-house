# Ricerca: quali skill installare, e se servono nuovi agenti

> Ricerca approfondita (deep research) commissionata dal Business il 2026-08-26.
> Domanda: *quali skill installare per usare al meglio i cinque agenti, e se serve installare nuovi agenti per migliorare il processo.*
> Metodo: 6 angoli di ricerca, 24 fonti lette, 100 affermazioni estratte, le 25 principali verificate ciascuna da 3 verificatori avversariali indipendenti (23 confermate, 2 refutate).
> Le fonti sono quasi tutte primarie (documentazione e blog ufficiali Anthropic, repo ufficiali).

---

## Il verdetto in una riga

**Le lacune si colmano con skill e plugin installabili, non con nuovi agenti.** La rosa di cinque è già ben dimensionata secondo la dottrina ufficiale Anthropic; l'unico candidato credibile a un sesto ruolo è un devops/release — e anche quello conviene farlo nascere come skill.

---

## 1. Skill e plugin da installare (in ordine di priorità)

### a. Sicurezza — il gap più evidente della pipeline
- **`security-guidance`** (marketplace ufficiale Anthropic): rivede automaticamente ogni modifica per vulnerabilità comuni e fa correggere i finding nella stessa sessione. Supporta **regole specifiche di progetto** — ideale per codificare le regole RLS/Supabase già presenti nella skill `sicurezza-database`.
- **`claude-security`** (marketplace ufficiale): vulnerability scanning approfondito in-sessione.
- Alternativa vendor (marketing auto-dichiarato, nessuna evidenza indipendente): Aikido, 42Crunch, semgrep, sonarqube.
- Fonti: [discover-plugins](https://code.claude.com/docs/en/discover-plugins), [claude-plugins-official](https://github.com/anthropics/claude-plugins-official) — verifica 3-0.

### b. Flussi git/PR
- **`commit-commands`**: workflow commit/push/creazione PR.
- **`pr-review-toolkit`**: agenti specializzati per la review delle PR.
- **`code-review`** (ufficiale Anthropic): lancia 4 agenti di review paralleli con scoring di confidenza 0–100 e soglia configurabile (default 80) per filtrare i falsi positivi. È il termine di confronto — o l'upgrade diretto — per il gate del nostro `code-reviewer`.
- Fonti: come sopra — verifica 3-0.

### c. Stack Supabase/Postgres
- **Plugin ufficiale Supabase**: MCP server + due skill (`supabase`, `supabase-postgres-best-practices`) su migrazioni, Edge Functions, Auth e pattern RLS. Complementare — non sostitutivo — delle nostre skill di disciplina.
- Fonti: [supabase.com/docs/guides/ai-tools/plugins](https://supabase.com/docs/guides/ai-tools/plugins), [supabase/agent-skills](https://github.com/supabase/agent-skills).

### d. Metodologia — adozione SELETTIVA da Superpowers
- **`superpowers`** (obra/superpowers, installabile dal marketplace ufficiale): metodologia completa in skill componibili. Le skill utili per noi: `systematic-debugging`, `verification-before-completion`, `using-git-worktrees`.
- ⚠️ **Attenzione**: le sue skill di planning e code-review **si sovrappongono** ai ruoli di `analista-funzionale` e `code-reviewer`, e il plugin porta "initial instructions" che sterzano l'agente. Meglio estrarre le tre skill utili che installare tutto.
- Fonte: [obra/superpowers](https://github.com/obra/superpowers) — verifica 3-0, con nota esplicita del verificatore sulla sovrapposizione.

### e. Per migliorare le TRE skill già nostre
- **`skill-creator`** (ufficiale Anthropic): benchmark with-skill vs without-skill, confronti A/B alla cieca fra versioni, tuning delle descrizioni con misura dell'hit rate su prompt should-trigger/should-not-trigger.
- Metodo ufficiale di authoring: **eval-first** — partire dai gap osservati su task reali e costruire incrementalmente (esattamente il processo che ha generato le nostre tre skill "dal campo"; la via è continuare così, non scrivere cataloghi speculativi). Nome e descrizione sono il meccanismo di triggering: è lì che si lavora.
- Fonti: [equipping-agents-for-the-real-world](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills), [docs skills](https://code.claude.com/docs/en/skills) — verifica 3-0.

---

## 2. Servono nuovi agenti? No — con un'eccezione condizionata

### La dottrina ufficiale (verificata 3-0)
- Le **skill** sono capacità portabili che girano nel contesto della conversazione ("come materiale di formazione"). I **subagent** servono solo per: isolamento del contesto (assorbire ricerche, log, output verbosi restituendo un sommario), restrizioni sui tool, task autocontenuti.
- Anthropic **sconsiglia esplicitamente** di delegare a subagent fasi che condividono contesto significativo (planning → implementation → testing) o che richiedono iterazione avanti-indietro: ogni agente in più aggiunge latenza e perdita di contesto ai passaggi di mano.
- Conseguenza: le nostre discipline trasversali (mutazione, migrazioni, RLS) sono **correttamente** skill e non vanno promosse ad agenti.
- Fonti: [subagents-in-claude-code](https://claude.com/blog/subagents-in-claude-code), [docs sub-agents](https://code.claude.com/docs/en/sub-agents), [skills-explained](https://claude.com/blog/skills-explained).

### L'unica eccezione: devops/release (confidenza media)
- Il team multi-agente di riferimento di AWS ([sample-claude-code-agent-team](https://github.com/aws-samples/sample-claude-code-agent-team)) rispecchia da vicino la nostra rosa ma aggiunge un **devops-agent** (infrastruttura, CI/CD, container, documentazione) e un **sa-agent** opzionale (architecture review). Pattern: modelli pesanti su planning e review, economici sull'implementazione.
- È però un repo di esempio, **senza misure di efficacia**. Raccomandazione: il ruolo devops nasce come **skill** (disciplina di deploy/release); si promuove ad agente solo se l'output verboso di CI/infra inizia a inquinare il contesto principale — cioè quando scatta il criterio ufficiale dell'isolamento.

### Due leve architetturali più forti di un nuovo agente (verificate 3-0)
1. **Preload delle skill negli agenti esistenti**: un subagent con campo `skills` nel frontmatter riceve il contenuto COMPLETO delle skill iniettato all'avvio (non solo la descrizione). Concretamente: `test-farm` precarica `verifica-per-mutazione`; `code-reviewer` precarica `migrazioni-database` e `sicurezza-database`. La disciplina è sempre in contesto nell'agente giusto, senza dipendere dal triggering. Fonte: [docs sub-agents](https://code.claude.com/docs/en/sub-agents).
2. **Il gate del commit va reso deterministico con un hook**: solo hook e permessi sono deterministici; un hook `PreToolUse` può ispezionare la chiamata `git commit` e **bloccarla** (exit code 2) se la review non risulta avvenuta. Il nostro hook attuale è un promemoria, non un blocco. Fonte: [steering-claude-code](https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more).

---

## 3. Cosa evitare

- **Sprawl di skill e plugin.** Il listing delle skill ha un budget pari all'**1% della context window** (default); il testo descrizione+when_to_use è troncato a **1.536 caratteri**; in overflow Claude Code taglia le descrizioni partendo dalle skill meno usate — strappando le keyword che servono al matching. Lo sprawl degrada direttamente il triggering.
- **Ogni plugin installato aggiunge costo di contesto per turno.** Il plugin manager espone una stima "Context cost" pre-installazione e una lista "Not used recently" per potare. Potare periodicamente.
- **Il mito del "costo zero" è stato refutato in verifica (0-3).** La progressive disclosure rende il costo basso (~100 token di metadati per skill; il corpo entra solo all'invocazione e poi resta in contesto), ma non nullo. C'è anche un bug aperto ([claude-code #14882](https://github.com/anthropics/claude-code/issues/14882)) su skill di plugin che mostrerebbero il conteggio pieno a startup.
- **Installare Superpowers integrale**: rischio di conflitto con l'orchestrazione di Silvana e i tier (vedi §1d).

---

## 4. Cautele e domande aperte

- **Nessuna fonte porta evidenza quantitativa** che pipeline multi-agente con gate producano codice migliore o più veloce di una sessione singola con skill ben fatte: la letteratura è documentazione primaria e README, descrittiva.
- Come convivrebbero le "initial instructions" di Superpowers con Silvana e i tier — conflitto o convivenza? Da provare su un progetto, non da decidere a tavolino.
- `security-guidance` con regole di progetto vs estendere la nostra `sicurezza-database`: quale dei due, per evitare trigger sovrapposti? Da sperimentare.
- L'ecosistema evolve in fretta (`context: fork`, preload `skills`, "Context cost" sono feature recenti): numeri e nomi andranno riverificati fra qualche mese.

---

## Piano d'azione proposto (in attesa di ok del Business)

1. **Subito, a costo zero di sviluppo**: installare `security-guidance`, plugin Supabase e `skill-creator` sui progetti; provare `code-review` ufficiale in parallelo al nostro gate per un confronto.
2. **Modifica al plugin (v0.3.0)**: preload delle skill negli agenti (`test-farm` ← mutazione; `code-reviewer` ← migrazioni + sicurezza-db) e trasformazione del promemoria sul commit in **hook bloccante** `PreToolUse`.
3. **Selettivo**: estrarre da Superpowers le tre skill utili (debugging, verification, worktrees) invece di installarlo integrale.
4. **Continuo**: usare `skill-creator` per misurare le tre skill dal campo (benchmark e tuning delle descrizioni) — è la versione strumentata del nostro "raffina il metodo".

---

*Ricerca eseguita con verifica avversariale (3 voti indipendenti per claim; 2 refutazioni su 3 uccidono il claim). Statistiche: 6 angoli, 24 fonti, 100 claim estratti, 25 verificati, 23 confermati, 2 refutati, 107 agenti impiegati.*
