# 🎒 Software house portatile

> **A cosa serve:** portare su qualunque progetto lo stesso metodo di sviluppo — cinque ruoli, una pipeline, dei cancelli obbligatori — aggiornabile da un punto solo.
> **Per chi:** chi apre una sessione di sviluppo, su un progetto qualsiasi.
> Ultimo aggiornamento: 2026-08-04

Una squadra di sviluppo che **si porta con sé**: cinque ruoli specializzati, una pipeline e dei cancelli obbligatori, disponibili su **qualunque progetto**, aggiornabili da un punto solo.

Non è una raccolta di suggerimenti: è un **metodo di lavoro**, quello che su Karica è stato costruito e corretto sul campo, ripulito da tutto ciò che era specifico di quel progetto.

> 📖 **Il documento di riferimento è [`docs/METODO.md`](docs/METODO.md)**: cos'è il metodo, perché lo stiamo unificando, il piano in quattro mosse e il suo stato. Chi vuole capire prima di installare parte da lì.

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

Li orchestra **Silvana**, il coordinatore — la sessione principale. Silvana decide, ma non sostituisce gli specialisti sulle modifiche sostanziali.

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

### Perché arrivi anche in cloud e su altre macchine

I comandi qui sopra scrivono la configurazione **sulla macchina**. Un ambiente cloud parte pulito e non la trova.

Per averla ovunque, la si mette nel file di configurazione **del progetto** — `.claude/settings.json`, che è versionato e quindi viaggia col repository:

```json
{
  "extraKnownMarketplaces": {
    "ganzomoreno": { "source": { "source": "github", "repo": "ganzomoreno/software-house" } }
  },
  "enabledPlugins": { "software-house@ganzomoreno": true }
}
```

Da lì vale per ogni sessione su quel progetto: locale, cloud, qualunque macchina, chiunque nel team. **È il motivo per cui questo repository è pubblico**: se fosse privato, le sessioni di chi non vi ha accesso fallirebbero il download.

---

## Cosa c'è dentro

```
plugins/software-house/
├── agents/          i cinque ruoli
├── skills/pipeline/ il flusso: tier, cancelli, autonomia di Silvana
└── hooks/           checklist all'avvio + promemoria del cancello sul commit
```

Per il flusso completo — quando serve l'UX, quali cancelli sono obbligatori, quanto decide Silvana da sola — vedi [`skills/pipeline/SKILL.md`](plugins/software-house/skills/pipeline/SKILL.md).

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

**La linea non è netta oggi, e non deve esserlo.** Vedi la sezione successiva.

---

## 🔄 Come questo pacchetto migliora: per attrito, non per purezza

Questo metodo **dipende dal contesto per natura**, e per natura viene corretto un progetto alla volta. Quindi:

**Non si aspetta di essere puro per essere usato.** Si installa sui progetti così com'è, con dentro ancora i residui del progetto da cui nasce. L'attrito che genera **è il dato**: ogni volta che una regola non calza, quella regola ci sta dicendo di essere contesto travestito da mestiere. Da un esempio solo la genericità non si può dedurre; da tre si scopre.

**Il contesto non è sporcizia da rimuovere: è il materiale con cui il metodo si raffina.** Una regola nata da un incidente specifico è la forma grezza di una regola generale. Il lavoro non è cancellarla, è farla maturare.

**Il cricchetto che evita la discarica.** Se il contesto entra e non esce mai, questo pacchetto diventa la somma delle stranezze di tutti i progetti. La soglia che lo impedisce:

> **Una regola entra qui quando è stata utile su almeno DUE progetti.**
> Su uno solo, resta nel progetto.

È l'unico vincolo che rende la direzione convergente invece che accumulativa.

**Conseguenza:** non esiste una "v1.0 stabile". Non c'è un traguardo, c'è un livello di pulizia che sale. Il numero di versione è un'etichetta, non una promessa. Dichiarare "finito" un metodo di lavoro sarebbe l'unico vero errore.

*(Modello di evoluzione deciso dal Business il 2026-08-03, e sostituisce l'inquadramento precedente — "versione zero da validare prima di usarla" — che aveva la direzione invertita.)*

---

*Metodo costruito sul progetto Karica, 2026. Manutenuto da [@ganzomoreno](https://github.com/ganzomoreno).*
