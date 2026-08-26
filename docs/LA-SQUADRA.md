# La squadra — chi c'è, cosa fa, come si chiama

> **A cosa serve questo documento:** sapere chi puoi chiamare, per cosa, e con quali parole.
> **Per chi:** il Business, quando vuole indirizzare il lavoro invece di lasciar decidere Silvana.
> Ultimo aggiornamento: 2026-08-26 · plugin v0.4.0

---

## Prima di tutto: le tre parole che confondono

| Parola | Cos'è davvero | Esempio |
|---|---|---|
| **Agente** | Una **persona finta** con un mestiere. La chiami, lavora per conto suo, torna con un risultato. | il `developer` |
| **Skill** | Un **manuale di mestiere**. Non lavora da sola: la apre un agente quando le serve. | `migrazioni-database` |
| **Hook** | Un **cancello automatico**. Scatta da solo, nessuno lo può dimenticare. | il promemoria prima del commit |

La differenza che conta: **un agente lo chiami, una skill la apre l'agente**. Attenzione: dentro un agente le skill **non si accendono da sole** — vanno precaricate o richiamate per nome. È il punto spiegato in fondo, nella *manopola del costo*.

---

## Silvana — chi è

Silvana **non è un agente**: è la sessione con cui parli. È il capoprogetto.
Riceve la tua richiesta, decide di che livello è, e chiama gli specialisti nell'ordine giusto.
Da sola esegue solo i lavori banali (una parola da cambiare, un file di configurazione).

Se tu non dici niente, **sceglie lei**. Se tu dici un nome, **usa quello**.

---

## I cinque specialisti

### 1. `ux-designer` — quello che guarda con gli occhi dell'utente

**Cosa fa.** Guarda una schermata e dice cosa non funziona per chi la usa: cosa non si capisce, quanti passi di troppo servono, cosa succede su telefono. Poi propone come rifarla.

**Quando lo chiami.** Nuova schermata, ridisegno di una sezione, "questa pagina è confusa", nuovo percorso per l'utente.

**Cosa ti restituisce.** Una nota di design: i problemi ordinati per gravità (🔴 blocca / 🟡 rallenta / 🟢 rifinitura), la proposta in tre righe, e cosa serve decidere prima di partire.

**Cosa NON fa.** Non scrive codice. Mai.

**Disciplina in dotazione (sempre attiva):** `interfacce-usabili` — le regole verificabili di una schermata che funziona.

---

### 2. `analista-funzionale` — quello che trasforma la richiesta in un contratto

**Cosa fa.** Prende quello che hai chiesto a parole e lo trasforma in un elenco numerato di frasi verificabili: *"SE succede questo, ALLORA deve accadere quello"*. Ogni frase ha un codice (AC1, AC2...). Quel codice diventa il contratto: chi implementa lo segue, chi testa lo cita nel nome del test, chi revisiona lo spunta.

**Quando lo chiami.** Prima di ogni funzione nuova o cambio di comportamento. È il **primo passo** di ogni lavoro non banale.

**Cosa ti restituisce.** Un documento di specifica: com'è oggi (con i riferimenti verificati), cosa deve cambiare, i criteri numerati, i file toccati, cosa resta fuori.

**Cosa NON fa.** Non implementa. E se la tua richiesta è ambigua **non sceglie in silenzio**: ti mette davanti le alternative.

**Disciplina in dotazione (sempre attiva):** `criteri-di-accettazione` — come si scrive una frase che due persone non possono leggere in due modi.

---

### 3. `developer` — quello che scrive il codice

**Cosa fa.** Implementa i criteri dell'analista, uno per uno. Non decide il comportamento: aderisce. Poi verifica con i controlli automatici e **riporta i numeri veri** (quanti test passavano prima, quanti ora, e perché è cambiato).

**Quando lo chiami.** Dopo che esiste una specifica. Se la specifica non c'è, si ferma e lo dice — implementare senza criteri significa inventarli.

