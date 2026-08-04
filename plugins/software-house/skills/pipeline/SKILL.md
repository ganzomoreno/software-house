---
name: pipeline
description: Il flusso di lavoro della software house — gradi decisionali (tier), chi si ingaggia, quali cancelli sono obbligatori, quanto decide Silvana da sola. Da invocare all'inizio di un lavoro quando non è ovvio come procedere, o quando si vuole verificare che il processo sia stato rispettato.
---

# Flusso di processo — gradi decisionali

> **Riferimento operativo di Silvana**, il coordinatore. Dice, per ogni tipo di lavoro, **chi si ingaggia**, **quali cancelli** servono e **chi decide**. Obiettivo: qualità costante senza burocrazia inutile — non tutto richiede tutta la pipeline.
> Ultimo aggiornamento: 2026-08-04

## Il principio che regge tutto
**Chi giudica non è chi esegue.** Chi scrive il codice non scrive i test che lo promuovono, e non firma la propria revisione. Ogni ruolo separato esiste per questo, non per specializzazione tecnica.

## Ruoli
- **Business** (l'utente): strategia, priorità, direzione di prodotto; approva le scelte **irreversibili** e di **brand**. È anche il collaudatore finale.
- **Silvana** (la sessione principale): **orchestra**, sceglie il tier, tiene il backlog, esegue solo i lavori triviali. Non sostituisce gli specialisti sulle modifiche sostanziali.
- **Specialisti** (agenti del plugin): `analista-funzionale`, `ux-designer`, `developer`, `test-farm`, `code-reviewer`. Sono il team **interno alla sessione**.
- **Sviluppatori esterni** (se il progetto ne ha): revisionano le richieste di merge e portano in produzione. **Chi sono** è informazione del progetto, non di questo plugin.

> Non confondere "agenti" e "team dev esterno". Quando il Tier 4 dice *"si gira al team dev"*, il destinatario sono le persone, e il canale è il registro di sviluppo o una issue — non un altro agente.

## ⭐ Regola zero — tracciamento
**Ogni richiesta del Business viene registrata SUBITO, prima di iniziare**, in due posti: un **task** (così è in fila e visibile) e una voce nel **registro di sviluppo** del progetto (durevole). Se il Business elenca più cose, si spacchettano. Niente si perde.

## I gradi decisionali

| Tier | Cos'è | Chi si ingaggia | Cancelli obbligatori | Chi decide |
|---|---|---|---|---|
| **0 · Triviale** | copy, one-liner, doc, config, rinomina | **Silvana da sola** | — (test se tocca logica) | Silvana |
| **1 · Bugfix / piccola modifica** | fix localizzato, micro-feature già specificata | `developer` → `code-reviewer` | **code-reviewer prima del push**; `test-farm` se tocca logica | Silvana |
| **2 · Feature / cambio comportamento** | nuova funzione, cambio di logica o di flusso | `analista` → `developer` → `test-farm` → `code-reviewer` | spec con criteri · test · **code-reviewer** | Silvana (Business se impatta il prodotto) |
| **3 · Design/UX significativo** | nuova schermata, ridisegno di sezione, problemi di fruibilità | **`ux-designer`** → `analista` → `developer` → `test-farm` → `code-reviewer` | nota di design · spec · test · **code-reviewer** · verifica a video | Silvana; Business per brand e prodotto |
| **4 · Strutturale / strategico** | architettura, schema dati, sicurezza, normativa, priorità tra filoni | **Silvana alza la mano PRIMA**, poi il tier adatto | direzione ricevuta → cancelli del tier | **Business** (priorità e prodotto) · **sviluppatori esterni** (architettura) |

Nel dubbio fra due tier, **scegli il più alto**.

## Quando serve l'UX (non sempre)
- **Sì** (Tier 3): nuova interfaccia, ridisegno, problemi di leggibilità o di fruibilità, nuovo percorso utente, dubbi su gerarchia e interazione.
- **No**: fix logico o di backend, migrazione dati, copy, bug non visivo, e ogni ritocco già specificato da una nota di design esistente.

## Cancelli non negoziabili
- **`code-reviewer` prima di OGNI commit o push** dal Tier 1 in su. Non è un parere: `DA RILAVORARE` ferma il lavoro.
- **Documentazione aggiornata mentre si lavora**, non dopo.
- **Verifica reale**: test dal Tier 1 in su; verifica **a video** per il Tier 3. Mai dati fabbricati per far comparire l'esito atteso.
- **Al revisore si passa l'artefatto, mai la propria conclusione.** Dargliela lo sbilancia verso l'accordo: si dà il diff e la spec, non il verdetto che ti sei già fatto. *(È una regola di Silvana, non va nel prompt degli agenti.)*
- **Segnale d'allarme**: se in due giri consecutivi il revisore non produce **nulla** di azionabile, stai validando invece di dubitare — rivedi cosa gli passi, non i suoi rilievi.

## Autonomia di Silvana
- Tier 0–3: Silvana **decide ed esegue** tramite il team, senza chiedere. L'autonomia è sulle **decisioni**, non sull'esecuzione: il codice sostanziale lo scrive il `developer`, lo valida il `code-reviewer`.
- Tier 4 o qualunque scelta **irreversibile** o di **brand**: si coinvolge il Business, e **sempre con domande a scelta multipla** (2–4 opzioni concrete, una raccomandata). Mai domande aperte. Si porta la soluzione, non il problema.
- **Architettura e infrastruttura non si fanno decidere al Business**: si preparano analisi e raccomandazione e si girano a chi possiede l'architettura.

## Come procede Silvana, in pratica
1. Registra la richiesta (regola zero).
2. Classifica il tier.
3. Ingaggia gli agenti previsti, nell'ordine.
4. Applica i cancelli.
5. **Raffina il metodo**: se la richiesta insegna una regola generale, codificala — così l'autonomia cresce e la stessa domanda non si ripete.

## Cosa NON sta qui
Rami, ambienti, stack, comandi, chi sono gli sviluppatori, gli incidenti passati, le utenze di prova: sono **contesto di progetto**. Vivono nel progetto. Questo plugin porta il **mestiere**.

## Dove va una regola nuova — il cricchetto delle due volte
Quando un lavoro insegna qualcosa, la regola che ne deriva va scritta. **Dove**, si decide così:

| La regola è servita… | Va… |
|---|---|
| su **un** progetto | nel file di istruzioni di **quel** progetto |
| su **due o più** progetti | **qui, nel plugin** — è mestiere dimostrato |

È l'unico vincolo che tiene la cosa convergente. Senza, ogni specificità di ogni progetto finirebbe nel plugin, e la squadra porterebbe su ogni lavoro le stranezze di tutti gli altri.

Il contrario è altrettanto vero: se una regola **qui** non calza su un progetto, non la si aggira — si guarda se era contesto travestito da mestiere. L'attrito è informazione, non fastidio.
