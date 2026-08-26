# La squadra — chi c'è, cosa fa, come si chiama

> **A cosa serve questo documento:** sapere chi puoi chiamare, per cosa, e con quali parole.
> **Per chi:** il Business, quando vuole indirizzare il lavoro invece di lasciar decidere Silvana.
> Ultimo aggiornamento: 2026-08-26

---

## Prima di tutto: le tre parole che confondono

| Parola | Cos'è davvero | Esempio |
|---|---|---|
| **Agente** | Una **persona finta** con un mestiere. La chiami, lavora per conto suo, torna con un risultato. | il `developer` |
| **Skill** | Un **manuale di mestiere**. Non lavora da sola: la apre un agente quando le serve. | `migrazioni-database` |
| **Hook** | Un **cancello automatico**. Scatta da solo, nessuno lo può dimenticare. | il promemoria prima del commit |

La differenza che conta: **un agente lo chiami, una skill si accende da sola** quando il lavoro la riguarda.

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

**Skill in dotazione.** Nessuna — lavora su ciò che vede, non su una disciplina tecnica.

---

### 2. `analista-funzionale` — quello che trasforma la richiesta in un contratto

**Cosa fa.** Prende quello che hai chiesto a parole e lo trasforma in un elenco numerato di frasi verificabili: *"SE succede questo, ALLORA deve accadere quello"*. Ogni frase ha un codice (AC1, AC2...). Quel codice diventa il contratto: chi implementa lo segue, chi testa lo cita nel nome del test, chi revisiona lo spunta.

**Quando lo chiami.** Prima di ogni funzione nuova o cambio di comportamento. È il **primo passo** di ogni lavoro non banale.

**Cosa ti restituisce.** Un documento di specifica: com'è oggi (con i riferimenti verificati), cosa deve cambiare, i criteri numerati, i file toccati, cosa resta fuori.

**Cosa NON fa.** Non implementa. E se la tua richiesta è ambigua **non sceglie in silenzio**: ti mette davanti le alternative.

**Skill in dotazione.** Nessuna precaricata.

---

### 3. `developer` — quello che scrive il codice

**Cosa fa.** Implementa i criteri dell'analista, uno per uno. Non decide il comportamento: aderisce. Poi verifica con i controlli automatici e **riporta i numeri veri** (quanti test passavano prima, quanti ora, e perché è cambiato).

**Quando lo chiami.** Dopo che esiste una specifica. Se la specifica non c'è, si ferma e lo dice — implementare senza criteri significa inventarli.

**Cosa ti restituisce.** L'elenco dei file toccati, cosa ha aggiunto, gli esiti numerici delle verifiche, e quali criteri lascia a chi testa.

**Cosa NON fa.** **Non scrive i propri test** (li scrive la test-farm) e **non fa commit**. È il principio che regge tutto: chi giudica non è chi esegue.

**Skill in dotazione.** Nessuna precaricata, ma si accendono da sole quando il lavoro le tocca:
- tocca il database → si apre `migrazioni-database`
- tocca permessi, ruoli o policy → si apre `sicurezza-database`

---

### 4. `test-farm` — quella che scrive i test

**Cosa fa.** Scrive i test partendo **dai criteri, non dal codice**. È la differenza che conta: chi parte dal codice scrive test che fotografano quello che il codice fa — bug compresi. Quando la specifica riguarda ciò che l'utente vede, apre davvero il browser e guarda (le credenziali le digiti tu, non le tocca lei).

**Quando la chiami.** Dopo il developer, su ogni lavoro che tocca la logica.

**Cosa ti restituisce.** Quanti test ha aggiunto, gli esiti reali con il confronto rispetto a prima, quali criteri sono coperti — **e cosa non è riuscita a verificare**, dichiarato invece che nascosto.

**Cosa NON fa.** Non tocca mai il codice di produzione, solo i file di test. E non fabbrica dati per far comparire il risultato atteso.