**Cosa ti restituisce.** L'elenco dei file toccati, cosa ha aggiunto, gli esiti numerici delle verifiche, e quali criteri lascia a chi testa.

**Cosa NON fa.** **Non scrive i propri test** (li scrive la test-farm) e **non fa commit**. È il principio che regge tutto: chi giudica non è chi esegue.

**Disciplina in dotazione (sempre attiva):** `codice-verificabile` — come si scrive codice che qualcun altro possa dimostrare.

**In più, aperte per nome quando servono:** `migrazioni-database` se tocca il database, `sicurezza-database` se tocca permessi o ruoli.

---

### 4. `test-farm` — quella che scrive i test

**Cosa fa.** Scrive i test partendo **dai criteri, non dal codice**. È la differenza che conta: chi parte dal codice scrive test che fotografano quello che il codice fa — bug compresi. Quando la specifica riguarda ciò che l'utente vede, apre davvero il browser e guarda (le credenziali le digiti tu, non le tocca lei).

**Quando la chiami.** Dopo il developer, su ogni lavoro che tocca la logica.

**Cosa ti restituisce.** Quanti test ha aggiunto, gli esiti reali con il confronto rispetto a prima, quali criteri sono coperti — **e cosa non è riuscita a verificare**, dichiarato invece che nascosto.

**Cosa NON fa.** Non tocca mai il codice di produzione, solo i file di test. E non fabbrica dati per far comparire il risultato atteso.

**Discipline in dotazione (sempre attive):** `casi-di-prova` — quali casi scegliere; e `verifica-per-mutazione` — come provare che i test mordano davvero.

---

### 5. `code-reviewer` — il cancello

**Cosa fa.** Guarda le modifiche prima che vengano salvate e emette un **verdetto**: APPROVATO / APPROVATO CON RISERVE / DA RILAVORARE. Non è un parere: `DA RILAVORARE` significa che non si va avanti finché i problemi rossi non sono chiusi. Non si fida di quello che gli altri dichiarano: se un test dice di proteggere qualcosa, lui rompe il codice apposta per vedere se il test se ne accorge davvero.

**Quando lo chiami.** **Prima di ogni salvataggio** su lavori non banali. È obbligatorio, non facoltativo.

**Cosa ti restituisce.** Il verdetto, i rilievi divisi per gravità con il punto esatto (file e riga), i numeri veri delle verifiche, e una lista di correzioni pronte da girare a chi ha implementato.

**Cosa NON fa.** Non applica lui le correzioni. Emette il giudizio, il lavoro torna a chi l'ha fatto.

**Discipline in dotazione (sempre attive):** `revisione-onesta` — come non sbilanciarsi né verso il sì né verso il no; e `verifica-per-mutazione` — con cui smaschera i test che non mordono.

---

## Le otto discipline

Sono **manuali, non persone**. Ognuna nasce da un errore vero — pagato su un progetto, non immaginato.

Si dividono in due gruppi: **cinque di ruolo**, una per ciascuno dei cinque, sempre attive dentro il loro mestiere; e **tre trasversali**, che riguardano chi tocca il codice e si aprono quando servono.

---

### Le cinque di ruolo

#### `interfacce-usabili` → ux-designer
**Il problema.** Il difetto di interfaccia più diffuso non è brutto: è una schermata disegnata **solo per il caso in cui tutto va bene**.
**Cosa impone.** Ogni schermata ha cinque stati, non uno — pieno, vuoto, in caricamento, in errore, troppo pieno — e tutti e cinque vanno progettati. Più un pavimento di accessibilità che non è opinabile (contrasto, dimensione dei bersagli, tastiera, etichette vere), il tempo di risposta, il comportamento su schermo stretto, e i moduli. Chiude con il test che separa un problema da una preferenza: *cosa non riesce a fare l'utente a causa di questo?*

