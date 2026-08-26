# 🎒 Software house portatile

> **A cosa serve:** portare su qualunque progetto lo stesso metodo di sviluppo — cinque ruoli, una pipeline, dei cancelli obbligatori — aggiornabile da un punto solo.
> **Per chi:** chi apre una sessione di sviluppo, su un progetto qualsiasi.
> Ultimo aggiornamento: 2026-08-26

Una squadra di sviluppo che **si porta con sé**: cinque ruoli specializzati, una pipeline e dei cancelli obbligatori, disponibili su **qualunque progetto**, aggiornabili da un punto solo.

Non è una raccolta di suggerimenti: è un **metodo di lavoro**, quello che su Karica è stato costruito e corretto sul campo, ripulito da tutto ciò che era specifico di quel progetto.

> 📖 **Il manuale completo è [`docs/MANUALE.md`](docs/MANUALE.md)**: come funziona la squadra, cosa fa ognuno, le dodici discipline con esempi, i meccanismi, l'installazione. È scritto **a cipolla**: lo Strato 0 si legge in un minuto, l'Appendice contiene ogni dettaglio.
>
> 📐 Il **perché** di tutto questo, e il piano, stanno in [`docs/METODO.md`](docs/METODO.md).

---

## 🔴 La regola zero: si lavora in silenzio, si risponde una volta sola

Il Business lancia un comando e **torna dopo** — a volte minuti, a volte ore. Quindi si lavora senza commentare, e alla fine arriva **una risposta sola**, in elenchi puntati: prima cosa serve da lui, poi cosa è stato fatto. Il ragionamento sta nei documenti, con il link.

> **Il metro:** torna dopo tre ore e legge. Deve capire in trenta secondi.

Testo integrale e motivazione: [`docs/METODO.md` § 0](docs/METODO.md).

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

> 👥 **Per sapere chi chiamare e con quali parole**, ogni ruolo è descritto in [`docs/MANUALE.md` § Strato 3](docs/MANUALE.md): cosa fa, quando si chiama, cosa restituisce, quali discipline ha in dotazione.

---

## Come si installa

Dalla cartella principale del progetto:

```bash
curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/collega.sh | bash
```

Aggancia la software house come **sottomodulo** e crea dei **collegamenti** in `.claude/`. Nella storia del progetto entrano un puntatore e dei collegamenti — meno di 2 KB — **non i file**. Aggiornare significa spostare il puntatore:

```bash
bash .software-house/scripts/collega.sh --aggiorna
```

Poi commit, e **una sessione nuova**.

> Se l'ambiente non regge collegamenti o sottomoduli, c'è il ripiego che funziona sempre: `scripts/installa.sh` copia i file dentro il progetto. Confronto fra i due in [`docs/MANUALE.md` § 6.2](docs/MANUALE.md).

> 🚀 **Istruzioni complete**, con l'adattamento al contesto del progetto: [`docs/AVVIO-SU-UN-PROGETTO.md`](docs/AVVIO-SU-UN-PROGETTO.md).

### Perché non dal marketplace

Claude Code prevede la dichiarazione del marketplace nel `settings.json` del progetto. **Non installa davvero il plugin**: difetto noto ([issue #32606](https://github.com/anthropics/claude-code/issues/32606), chiusa senza intervento), più il vincolo che `extraKnownMarketplaces` richiede che la cartella sia dichiarata affidabile — passaggio che in cloud spesso non avviene.

Il sintomo è ingannevole: la sessione parte, il `CLAUDE.md` viene letto, altri plugin risultano caricati, ma dei cinque agenti non c'è traccia. Dettagli in [`docs/MANUALE.md` § 6.3](docs/MANUALE.md).

---

## Cosa c'è dentro

```
plugins/software-house/
├── agents/                            i cinque ruoli
├── skills/pipeline/                   il flusso: tier, cancelli, autonomia di Silvana
│
│   ── nove discipline di ruolo ──
├── skills/interfacce-usabili/         ux · i cinque stati, il pavimento di accessibilità, i moduli
├── skills/parole-nell-interfaccia/    ux · etichette, errori, stati vuoti, bottoni che dicono cosa fanno
├── skills/criteri-di-accettazione/    analista · la forma SE/ALLORA, le parole vietate, i criteri negativi
├── skills/modello-dei-dati/           analista · entità, cardinalità, cancellazione, dati copiati
├── skills/macchine-a-stati/           analista · la griglia delle transizioni, incluse quelle vietate
├── skills/regole-di-business/         analista · tabelle di decisione, completezza, precedenza
├── skills/codice-verificabile/        developer · separare la logica dal mondo, i numeri con la baseline
├── skills/casi-di-prova/              test-farm · classi, bordi, la famiglia del nulla, le transizioni vietate
├── skills/revisione-onesta/           code-reviewer · cosa merita un rosso, le trappole da entrambi i lati
│
│   ── tre trasversali, per chi tocca il codice ──
├── skills/verifica-per-mutazione/     come si prova che un test intercetta davvero il difetto
├── skills/migrazioni-database/        migrazioni senza perdere un presidio: numerazione, forward-only, guard test
├── skills/sicurezza-database/         le trappole ricorrenti delle policy e delle funzioni privilegiate
└── hooks/                             checklist all'avvio + promemoria del cancello sul commit
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
