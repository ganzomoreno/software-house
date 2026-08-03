# 🎒 Software house portatile

Una squadra di sviluppo che **si porta con sé**: cinque ruoli specializzati, una pipeline e dei cancelli obbligatori, disponibili su **qualunque progetto**, aggiornabili da un punto solo.

Non è una raccolta di suggerimenti: è un **metodo di lavoro**, quello che su Karica è stato costruito e corretto sul campo, ripulito da tutto ciò che era specifico di quel progetto.

---

## Il principio che regge tutto

> **Chi giudica non è chi esegue.**

Chi scrive il codice non scrive i test che lo promuovono, e non firma la propria revisione. Ogni separazione di ruolo esiste per questo — non per specializzazione tecnica.

---

## I cinque ruoli

| Ruolo | Cosa fa | Cosa NON fa |
|---|---|---|
| **`ux-designer`** | Guarda la schermata con gli occhi di chi la usa e propone il ridisegno | Non scrive codice |
| **`analista-funzionale`** | Trasforma la richiesta in criteri di accettazione **binari** e numerati | Non implementa |
| **`developer`** | Implementa **esattamente** quei criteri, e li verifica | Non scrive i propri test, non fa commit |
| **`test-farm`** | Scrive i test partendo **dai criteri, non dal codice** | Non tocca il codice di produzione |
| **`code-reviewer`** | **Cancello bloccante** prima di ogni commit | Non applica i fix: emette un verdetto |

Li orchestra il **PM** — la sessione principale. Il PM decide, ma non sostituisce gli specialisti sulle modifiche sostanziali.

---

## Come si installa

Una volta per macchina:

```bash
claude
```

Poi, dentro Claude Code:

```
/plugin marketplace add ganzomoreno/software-house
```

E su ogni progetto in cui lo si vuole:

```
/plugin install software-house@ganzomoreno
```

Da quel momento i cinque agenti sono disponibili in quel progetto, insieme alla checklist di processo che compare a ogni avvio di sessione.

---

## Cosa c'è dentro

```
plugins/software-house/
├── agents/          i cinque ruoli
├── skills/pipeline/ il flusso: tier, cancelli, autonomia del PM
└── hooks/           checklist all'avvio + promemoria del cancello sul commit
```

Per il flusso completo — quando serve l'UX, quali cancelli sono obbligatori, quanto decide il PM da solo — vedi [`skills/pipeline/SKILL.md`](plugins/software-house/skills/pipeline/SKILL.md).

---

## La linea di taglio: mestiere ≠ progetto

| Sta **qui** (il mestiere) | Resta **nel progetto** (il contesto) |
|---|---|
| I ruoli e i loro confini | Rami, ambienti, database |
| La pipeline e i cancelli | Chi sono gli sviluppatori veri |
| Come si scrive una spec, un test, una review | Gli incidenti passati |
| Le regole di lavoro | Stack, comandi, utenze di prova |

Esempio: *"riparti sempre dalla versione vigente"* è **mestiere** → sta qui. *"L'incidente 00069 partì dalla migrazione sbagliata"* è **progetto** → resta là.

Ogni progetto continua ad avere il proprio file di istruzioni con il proprio contesto. Il plugin non lo sostituisce: lo completa.

---

## ⚠️ Stato: versione zero, da mettere alla prova

Questo pacchetto nasce **estraendo il metodo da un progetto solo**. È il modo classico in cui nasce una brutta astrazione: sembra generale, ed è un progetto travestito.

La misura fatta prima di estrarre: **il 63% del contenuto degli agenti sopravvive** alla rimozione dei riferimenti specifici, e ciò che sopravvive è il **protocollo** (scale di severità, criteri binari, obbligo di dichiarare i numeri, divieto di dati fabbricati), non consigli generici. È il motivo per cui l'estrazione ha senso.

Ma **finché gira su un progetto solo, che sia generale resta un'ipotesi.** Il passo che la verifica è provarlo su un secondo progetto. Fino ad allora: versione 0.1.0.

---

*Metodo costruito sul progetto Karica, 2026. Manutenuto da [@ganzomoreno](https://github.com/ganzomoreno).*