**Skill in dotazione (precaricata):** `verifica-per-mutazione` — sempre attiva, perché è il cuore del suo mestiere.

---

### 5. `code-reviewer` — il cancello

**Cosa fa.** Guarda le modifiche prima che vengano salvate e emette un **verdetto**: APPROVATO / APPROVATO CON RISERVE / DA RILAVORARE. Non è un parere: `DA RILAVORARE` significa che non si va avanti finché i problemi rossi non sono chiusi. Non si fida di quello che gli altri dichiarano: se un test dice di proteggere qualcosa, lui rompe il codice apposta per vedere se il test se ne accorge davvero.

**Quando lo chiami.** **Prima di ogni salvataggio** su lavori non banali. È obbligatorio, non facoltativo.

**Cosa ti restituisce.** Il verdetto, i rilievi divisi per gravità con il punto esatto (file e riga), i numeri veri delle verifiche, e una lista di correzioni pronte da girare a chi ha implementato.

**Cosa NON fa.** Non applica lui le correzioni. Emette il giudizio, il lavoro torna a chi l'ha fatto.

**Skill in dotazione (precaricata):** `verifica-per-mutazione` — sempre attiva: è lo strumento con cui smaschera i test che non mordono.

---

## Le tre discipline (skill)

Sono manuali, non persone. Ognuna nasce da un errore vero, pagato su un progetto.

### `verifica-per-mutazione`
**Il problema che risolve:** un test verde non dimostra che il codice funziona, dimostra che il test passa.
**Cosa impone:** rompere il codice di proposito e controllare che il test se ne accorga — poi riportare i numeri (*"20 mutazioni applicate, 20 intercettate"*). Senza numeri, non è una verifica: è un'affermazione.
**Chi la usa:** `test-farm` e `code-reviewer`, **sempre** (precaricata).

### `migrazioni-database`
**Il problema che risolve:** riscrivere una parte del database partendo da una versione vecchia, e cancellare senza accorgersene una protezione che qualcuno aveva aggiunto dopo. È già costato una riparazione d'emergenza su un progetto vero.
**Cosa impone:** guardare qual è davvero l'ultima versione prima di riscrivere, non tornare mai indietro, ed elencare per nome le protezioni conservate.
**Chi la usa:** `developer` e `code-reviewer`, **quando il lavoro tocca il database**.

### `sicurezza-database`
**Il problema che risolve:** proteggere una cosa solo nell'applicazione, lasciandola aperta a chi chiama il sistema da fuori.
**Cosa impone:** la regola vive nel database, non nello schermo. Se una cosa non deve essere possibile, deve essere *impossibile*, anche saltando l'interfaccia.
**Chi la usa:** `developer` e `code-reviewer`, **quando il lavoro tocca permessi, ruoli o policy**.

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

## Cosa NON abbiamo installato, e perché

**Le skill di sicurezza esterne** (`security-guidance` e simili, dal catalogo ufficiale Anthropic): **non installate**.

Il motivo: su Karica l'infrastruttura e la sicurezza di sistema sono in mano agli sviluppatori esterni. Installarle qui significherebbe pagare un costo su **ogni** sessione di **ogni** progetto per un controllo che non ci compete. La regola del pacchetto è chiara: una cosa entra quando ha dimostrato di servire, non prima.

> ⚠️ **Attenzione a non confondere due cose diverse.** La sicurezza *dell'infrastruttura* (server, rete, segreti) è dei ragazzi esterni. La sicurezza *del codice che scriviamo noi* — permessi, ruoli, policy sui dati — resta nostra, ed è coperta dalla skill `sicurezza-database`. Quella non si tocca.

Se un domani su un secondo progetto la sicurezza applicativa tornasse in casa, si riapre la discussione.

---

*Documento di mestiere. Il contesto specifico di ogni progetto — rami, stack, chi sono gli sviluppatori esterni — resta nel progetto.*
