---
name: parole-nell-interfaccia
description: Come si scrivono le parole di un'interfaccia — etichette, bottoni, messaggi di errore, stati vuoti, conferme, testi di attesa. Il vocabolario di chi usa contro quello di chi costruisce. Da usare quando si progetta o si revisiona una schermata, o quando si deve scrivere il testo di un messaggio che l'utente leggerà.
---

# Parole nell'interfaccia

> Le parole di un'interfaccia **non sono decorazione: sono la parte del prodotto con cui l'utente ragiona.**
> Un bottone chiamato male costa più di un colore sbagliato — e nessuno lo segnala mai come difetto, perché sembra un dettaglio.

## 1. ⭐ Il vocabolario è quello di chi usa, non quello di chi costruisce

Il difetto numero uno: l'interfaccia parla la lingua del database.

| ❌ Come lo chiama il sistema | ✅ Come lo chiama la persona |
|---|---|
| Configurazione webhook | Notifiche |
| Entità utente non valorizzata | Non hai ancora aggiunto nessuno |
| Sincronizzazione fallita | Non siamo riusciti a scaricare i tuoi ordini |
| Record persistito | Salvato |
| Autenticazione non autorizzata | Email o password non corrette |

**La prova:** leggi la frase ad alta voce a qualcuno che non lavora al progetto. Se chiede «cosa vuol dire?», riscrivila.

## 2. I bottoni dicono cosa succede, non «ok»

Un bottone è un **verbo all'infinito o all'imperativo**, e nomina l'azione che compie.

- ❌ `OK` · `Conferma` · `Invia` (invia cosa? a chi?)
- ✅ `Pubblica l'articolo` · `Elimina 3 elementi` · `Invita Marco`

Nelle finestre di conferma vale doppio, perché è lì che si sbaglia:

> ❌ *«Sei sicuro?»* → `Annulla` / `OK`
> ✅ *«Elimini definitivamente la fattura 2026/114? Non si può recuperare.»* → `Non eliminare` / `Elimina la fattura`

**Nessuno dei due bottoni dice "sì" o "no":** dicono cosa faranno. Così chi ha cliccato per sbaglio se ne accorge prima, non dopo.

E dopo l'azione, **il riscontro usa lo stesso verbo**: premi `Pubblica`, compare `Pubblicato`. Un verbo diverso fa dubitare che sia successa la cosa giusta.

## 3. Gli errori: cosa è successo, e come si ripara

Un messaggio d'errore ha **tre pezzi**, e quasi sempre ne ha uno solo.

1. **Cosa è successo**, in termini che l'utente riconosce.
2. **Perché**, se lo sappiamo e se è utile.
3. **Cosa fare adesso** — la parte che manca sempre.

> ❌ *«Errore di validazione.»*
> ❌ *«Data non valida.»*
> ✅ *«La data di scadenza è precedente a quella di emissione. Correggi una delle due per continuare.»*

Regole che tengono:
- **Niente scuse, niente colpe.** Non «Ci scusiamo per il disagio», non «Hai inserito un valore errato». Solo il fatto e la via d'uscita.
- **Niente codici da soli.** Un codice tecnico può stare, ma **accanto** alla frase in italiano, piccolo, per chi deve segnalarlo.
- **L'errore sta accanto alla cosa che lo ha causato**, non in cima alla pagina.
- **Mai un errore che accusa senza spiegare il formato**: non «Numero non valido» ma «Usa solo cifre, senza punti».

## 4. Gli stati vuoti sono la prima schermata che vede chi arriva

Uno stato vuoto scritto male è un vicolo cieco; scritto bene è il miglior momento di insegnamento del prodotto. Tre pezzi:

1. **Perché è vuoto** — «Non hai ancora creato nessuna fattura».
2. **Perché vale la pena riempirlo** — una riga sola, il beneficio, non la funzione.
3. **L'azione**, come bottone — «Crea la prima fattura».

E vanno distinti due vuoti diversi, che quasi tutti trattano uguale:

| Vuoto | Cosa dire |
|---|---|
| **Non c'è ancora niente** (primo accesso) | invito a cominciare, con l'azione |
| **La ricerca non ha trovato nulla** | cosa si è cercato, e come allargare — «Nessun risultato per *fattur*. Prova con meno lettere o togli i filtri.» |

Il secondo caso deve **sempre** offrire il modo di tornare indietro: togliere i filtri, azzerare la ricerca.

## 5. Etichette e testi di aiuto

- **L'etichetta sta sopra il campo e resta visibile.** Il testo dentro il campo sparisce appena si scrive: chi si distrae non sa più cosa stava compilando.
- **L'etichetta è un sostantivo, breve**: `Data di scadenza`, non `Inserisci qui la data di scadenza`.
- **Il formato si dichiara prima, non dopo l'errore**: sotto il campo, `gg/mm/aaaa`.
- **L'obbligatorietà si segna una volta sola** e coerentemente. Se quasi tutti i campi sono obbligatori, segna gli **opzionali** — è meno rumore.
- **Niente domande retoriche come etichette**: non «Vuoi ricevere le notifiche?» ma «Notifiche via email», con l'interruttore.

## 6. Il tempo e i numeri, scritti come li legge una persona

- **Le date relative solo quando aiutano**: «2 ore fa» va bene in una lista di attività; su una fattura serve la data esatta. Nel dubbio, la data esatta con la relativa accanto.
- **Mai un fuso ambiguo** su qualcosa che scade: «entro il 31/12 alle 23:59 (ora italiana)».
- **I numeri grandi si separano** e portano l'unità: `1.240 ordini`, non `1240`.
- **Zero non è vuoto**: «0 ordini» è un'informazione, uno spazio bianco è un dubbio.
- **Singolare e plurale veri**: «1 elemento selezionato», «3 elementi selezionati». Mai «1 elemento(i)».

## 7. Le parole di attesa

- Sotto un secondo: nessun testo, solo il segno visivo.
- Oltre: **dì cosa sta facendo**, non «Caricamento…». → «Sto scaricando gli ordini di marzo…»
- Oltre i dieci secondi: **dì a che punto è** o quanto manca. Un'attesa muta e lunga viene letta come «si è bloccato», e la persona ricarica — spesso duplicando l'operazione.

## Checklist prima di consegnare la nota di design

- [ ] Nessuna parola presa dal database o dal codice è rimasta a video
- [ ] Ogni bottone nomina l'azione; nelle conferme, **entrambi** i bottoni la nominano
- [ ] Il riscontro dopo l'azione usa lo stesso verbo del bottone
- [ ] Ogni errore dice cosa è successo **e cosa fare adesso**, accanto al campo giusto
- [ ] I due stati vuoti (mai avuto / nessun risultato) sono distinti e hanno una via d'uscita
- [ ] Le etichette stanno sopra i campi e restano visibili; il formato è dichiarato prima
- [ ] Date con fuso dove scade qualcosa; numeri con separatori e unità; plurali veri
- [ ] I testi di attesa dicono **cosa** sta succedendo