#### `criteri-di-accettazione` → analista-funzionale
**Il problema.** Un criterio che due persone leggono in due modi non è un criterio: è un desiderio. E siccome quel criterio è il contratto fra chi implementa, chi prova e chi revisiona, se è ambiguo tutti e tre lavorano su tre cose diverse — senza accorgersene.
**Cosa impone.** La forma «SE… ALLORA…» con entrambe le metà osservabili dall'esterno. Un elenco di **parole vietate** (*correttamente, appropriato, intuitivo, veloce, se necessario*) con cosa scrivere al loro posto. Un criterio, un comportamento solo. E soprattutto i **criteri negativi** — chi non deve potere, cosa non deve cambiare — che quasi nessuno scrive e che sono dove vivono i guasti costosi.

#### `codice-verificabile` → developer
**Il problema.** Il lavoro non è finito quando funziona: è finito quando **qualcun altro può dimostrare che funziona**. Se chi prova non riesce a raggiungere la logica, il cancello salta — e non per colpa sua.
**Cosa impone.** Separare la decisione dal mondo: la logica in funzioni che ricevono tutto e non toccano niente, il resto intorno. Le cinque cose che rendono impossibile una prova (l'ora, il caso, la rete, lo stato nascosto, l'effetto in mezzo al calcolo). Leggere le versioni prima di usare un impianto. Non cancellare ciò che si sostituisce. E riportare i numeri **con il confronto rispetto a prima**, perché un numero da solo non dice nulla.

#### `casi-di-prova` → test-farm
**Il problema.** Sapere che un test morde non dice **quali casi mancano**. Questa disciplina copre quel buco.
**Cosa impone.** Non provare ogni valore ma ogni famiglia di valori. Concentrarsi sui **bordi**, dove si annidano quasi tutti i difetti di calcolo: il valore prima della soglia, quello esatto, quello dopo. La famiglia del nulla (assente, vuoto, solo spazi — sono cose diverse). Le transizioni **vietate**, non solo quelle permesse. E l'ultimo giro: cosa farà davvero una persona che non ha letto la specifica.

#### `revisione-onesta` → code-reviewer
**Il problema.** Una revisione può fallire in due direzioni e **costano uguale**: approvare un difetto manda in produzione un guasto; bloccare su un gusto ferma il lavoro e brucia la fiducia nel cancello, così la volta dopo nessuno lo prende sul serio.
**Cosa impone.** Un rosso richiede un difetto dimostrabile, di quattro tipi soli. Poi le trappole, elencate da entrambi i lati: quelle che spingono a dire di sì (arrivare al diff già con la conclusione di chi l'ha scritto, fidarsi di «ho verificato», stancarsi a metà) e quelle che spingono a dire di no (il gusto, il rifacimento mascherato da rilievo, il rosso per prudenza quando non si è capito). E il campanello d'allarme: **due giri di fila senza nulla di concreto significa che stai validando, non dubitando.**

---

### Le tre trasversali

#### `verifica-per-mutazione`
**Il problema.** Un test verde non dimostra che il codice funziona. Dimostra che il test passa.
**Cosa impone.** Rompere il codice di proposito e controllare che il test se ne accorga, poi riportare i numeri — *«venti mutazioni applicate, venti intercettate»*. Senza numeri non è una verifica: è un'affermazione.
**Chi ce l'ha:** `test-farm` e `code-reviewer`, sempre attiva.

#### `migrazioni-database`
**Il problema.** Riscrivere una parte del database partendo da una versione vecchia, e cancellare senza accorgersene una protezione che qualcuno aveva aggiunto dopo. È già costato una riparazione d'emergenza su un progetto vero.
**Cosa impone.** Guardare qual è davvero l'ultima versione prima di riscrivere, non tornare mai indietro, e rispondere per iscritto a una domanda sola: *quale protezione c'era prima e non c'è nella mia?*
**Chi la apre:** `developer` e `code-reviewer`, quando il lavoro tocca il database.

#### `sicurezza-database`
**Il problema.** Proteggere una cosa solo nell'applicazione, lasciandola aperta a chi chiama il sistema da fuori saltando l'interfaccia.
**Cosa impone.** La regola vive nel database, non nello schermo. Se una cosa non deve essere possibile, deve essere **impossibile** — anche con una chiamata diretta e un accesso valido.
**Chi la apre:** `developer` e `code-reviewer`, quando il lavoro tocca permessi, ruoli o policy.

---

## Come li chiami tu, in pratica

Non serve una sintassi speciale. Basta il nome.

- *"Fai fare l'analisi all'**analista-funzionale**, poi fermati e fammi vedere i criteri."*
- *"Chiama l'**ux-designer** su questa schermata prima di toccare qualsiasi cosa."*
- *"Passa dal **code-reviewer** prima di committare."* (è comunque obbligatorio, ma puoi ricordarlo)
- *"Fai coprire questo dalla **test-farm**, voglio i numeri."*
- *"Questo è banale, fallo tu."* (a Silvana — salta la squadra)

E il contrario, quando vuoi accelerare:
- *"È una modifica da niente, non serve tutta la pipeline."*

---

## La manopola del costo — tre livelli, non uno

Un agente parte con un contesto **vuoto**: vede il suo prompt, la consegna, e nient'altro. In particolare **non vede l'elenco delle skill disponibili nella sessione**. Questo cambia tutto: una skill che sta lì fuori, per lui, non esiste — a meno che qualcuno gliela metta in mano.

Ci sono tre modi per fargliela avere, e costano in modo diverso.

| Livello | Come funziona | Quanto costa | Quando si usa |
|---|---|---|---|
| **1 · Precaricata** | Il testo completo della disciplina entra nell'agente **all'avvio, sempre** | Si paga a ogni chiamata, anche quando non serve | Solo per ciò che serve **sempre** a quel mestiere |
| **2 · Richiamata dal prompt** | Il prompt dell'agente dice: *«se tocchi il database, apri `migrazioni-database`»* | Si paga **solo** quando la condizione scatta | Discipline che servono **a volte** |
| **3 · Nominata nella consegna** | Silvana (o tu) scrive nella richiesta: *«usa la disciplina X»* | Si paga solo quella volta | Quando decidi tu, caso per caso |

**Il terzo livello è la tua manopola.** Puoi sempre dire: *«fai fare la review al code-reviewer, e digli di usare `sicurezza-database`»*. La consegna arriva dentro l'agente, quindi l'istruzione funziona.

E puoi anche lasciar decidere Silvana: lei vede il lavoro, sa cosa tocca, e può nominare la disciplina giusta quando delega.

---

## Cosa NON abbiamo installato, e perché

**Le skill di sicurezza esterne** (`security-guidance` e simili, dal catalogo ufficiale Anthropic): **non installate**.

Il motivo: su Karica l'infrastruttura e la sicurezza di sistema sono in mano agli sviluppatori esterni. Installarle qui significherebbe pagare un costo su **ogni** sessione di **ogni** progetto per un controllo che non ci compete. La regola del pacchetto è chiara: una cosa entra quando ha dimostrato di servire, non prima.

> ⚠️ **Attenzione a non confondere due cose diverse.** La sicurezza *dell'infrastruttura* (server, rete, segreti) è dei ragazzi esterni. La sicurezza *del codice che scriviamo noi* — permessi, ruoli, policy sui dati — resta nostra, ed è coperta dalla skill `sicurezza-database`. Quella non si tocca.

Se un domani su un secondo progetto la sicurezza applicativa tornasse in casa, si riapre la discussione.

---

*Documento di mestiere. Il contesto specifico di ogni progetto — rami, stack, chi sono gli sviluppatori esterni — resta nel progetto.*
