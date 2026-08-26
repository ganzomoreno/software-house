# Manuale della software house portatile

> **Cos'è questo documento.** Il manuale tecnico-funzionale completo: come funziona la squadra, cosa fa ognuno, quali discipline possiede, come si installa, come si estende.
> **Com'è fatto.** A cipolla: ogni strato è più profondo del precedente. Fermati quando ti basta. Lo **Strato 0** si legge in un minuto; l'**Appendice** contiene ogni dettaglio.
> **Per chi.** Il Business che vuole capire e spiegare · chi apre una sessione e deve lavorare · chi vuole estendere il metodo.
> Ultimo aggiornamento: 2026-08-26 · plugin v0.11.0

**Documenti collegati:** il *perché* di tutto questo, e il piano, stanno in [`METODO.md`](METODO.md). Il modello da compilare su ogni progetto è [`../templates/CONTESTO-PROGETTO.md`](../templates/CONTESTO-PROGETTO.md).

---

# Strato 0 — In un minuto

Una **squadra di sviluppo che si porta con sé**, da installare su qualunque progetto.

Cinque specialisti, ognuno con un mestiere e dei confini netti. Li coordina la sessione principale, che chiamiamo **Silvana**. Ognuno possiede delle **discipline**: manuali di mestiere che nascono da errori veri, già pagati.

Il principio che regge tutto:

> ### Chi giudica non è chi esegue.

Chi scrive il codice non scrive i test che lo promuovono, e non firma la propria revisione. Ogni separazione di ruolo esiste per questo — non per specializzazione tecnica.

**Il giro di un lavoro, in una riga:**

```
richiesta → [ux] → analista → developer → test-farm → code-reviewer → commit
                                                            ↑
                                              cancello: se dice DA RILAVORARE, si torna indietro
```

Non tutti i lavori fanno tutto il giro: quanto ne fanno lo decide il **tier** (Strato 2).

---

# Strato 1 — Le tre parole, e la mappa

## Le tre parole che confondono

| Parola | Cos'è davvero | Chi la attiva | Esempio |
|---|---|---|---|
| **Agente** | una **persona finta con un mestiere**: lavora per conto suo, torna con un risultato | **tu o Silvana**, chiamandolo per nome | `developer` |
| **Disciplina** (skill) | un **manuale di mestiere**: non lavora, viene consultato | **l'agente**, se ce l'ha in dotazione o se qualcuno gliela nomina | `modello-dei-dati` |
| **Cancello** (hook) | un **automatismo**: scatta da solo, nessuno può dimenticarlo | il sistema, sempre | il promemoria prima del commit |

**La differenza che conta di più:** un agente lo chiami, una disciplina *non si accende da sola dentro di lui* — va precaricata o nominata. Il perché è tecnico e sta nello **Strato 5**.

## La mappa

```
                        ┌──────────────────────────────┐
    TU (il Business) ──▶│  SILVANA — la sessione       │
                        │  orchestra · sceglie il tier │
                        │  esegue solo i lavori banali │
                        └──────┬───────────────────────┘
                               │ delega, per nome
        ┌──────────┬───────────┼───────────┬──────────────┐
        ▼          ▼           ▼           ▼              ▼
   ux-designer  analista   developer   test-farm   code-reviewer
        │          │           │           │              │
   ┌────┴───┐  ┌───┴────┐  ┌───┴───┐   ┌───┴───┐    ┌─────┴────┐
   discipline  discipline  discipline  discipline    discipline
    (2+0)       (1+4)       (1+2)       (2+3)         (2+4)
                            ▲ precaricate + apribili per nome
```

---

# Strato 2 — Come si lavora

## Silvana, il coordinatore

**Non è un agente: è la sessione con cui parli.** Riceve la richiesta, la registra, decide di che livello è, chiama gli specialisti nell'ordine, applica i cancelli.

Da sola esegue **solo i lavori banali** — una parola da cambiare, un file di configurazione. Sulle modifiche sostanziali non sostituisce gli specialisti: sarebbe esattamente la violazione del principio.

## La regola zero: niente si perde

**Ogni richiesta viene registrata subito, prima di iniziare**, in due posti: un task (così è in fila e visibile) e una voce nel registro di sviluppo del progetto (durevole). Se la richiesta contiene più cose, si spacchettano.

## I cinque livelli (tier)

Quanta pipeline serve dipende dal lavoro. **Nel dubbio fra due livelli, si sceglie il più alto.**

| Livello | Cos'è | Chi si ingaggia | Cancelli obbligatori | Chi decide |
|---|---|---|---|---|
| **0 · Triviale** | copy, una riga, documentazione, configurazione, rinomina | **Silvana da sola** | — (test se tocca logica) | Silvana |
| **1 · Bugfix** | correzione localizzata, micro-funzione già specificata | developer → code-reviewer | **code-reviewer prima del commit**; test-farm se tocca logica | Silvana |
| **2 · Funzione** | funzione nuova, cambio di logica o di flusso | analista → developer → test-farm → code-reviewer | spec con criteri · test · **code-reviewer** | Silvana (il Business se impatta il prodotto) |
| **3 · Design** | schermata nuova, ridisegno, problemi di fruibilità | **ux-designer** → analista → developer → test-farm → code-reviewer | nota di design · spec · test · **code-reviewer** · verifica a video | Silvana; il Business per brand e prodotto |
| **4 · Strutturale** | architettura, schema dati, sicurezza, normativa, priorità | **Silvana alza la mano PRIMA**, poi il livello adatto | direzione ricevuta → cancelli del livello | **il Business** (priorità) · **gli sviluppatori esterni** (architettura) |

## Quando serve l'UX, e quando no

- **Sì** (livello 3): interfaccia nuova, ridisegno, problemi di leggibilità o fruibilità, percorso utente nuovo, dubbi su gerarchia e interazione.
- **No**: correzione logica o di sistema, migrazione di dati, testo, difetto non visivo, e ogni ritocco già specificato da una nota di design esistente.

## I cancelli non negoziabili

- **`code-reviewer` prima di OGNI commit** dal livello 1 in su. Non è un parere: `DA RILAVORARE` ferma il lavoro.
- **Documentazione aggiornata mentre si lavora**, non dopo.
- **Verifica reale**: test dal livello 1 in su; verifica **a video** per il livello 3. Mai dati fabbricati per far comparire l'esito atteso.
- **Al revisore si passa l'artefatto, mai la propria conclusione.** Dargliela lo sbilancia verso l'accordo: si dà il diff e la spec, non il verdetto che ci si è già fatti.
- **Segnale d'allarme**: se in due giri consecutivi il revisore non produce nulla di azionabile, stai validando invece di dubitare. Rivedi cosa gli passi, non i suoi rilievi.

## L'autonomia di Silvana

- **Livelli 0–3**: decide ed esegue tramite il team, senza chiedere. L'autonomia è sulle **decisioni**, non sull'esecuzione: il codice sostanziale lo scrive il `developer`, lo valida il `code-reviewer`.
- **Livello 4, o qualunque scelta irreversibile o di brand**: si coinvolge il Business, e **sempre con domande a scelta multipla** (2–4 opzioni concrete, una raccomandata). Mai domande aperte. Si porta la soluzione, non il problema.
- **Architettura e infrastruttura non si fanno decidere al Business**: si prepara un'analisi con raccomandazione e si gira a chi possiede l'architettura.

## Come si risponde al Business — la regola che viene prima di tutte

Il Business lancia un comando e **torna dopo**, a volte dopo ore. Quindi:

- **Si lavora in silenzio.** Nessun messaggio intermedio, nessuna cronaca dei passi.
- **Una risposta sola, alla fine**, in elenchi puntati. Prima cosa serve da lui, poi cosa è stato fatto.
- **Il ragionamento sta nei documenti**, con il link. Non in chat.
- **Un ok su una lista è un ok su tutta la lista**: si consegna finita, non a metà.
- **Niente tabelle** nei messaggi: il suo lettore non le rende.

> **Il metro:** torna dopo tre ore e legge. Deve capire in trenta secondi.

Testo integrale e motivazione: [`METODO.md` § 0](METODO.md).

---

# Strato 3 — I cinque specialisti

Ognuno ha: un **mestiere**, dei **confini** (cosa non fa, ed è la parte importante), un **prodotto** che consegna, e delle **discipline** in dotazione.

---

## 1 · `ux-designer` — guarda con gli occhi di chi usa

**Il mestiere.** Guarda una schermata e dice cosa non funziona per chi la usa: cosa non si capisce, quanti passi di troppo servono, cosa succede su telefono, cosa succede quando non ci sono dati. Poi propone come rifarla.

**Quando si chiama.** Schermata nuova, ridisegno di una sezione, «questa pagina è confusa», percorso utente nuovo. Sempre **prima** che si scriva codice.

**Cosa consegna.** Una nota di design: i problemi ordinati per gravità (🔴 blocca / 🟡 rallenta / 🟢 rifinitura), la proposta come mockup a parole (gerarchia, cosa si vede senza scorrere, stati vuoto/attesa/errore, comportamento su schermo stretto), e cosa serve decidere prima di procedere.

**Confini.** Non scrive codice, mai. Rispetta il sistema di design esistente invece di inventare varianti. Distingue **problema** da **preferenza**: un 🔴 costa lavoro a qualcun altro.

**Obbligo di trasparenza.** Dichiara sempre **come** ha osservato: a video, dedotto dal codice, o non osservato. Un audit visto e uno dedotto sono cose diverse, e chi legge deve saperlo.

**Discipline.** Precaricate: `interfacce-usabili` · `parole-nell-interfaccia`.
**Motore.** Opus, alta intensità.

---

## 2 · `analista-funzionale` — trasforma la richiesta in un contratto

**Il mestiere.** Prende quello che è stato chiesto a parole e lo trasforma in un elenco numerato di frasi verificabili: *«SE succede questo, ALLORA deve accadere quello»*. Ogni frase ha un codice (`AC1`, `AC1.1`). Quel codice è **il contratto fra tre ruoli**: chi implementa lo segue, chi prova lo cita nel nome del test, chi revisiona lo spunta.

**Quando si chiama.** Prima di ogni funzione nuova o cambio di comportamento. È il primo passo di ogni lavoro dal livello 2 in su.

**Cosa consegna.** Un documento con struttura fissa: contesto (com'è oggi, **con le fonti citate**) · comportamento atteso · criteri numerati · file impattati · note di testabilità · cosa resta fuori scope.

**Confini.** Non implementa. Se la richiesta è ambigua **non sceglie in silenzio**: presenta le alternative e ne raccomanda una.

**Due obblighi che salvano i giri.**
- **Cita sempre la fonte** di ciò che afferma sullo stato attuale: senza riferimenti, la spec è un'opinione. Se una parte non è ispezionabile, **la dichiara non verificata** invece di dedurla.
- **Censisce tutti i punti d'ingresso.** Se cambia o rimuove un comportamento, cerca ogni strada che ci arriva. Una correzione che ne dimentica uno è una correzione che il difetto aggira.

**Discipline.** Precaricata: `criteri-di-accettazione`. Apribili per nome: `modello-dei-dati` · `macchine-a-stati` · `regole-di-business` · `migrazioni-database` · `sicurezza-database`.
**Motore.** Opus, alta intensità.

---

## 3 · `developer` — implementa esattamente quei criteri

**Il mestiere.** Implementa i criteri uno per uno. **Non decide il comportamento**: aderisce. Poi verifica con controllo tipi, lint e test, e riporta i numeri veri.

**Quando si chiama.** Dopo che esiste una specifica. Se non c'è, **si ferma e lo dice**: implementare senza criteri significa inventarli.

**Cosa consegna.** I file modificati, le firme delle funzioni chiave, gli esiti reali delle verifiche **con la baseline**, e la conferma di quali criteri sono soddisfatti e quali restano a chi prova.

**Confini.** Non scrive i propri test e **non fa commit**. È il cuore del principio: chi giudica non è chi esegue. Non esce dal perimetro assegnato senza chiedere. Se un test esistente si rompe, non lo rilassa per farlo passare.

**Obbligo.** Se scopre una **contraddizione nella specifica**, si ferma e lo dice. Non forza uno dei due criteri in silenzio: la decisione non è sua.

**Discipline.** Precaricata: `codice-verificabile`. Apribili per nome: `migrazioni-database` · `sicurezza-database`.
**Motore.** Opus.

---

## 4 · `test-farm` — scrive i test dai criteri, non dal codice

**Il mestiere.** Produce test deterministici che verificano i criteri, e li fa passare. Il principio che la distingue: **parte dai criteri, non dal codice**. Chi parte dal codice scrive test che fotografano ciò che il codice fa — difetti compresi.

**Quando si chiama.** Dopo il developer, su ogni lavoro che tocca la logica.

**I tre livelli di prova.**
1. **Unità** — il predefinito. La logica pura, casi limite inclusi.
2. **Verifica a video** — quando la specifica riguarda ciò che l'utente vede. **Le credenziali le digita l'utente**: l'agente porta il browser alla pagina di accesso, chiede, e riprende da pagina autenticata.
3. **Guard statico** — per ciò che non si può eseguire (SQL, vincoli su file, invarianti di struttura): legge il file e asserisce sui presidi, citando il criterio nel nome del test.

**Cosa consegna.** Quanti test ha aggiunto, gli esiti con baseline e delta, i criteri coperti, le evidenze della verifica a video — **e cosa non ha potuto verificare**, dichiarato invece che omesso.

**Confini.** Modifica **solo** file di test. Mai il codice di produzione, mai le pagine. Niente commit.

**Il divieto dei dati fabbricati.** Mai falsare lo stato per far comparire l'esito atteso. La linea: dare a un utente di prova lo stato di un utente **legittimo** è ammesso — l'esito resta calcolato dal sistema reale. Inserire **l'esito stesso** che il test dovrebbe dimostrare, no.
> Regola pratica: **se la riga che stai inserendo è ciò che il test dovrebbe dimostrare, è un dato fabbricato.**

**Escalation obbligatoria.** Se l'esito atteso è irraggiungibile, distingue: ❌ **KO del test** (la funzione non si attiva) da 🐛 **difetto a monte** (il sistema non produce mai quell'esito). Sono due cose diverse e vanno a persone diverse.

**Discipline.** Precaricate: `casi-di-prova` · `verifica-per-mutazione`. Apribili: `macchine-a-stati` · `regole-di-business` · `migrazioni-database`.
**Motore.** Sonnet.

---

## 5 · `code-reviewer` — il cancello

**Il mestiere.** Esamina il diff e emette un **verdetto bloccante**: `APPROVATO` / `APPROVATO CON RISERVE` / `DA RILAVORARE`. L'ultimo significa che **non si committa** finché i 🔴 non sono chiusi.

**Quando si chiama.** Prima di ogni commit o push dal livello 1 in su. **Obbligatorio, non facoltativo.**

**Su cosa giudica.** Aderenza alla spec (ogni criterio è davvero coperto?) · correttezza (bug, casi limite, valori nulli) · regressioni e perimetro (solo i file previsti?) · qualità (duplicazione, naming, coerenza) · sicurezza (i presidi **concreti del progetto**, non una lista generica) · test (coprono davvero, o girano a vuoto?).

**Cosa consegna.** Il verdetto, i rilievi per severità con `file:riga`, gli **esiti numerici reali** delle verifiche eseguite, e una **fix-list eseguibile**: una riga per rilievo, `file:riga · cosa cambiare · criterio di riferimento`, da girare così com'è senza ritradurla.

**Confini.** Sola lettura sul codice: **non applica i fix**. Può eseguire comandi di verifica.

**Le tre regole che lo tengono onesto.**
- **Un 🔴 richiede un difetto dimostrabile**: criterio violato, bug riproducibile, regressione, presidio saltato. Un sospetto o una preferenza sono 🟡/🟢. **Bloccare sul gusto costa quanto approvare un bug.**
- **Non si fida delle dichiarazioni.** Se chi ha implementato dice «verificato», verifica lui. Se un test dice di proteggere qualcosa, lo **muta**: rompe il codice, controlla che il test fallisca, ripristina.
- **Distingue il rosso previsto dalla violazione.** Alcuni controlli falliscono di proposito: non sono difetti.

**Discipline.** Precaricate: `revisione-onesta` · `verifica-per-mutazione`. Apribili: `migrazioni-database` · `sicurezza-database` · `macchine-a-stati` · `regole-di-business`.
**Motore.** Opus, alta intensità.

---

# Strato 4 — Le dodici discipline, con esempi

Sono **manuali, non persone**. Ognuna nasce da un errore vero, pagato su un progetto — non immaginato.

Si dividono in due famiglie: **nove di ruolo**, legate a un mestiere preciso, e **tre trasversali**, che riguardano chiunque tocchi il codice.

Ogni disciplina qui sotto ha la stessa struttura: il problema che previene, cosa impone, **un esempio concreto**, e chi la possiede.

---

## Per l'`ux-designer`

### `interfacce-usabili`

**Il problema.** Il difetto di interfaccia più diffuso non è brutto: è una schermata disegnata **solo per il caso in cui tutto va bene**.

**Cosa impone.**
- Ogni schermata ha **cinque stati, non uno**: pieno, vuoto, in caricamento, in errore, troppo pieno. Tutti e cinque vanno progettati.
- Un pavimento di accessibilità che non è opinabile: contrasto 4.5:1, bersagli da 44 punti, il fuoco da tastiera sempre visibile, etichette vere, mai un'informazione affidata al solo colore.
- Il tempo fa parte del disegno: riscontro entro 0,1 s; stato di attesa oltre 1 s; il bottone si disabilita mentre lavora.
- Lo schermo stretto non è la versione ridotta: le azioni frequenti in basso, niente scorrimento orizzontale, una tabella larga si **ripensa**, non si rimpicciolisce.

**Esempio — lo stato vuoto**

> ❌ Una lista fatture vuota che mostra: *«Nessun risultato»*.
> L'utente è arrivato per lavorare e ha trovato un vicolo cieco. Non sa se è rotto, se deve aspettare, o se doveva fare qualcosa prima.
>
> ✅ *«Non hai ancora creato nessuna fattura.»*
> *«Da qui le crei, le invii e vedi quali sono state pagate.»*
> **[ Crea la prima fattura ]**
>
> Tre pezzi: perché è vuoto · perché vale la pena riempirlo · l'azione.

---

### `parole-nell-interfaccia`

**Il problema.** Le parole non sono decorazione: sono la parte del prodotto con cui l'utente ragiona. Un bottone chiamato male costa più di un colore sbagliato, e **nessuno lo segnala mai come difetto** perché sembra un dettaglio.

**Cosa impone.**
- Il vocabolario è quello di chi usa, non quello del database. La prova: leggi la frase a qualcuno che non lavora al progetto.
- I bottoni dicono **cosa succede**, non «ok». E dopo l'azione il riscontro usa **lo stesso verbo**.
- Un errore ha tre pezzi: cosa è successo · perché · **cosa fare adesso**. Il terzo manca sempre.
- Gli stati vuoti sono due e vanno distinti: «non c'è ancora niente» e «la ricerca non ha trovato nulla».

**Esempio — la finestra di conferma**

> ❌ *«Sei sicuro?»* → `[ Annulla ]` `[ OK ]`
> Sicuro di cosa? E `Annulla` annulla la fattura o annulla l'operazione? Due bottoni ambigui su un'azione irreversibile.
>
> ✅ *«Elimini definitivamente la fattura 2026/114? Non si può recuperare.»*
> `[ Non eliminare ]` `[ Elimina la fattura ]`
>
> **Nessuno dei due bottoni dice sì o no: dicono cosa faranno.** Chi ha cliccato per sbaglio se ne accorge prima, non dopo.

---

## Per l'`analista-funzionale`

### `criteri-di-accettazione`

**Il problema.** Un criterio che due persone leggono in due modi non è un criterio: è un desiderio. E siccome è il contratto fra chi implementa, chi prova e chi revisiona, se è ambiguo **tutti e tre lavorano su tre cose diverse** — senza accorgersene.

**Cosa impone.**
- La forma `SE <condizione osservabile> ALLORA <esito osservabile>`, con entrambe le metà verificabili da fuori.
- Un elenco di **parole vietate** che rendono un criterio inverificabile, con cosa scrivere al loro posto.
- Un criterio, **un solo comportamento**: la congiunzione «e» nell'esito è quasi sempre due criteri travestiti da uno.
- I **criteri negativi**: chi non deve potere, cosa non deve cambiare, quale scorciatoia non deve funzionare.

**Esempio — la riscrittura**

> ❌ *«Il sistema valida correttamente la data e mostra un errore appropriato.»*
> Due comportamenti in una frase, e due parole vietate. Chi implementa sceglie, chi prova non sa cosa provare, chi revisiona non sa cosa spuntare.
>
> ✅
> `AC3.1 · SE la data di scadenza è precedente a quella di emissione, ALLORA il modulo non viene inviato.`
> `AC3.2 · SE la data di scadenza è precedente a quella di emissione, ALLORA compare accanto al campo il testo «La scadenza non può precedere l'emissione».`
> `AC3.3 · SE il campo data è vuoto al momento dell'invio, ALLORA compare accanto al campo il testo «Inserisci una data (gg/mm/aaaa)».`
>
> Tre criteri, tre test, tre caselle. **Zero interpretazione.**

**Le parole vietate, per intero:** *correttamente · appropriato · adeguato · intuitivo · chiaro · veloce · rapido · se necessario · eventualmente · gestisce · tiene conto di · e così via · ecc.*

---

### `modello-dei-dati`

**Il problema.** **Un criterio scritto senza aver capito il modello dati è un criterio che l'implementazione non può soddisfare.** È la causa più frequente di specifica rifiutata: non era sbagliata l'idea, era impossibile la struttura.

**Cosa impone.**
- Per ogni entità: chi la possiede, la **cardinalità con i minimi**, cosa la rende unica, cosa le succede nel tempo.
- Il ciclo di vita scritto: chi crea, chi modifica, **quali campi diventano immutabili e da quando**.
- La cancellazione ha un comportamento **scelto**, non subito: blocca / trascina / slega. E: è reale o è solo una marcatura?
- Ogni dato copiato in due posti dichiara se è **fotografia** o se **si aggiorna**.

**Esempio — il minimo della cardinalità**

> ❌ *«L'ordine contiene le sue righe.»*
> Manca l'informazione che decide tutto: **può esistere un ordine senza righe?**
>
> ✅ `Ordine → Riga (1 → 1..N, mai vuoto)`
> Da questa sola riga discendono tre cose: un criterio (*«non è possibile salvare un ordine senza almeno una riga»*), un criterio negativo (*«la rimozione dell'ultima riga viene rifiutata»*), e un caso di prova sul bordo (rimuovere la penultima, poi l'ultima).
>
> Se invece fosse `0..N`, lo **stato vuoto esiste** e l'ux-designer deve disegnarlo. Una cifra, tre conseguenze.

**L'errore più costoso: la cancellazione per marcatura.** Se un record viene solo marcato come cancellato e non rimosso, **ogni singola lettura del sistema deve escluderlo**. Ogni punto che se lo dimentica è un difetto — elenchi, conteggi, esportazioni, statistiche. Va scritto come criterio esplicito, altrimenti ne restano fuori tre.

---

### `macchine-a-stati`

**Il problema.** Quasi ogni gestionale è, sotto, una macchina a stati travestita: un ordine, una pratica, un utente, un ticket. E quasi ogni specifica descrive **gli stati** dimenticando **le transizioni** — che sono dove vivono i difetti, perché nessuno le prova.

**Cosa impone.**
- L'elenco degli stati è **chiuso**, con un nome solo per stato, uno stato iniziale e degli stati finali dichiarati.
- La **griglia completa** delle transizioni: da ogni stato verso ogni stato, permesso o vietato. Le caselle vietate sono metà del contratto.
- Le quattro che nessuno prova: **il salto**, **il ritorno**, **la ripetizione**, **la partenza da uno stato finale**.
- Per ogni transizione permessa: **chi**, **quando** (la finestra), **a quali condizioni sui dati**.
- Cosa scatta al passaggio, cosa è **definitivo**, e cosa succede se un effetto **fallisce a metà**.

**Esempio — la casella vietata che diventa due criteri**

> ❌ *«Le richieste approvate vengono archiviate dopo 90 giorni.»*
> Descrive una transizione permessa. Non dice nulla delle altre venti caselle della griglia.
>
> ✅ Dalla griglia emerge la casella `Approvata → Bozza: ❌`. Diventa **due** criteri, non uno:
> `AC12 · SE una richiesta è Approvata, ALLORA il comando «riporta in bozza» non è disponibile nell'interfaccia.`
> `AC13 · SE il comando «riporta in bozza» viene inviato al sistema per una richiesta Approvata, ALLORA viene rifiutato e nessun dato cambia.`
>
> **Sono due cose diverse.** Il primo è cortesia verso l'utente; il secondo è il controllo vero, perché chi chiama il sistema direttamente il bottone non lo vede nemmeno.

**La condizione più dimenticata: quella su sé stessi.** Chi approva può approvare la *propria* richiesta? Chi assegna ruoli può togliere il *proprio*? Quasi sempre la risposta è no, e quasi mai è scritto.

---

### `regole-di-business`

**Il problema.** Una regola con **tre condizioni** ha **otto combinazioni**. Una descrizione a parole ne copre tre o quattro, e nessuno si accorge delle altre finché un cliente non ci finisce dentro.

**Cosa impone.**
- Il segnale: appena compaiono *«tranne quando»*, *«a meno che»*, *«di norma»*, la prosa non basta più. Chi parla sta comprimendo una tabella in una frase; il lavoro è riaprirla.
- La **tabella di decisione**: tutte le combinazioni, anche quelle che «non capiteranno mai».
- Due prove: **completezza** (nessun buco, incluso il caso in cui tutte le condizioni sono false) e **non contraddizione** (nessuna combinazione con due esiti).
- I dettagli che cambiano il risultato: arrotondamento, ordine delle operazioni, tetti, unità, fusi orari.

**Esempio — il buco che si vede solo in tabella**

> ❌ *«I clienti storici hanno il 10% di sconto. Sopra i 500 € si aggiunge il 5%. Durante i saldi c'è un 15% extra.»*
> Sembra completa. Non lo è.
>
> ✅ Otto righe. E la riga che nessuno aveva scritto:
>
> | storico | >500€ | saldi | sconto |
> |---|---|---|---|
> | no | no | no | **0%** ← non c'era |
>
> E la contraddizione che emerge subito: un cliente storico con un ordine da 300 € — si applica il 10% da «storico» o lo 0% da «sotto i 500»? Finché non è scritto, **vince la regola che chi implementa ha letto per ultima**.
>
> Otto righe della tabella = otto criteri numerati = otto casi di prova. Chi prova ne scrive **otto**, non «qualche caso».

---

## Per il `developer`

### `codice-verificabile`

**Il problema.** Il lavoro non è finito quando funziona: è finito quando **qualcun altro può dimostrare che funziona**. Se chi prova non riesce a raggiungere la logica, il cancello salta — e non per colpa sua.

**Cosa impone.**
- Separare **la decisione dal mondo**: la logica in funzioni che ricevono tutto come argomento e non toccano niente; il resto intorno.
- Le cinque cose che rendono impossibile una prova: l'ora corrente, la casualità, la rete, lo stato globale nascosto, l'effetto in mezzo al calcolo.
- **Versioni prima dei pattern**: leggere le dipendenze e dichiararle prima di scrivere.
- **Sostituire non è cancellare**: ciò che si rimpiazza resta conservato.
- I numeri **sempre con la baseline**: quanti passano ora, quanti prima, perché è cambiato.

**Esempio — la cucitura**

> ❌ Una funzione sola che legge il database, calcola lo sconto usando la data di oggi, e invia la mail.
> Per provarla serve un database, una rete, e **domani darà un risultato diverso**. Chi prova può solo rinunciare.
>
> ✅ Due pezzi:
> ```
> calcolaSconto(cliente, ordine, dataRiferimento) → percentuale     ← funzione pura: qui si prova
> processaOrdine(id)  → legge, chiama calcolaSconto(…, oggi), invia  ← bordo: qui non c'è logica da provare
> ```
> Le otto righe della tabella sconti diventano otto prove su `calcolaSconto`, deterministiche, che girano in un millesimo di secondo.
>
> E nella consegna il developer scrive: *«funzione pura `calcolaSconto` in `src/fatturazione/sconti.ts:12`»* — **l'aggancio con cui la test-farm la raggiunge.**

---

## Per la `test-farm`

### `casi-di-prova`

**Il problema.** Sapere che un test morde non dice **quali casi mancano**. Questa disciplina copre quel buco.

**Cosa impone.**
- **Classi di equivalenza**: non provi ogni valore, provi ogni famiglia. Un valore per famiglia.
- **I bordi**, dove si annidano quasi tutti i difetti di calcolo: `n-1`, `n`, `n+1`.
- **La famiglia del nulla**: assente, nullo, stringa vuota, solo spazi, zero, falso — sono sei cose diverse, e il codice spesso le tratta in tre modi diversi.
- Le **transizioni vietate**, non solo quelle permesse.
- L'ultimo giro: cosa farà davvero una persona che non ha letto la specifica.

**Esempio — dove si nasconde il difetto**

> ❌ *«Ho provato lo sconto per fasce: 10 anni, 30 anni, 70 anni. Tre casi, tre fasce, tutto verde.»*
> Tre prove che passeranno sempre, anche se il codice è sbagliato.
>
> ✅ Le fasce sono 0–17, 18–64, 65+. Il difetto — includere o escludere per sbaglio l'estremo — vive **solo** ai confini:
> **17 · 18 · 64 · 65**
>
> Provare 30, 31 e 32 non aggiunge nulla: stessa famiglia. Provare 17 e 18 aggiunge tutto.

**Il caso che l'utente farà davvero, e nessuno prova:** preme due volte il bottone · incolla testo con spazi in fondo · apre due schede · torna indietro col browser a metà · ha zero elementi il primo giorno e tremila dopo un anno.

---

## Per il `code-reviewer`

### `revisione-onesta`

**Il problema.** Una revisione può fallire in **due direzioni, e costano uguale**. Approvare un difetto manda in produzione un guasto. Bloccare su un gusto ferma il lavoro e **brucia la fiducia nel cancello**, così la volta dopo nessuno lo prende sul serio.

**Cosa impone.**
- Un 🔴 richiede un difetto dimostrabile, di **quattro tipi soli**: criterio violato · bug riproducibile · regressione · presidio saltato.
- Le trappole verso il **sì**: l'ancoraggio (ricevere il diff già con la conclusione di chi l'ha scritto), la dichiarazione («ho verificato»), la stanchezza del diff lungo, il test che *sembra* proteggere.
- Le trappole verso il **no**: il gusto, il rifacimento mascherato da rilievo, il rosso per prudenza quando non si è capito.
- Tre esiti possibili su ogni punto, non due: verificato-ok · verificato-no · **non verificabile da me**, dichiarato.

**Esempio — l'ancoraggio**

> ❌ Silvana passa al revisore: *«Ecco il diff. Il developer dice che ha verificato tutto e che i criteri sono coperti.»*
> Il revisore ora cerca conferme, non difetti. È un meccanismo automatico, non pigrizia: **sapere la conclusione altrui sposta il giudizio**.
>
> ✅ Silvana passa: *«Ecco il diff e la spec con i criteri. Emetti il verdetto.»*
> Nessuna conclusione, nessuna rassicurazione. Il revisore legge il codice prima di leggere la sintesi di chi l'ha scritto.

**🚨 Il segnale d'allarme.** Se in **due giri consecutivi** il revisore non produce nulla di azionabile, il problema non sono i diff: o gli stai passando la conclusione, o sta leggendo la sintesi invece del codice, o il perimetro è troppo grande per essere letto davvero. Rivedi **cosa gli passi**, non i suoi rilievi.

---

## Le tre trasversali

### `verifica-per-mutazione`

**Il problema.** Un test verde non dimostra che il codice funziona. **Dimostra che il test passa.**

**Cosa impone.** Rompere il codice di proposito e controllare che il test se ne accorga — e che fallisca **per la ragione giusta**, leggendo il messaggio e non solo il colore. Poi ripristinare, verificare che l'albero sia identico, e **riportare i numeri**.

**Esempio — la differenza fra verifica e affermazione**

> ❌ *«Ho verificato che i test coprono i casi. Tutte le mutazioni sono state catturate.»*
> Nessun numero, non dice cosa è stato mutato, non dice che l'albero è stato ripristinato. **Non è una verifica: è un'affermazione.**
>
> ✅ *«20 mutazioni applicate, 20 intercettate. Albero ripristinato e verificato identico. Le mutazioni su `calcolaSconto` e `applicaTetto` falliscono entrambe con il messaggio atteso.»*

**Le due regole conquistate sul campo.**
1. Un commento che dichiara «mutazione verificata» **vale zero** se la mutazione non è stata eseguita davvero. È già successo che un presidio dichiarato affidabile fosse inerte — e che fosse stato *sostituito* da un altro presidio inerte.
2. **Un'invariante verificata solo nella modalità predefinita non è verificata.** Caso reale: una barra di avanzamento corretta in modalità normale che, con le animazioni ridotte, restava piena e immobile e diceva esattamente *«sono bloccata»*.

**Chi ce l'ha:** `test-farm` e `code-reviewer`, precaricata.

---

### `migrazioni-database`

**Il problema.** Riscrivere una parte del database **partendo da una versione vecchia**, e rimuovere senza accorgersene una protezione che qualcuno aveva aggiunto dopo. È già costato una migrazione di riparazione su un progetto vero: la nuova versione fu scritta partendo da una funzione obsoleta, reintrodusse difetti già risolti **e rimosse un controllo di sicurezza**.

**Cosa impone.**
- Il numero si **legge dal filesystem**, non si indovina a memoria.
- ⭐ **Riparti sempre dalla versione vigente**: trova l'ultima applicata, non la prima che trovi.
- **Solo in avanti**: una migrazione già applicata non si riscrive mai; se ne aggiunge una che la supera, dichiarando cosa supera e perché.
- Il guard test è **parte della consegna**, non un passo successivo.

**Esempio — la domanda che chiude la disciplina**

> Prima di consegnare, rispondi **per iscritto** a questa:
> > **Quale protezione c'era nella versione vigente e non c'è nella mia?**
>
> ❌ *«Presìdi preservati.»* — non dice quali, quindi non è verificabile da nessuno.
> ✅ *«Preservati: esecuzione privilegiata, `search_path` fissato a `public`, permesso al ruolo autenticato, e il controllo sulla finestra temporale introdotto dalla migrazione 0041. Nessuna protezione rimossa.»*
>
> Se non sai rispondere, **non hai fatto il passo**.

**Chi la apre:** `developer` e `code-reviewer`, per nome, quando il lavoro tocca il database. Anche `analista` e `test-farm` quando serve.

---

### `sicurezza-database`

**Il problema.** Proteggere una cosa **solo nell'applicazione**, lasciandola aperta a chi chiama il sistema da fuori saltando l'interfaccia.

**Il principio.**
> **La policy sul database è l'autorità finale.** Un controllo applicativo è un'ottimizzazione dell'esperienza utente, non una difesa. Se una cosa non deve essere possibile, deve essere **impossibile nel database** — anche chiamando l'API direttamente, con un accesso valido, saltando l'interfaccia.

**Cosa impone.** Le quattro trappole ricorrenti: le viste che non ereditano le policy · le policy di modifica senza il vincolo sull'esito · le funzioni privilegiate in uno schema pubblico (che sono API pubbliche) · le autorizzazioni basate su dati che l'utente stesso può modificare.

**Esempio — l'errore sottile, il percorso di degradazione**

> Un amministratore può assegnare solo ruoli **inferiori** al proprio. Il controllo ingenuo guarda **il livello del ruolo assegnato**, ed è insufficiente.
>
> ❌ L'amministratore assegna il ruolo *più basso* a un utente di livello *più alto* del suo. Non sta promuovendo: sta **degradando**. Il controllo guarda solo il livello in arrivo — che è basso — e **passa**.
>
> ✅ Il controllo guarda **il livello attuale del bersaglio**, non solo quello del ruolo in arrivo. Vale sull'applicazione **e** sul database. E include la protezione da sé stessi: nessuno può revocare il proprio ruolo.

**Chi la apre:** `developer` e `code-reviewer`, per nome, quando il lavoro tocca ruoli, permessi, policy o funzioni privilegiate.

---

# Strato 5 — I meccanismi

Qui si spiega **come funziona davvero**, sotto. Serve a chi deve estendere il metodo, e a chi vuole capire perché certe cose sono fatte così.

## 5.1 ⭐ Cosa vede un agente quando parte — e cosa NON vede

Questo è il fatto tecnico da cui discende tutto il resto.

Un agente parte con un **contesto isolato**: non eredita la conversazione. Riceve:

| Cosa | Lo riceve? | Note |
|---|---|---|
| Il proprio prompt di sistema | ✅ | è la sua specializzazione |
| La consegna che gli scrive Silvana | ✅ | l'unico canale per passargli contesto |
| Le istruzioni di progetto (`CLAUDE.md`) | ✅ | tutta la gerarchia |
| Le **discipline precaricate** | ✅ | **testo completo iniettato**, non solo il nome |
| La conversazione fino a quel momento | ❌ | non sa cosa vi siete detti |
| **L'elenco delle discipline disponibili** | ❌ | **il punto cruciale** |

L'ultima riga cambia tutto: **un agente non sa quali discipline esistono.** Può invocarle — ha lo strumento per farlo — ma non ne conosce i nomi. Una disciplina che sta lì fuori, per lui, **non esiste**.

> **Conseguenza pratica:** l'innesco automatico che funziona nella sessione principale **non funziona dentro un agente**. Se una disciplina deve arrivargli, qualcuno gliela deve mettere in mano.

## 5.2 La manopola del costo — tre livelli

Ci sono tre modi per far arrivare una disciplina a un agente, e costano in modo diverso.

| Livello | Come funziona | Quanto costa | Quando si usa |
|---|---|---|---|
| **1 · Precaricata** | il testo completo entra all'avvio, **sempre** | si paga a ogni chiamata, anche quando non serve | solo per ciò che serve **sempre** a quel mestiere |
| **2 · Richiamata dal prompt** | il prompt dell'agente elenca le discipline e **la condizione** che le richiede | si paga **solo** quando la condizione scatta | discipline che servono **a volte** |
| **3 · Nominata nella consegna** | Silvana o il Business scrivono nella richiesta: «usa la disciplina X» | si paga solo quella volta | quando si decide caso per caso |

**Il livello 3 è la manopola del Business.** La consegna arriva dentro l'agente, quindi l'istruzione funziona sempre:

> *«Fai la revisione al code-reviewer, e digli di usare `sicurezza-database`.»*

E Silvana può farlo al posto suo: lei vede cosa tocca il lavoro, e nomina la disciplina giusta quando delega.

## 5.3 La dotazione attuale, per agente

| Agente | Precaricate (livello 1) | Apribili per nome (livello 2) |
|---|---|---|
| `ux-designer` | interfacce-usabili · parole-nell-interfaccia | — |
| `analista-funzionale` | criteri-di-accettazione | modello-dei-dati · macchine-a-stati · regole-di-business · migrazioni-database · sicurezza-database |
| `developer` | codice-verificabile | migrazioni-database · sicurezza-database |
| `test-farm` | casi-di-prova · verifica-per-mutazione | macchine-a-stati · regole-di-business · migrazioni-database |
| `code-reviewer` | revisione-onesta · verifica-per-mutazione | migrazioni-database · sicurezza-database · macchine-a-stati · regole-di-business |

**Il criterio:** si precarica solo ciò che serve a **ogni** invocazione di quel mestiere. Tutto il resto è di livello 2, con la condizione scritta nel prompt.

## 5.4 Perché non installiamo pacchetti di metodo esterni

Esistono raccolte di discipline pronte, anche ufficiali. Ne installiamo poche e con un criterio preciso:

| Tipo di contenuto | Si aggiunge? | Perché |
|---|---|---|
| **Conoscenza di riferimento** — regole verificabili, tassonomie, liste di controllo | ✅ sì | l'agente la *consulta*: non gli dice come lavorare |
| **Metodo** — come si lavora, cosa si consegna, in che ordine | ❌ no | i nostri prompt lo possiedono già |

> Una disciplina di metodo precaricata accanto a un prompt che dice già come lavorare **dà all'agente due padroni**. Quando i due non concordano — e succede, su cose come «proponi sempre un ridisegno» contro «distingui problema da preferenza» — l'agente diventa incoerente. Un bravo specialista che riceve due manuali contraddittori lavora peggio di uno che ne riceve uno solo.

**Il costo non è l'argomento**: una disciplina costa poche decine di parole finché non viene aperta. L'argomento è la **coerenza**.

## 5.5 I cancelli automatici (hook)

Una regola scritta in un prompt **non è deterministica**: è un'istruzione, e un'istruzione può essere interpretata. Solo gli hook e i permessi sono meccanici.

Oggi il plugin ne ha due:

- **All'avvio di ogni sessione**: inietta la checklist di processo — la regola zero, i livelli, l'ordine degli agenti, i cancelli. Serve perché la sessione parta già sapendo come si lavora.
- **Prima di ogni `git commit`**: mostra il promemoria del cancello del code-reviewer.

> ⚠️ **Limite noto, e onesto.** Il secondo è un **promemoria, non un blocco**: non impedisce il commit. Renderlo bloccante richiede un hook che ispezioni la chiamata ed esca con un codice di errore, e serve un modo di sapere se la revisione è avvenuta. È il miglioramento più importante in coda.

---

# Strato 6 — Dove vive tutto, e come si installa

## 6.1 I tre piani

La confusione più frequente è fra la cartella in cui si lavora e il posto da cui arriva il metodo. Sono tre cose distinte:

| Piano | Cos'è | Dove vive | Chi lo aggiorna |
|---|---|---|---|
| **Il mestiere** | ruoli, pipeline, discipline, cancelli | **questo repository**, pubblico | si aggiorna qui, una volta per tutti i progetti |
| **Il contesto** | rami, ambienti, stack, chi sono gli sviluppatori, incidenti, utenze | il **`CLAUDE.md` del progetto** | ogni progetto per sé |
| **Il lavoro** | il codice su cui si sta lavorando | la cartella del progetto | la sessione |

> **La cartella in cui sei seduto non è la cartella da cui arriva il metodo.** Il plugin viene scaricato da GitHub; il progetto resta dov'è.

## 6.2 Come si installa — due modi, e quale scegliere

### ⭐ Modo A — collegata (preferito)

```bash
curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/collega.sh | bash
```

Aggancia la software house al progetto come **sottomodulo git** in `.software-house/`, e crea in `.claude/agents/` e `.claude/skills/` dei **collegamenti** che puntano lì.

**Nella storia del progetto non entrano i file**: entrano collegamenti (modo `120000`) e un puntatore a un commit (modo `160000`). In tutto meno di 2 KB, contro le duemila righe della copia.

| Comando | Cosa fa |
|---|---|
| `bash .software-house/scripts/collega.sh --aggiorna` | sposta il puntatore all'ultima versione |
| `bash .software-house/scripts/collega.sh --stacca` | rimuove collegamenti e sottomodulo |

**Aggiornare significa spostare un puntatore di un commit.** Il diff che vedi è una riga, non un file ricopiato — e nessuno può modificare per sbaglio una copia locale, perché copie locali non ce ne sono.

> ⚠️ **Due cose vanno verificate sul campo la prima volta**, e finché non lo sono non dare per scontato che funzioni:
> 1. **I collegamenti per gli agenti.** Per le discipline sono supportati e documentati: Claude Code segue il collegamento e legge `SKILL.md` dalla cartella di destinazione. Per gli **agenti** non è documentato.
> 2. **Il recupero del sottomodulo in ambiente cloud.** Se l'ambiente clona il progetto senza i sottomoduli, `.software-house/` resta vuota e **tutti i collegamenti puntano nel vuoto**: non carica niente.
>
> **Il sintomo di entrambi è identico** a quello del marketplace rotto — la squadra non compare — quindi va distinto guardando se `.software-house/` contiene davvero i file.
>
> Nota minore e innocua: il comando che elenca le discipline [non mostra quelle collegate](https://github.com/anthropics/claude-code/issues/14836), anche quando funzionano. Non fidarti di quell'elenco per la verifica: chiedi invece all'agente di aprirne una per nome.

### Modo B — copiata (ripiego che funziona sempre)

```bash
curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/installa.sh | bash
```

Copia agenti e discipline dentro `.claude/` del progetto. **Non dipende da niente**: né da collegamenti, né da sottomoduli, né dal marketplace. Se il Modo A non regge nell'ambiente, questo regge.

Costo: duemila righe duplicate nella storia del progetto, e il rischio che qualcuno modifichi la copia invece dell'originale. Lo script scrive un'intestazione di avvertimento nel registro `.claude/.software-house` proprio per quello.

Anche questo è **rieseguibile** e rimuove la copia precedente prima di riscrivere.

### ⚠️ La trappola del ramo sbagliato

Una sessione parte dal ramo che le viene indicato, e **non è sempre quello che credi**. Su un progetto con più ambienti si può chiedere una sessione su un ramo e ritrovarsi su un altro: da lì il progetto appare completamente diverso — file che mancano, `.gitignore` senza le correzioni, la squadra assente.

**Il sintomo è indistinguibile da un'installazione fallita**, e porta a diagnosticare un problema che su quel ramo esiste ma altrove no.

```bash
git branch --show-current                                  # dove credi di essere
git rev-list --left-right --count origin/RAMO-ATTESO...HEAD  # dove sei davvero
```

**Il metro è il secondo comando, non il primo.** In ambiente remoto una sessione lavora quasi sempre su un ramo con un nome proprio, e va benissimo: quello che conta è se l'**albero** è lo stesso. `0 0` significa identico — stesso contenuto, nome diverso. Fermarsi per il solo nome fa perdere tempo su un problema che non esiste.

> Ci siamo cascati il 26/08/2026: un'intera diagnosi condotta su un ramo che discendeva da `main`, mentre la squadra era già installata e funzionante sul ramo di lavoro vero. **Il primo comando di ogni verifica è quello che dice dove sei.**

### ⚠️ La trappola del `.gitignore`

Molti progetti hanno nel `.gitignore` una riga come `.claude/*` con la sola eccezione `!.claude/settings.json` — nasce per non versionare le impostazioni personali, ed è ragionevole.

**Con quella riga, agenti e discipline sono invisibili a git.** `git add .claude/` aggiunge zero file e **il commit riesce senza portare niente**: nessun errore, nessun avviso. Ci si accorge del problema solo alla sessione dopo, quando la squadra non c'è — e il sintomo è identico a quello del marketplace rotto.

Entrambi gli script, dalla **v0.9.0**, lo rilevano e aggiungono da soli le eccezioni necessarie, dicendo cosa hanno fatto. Per controllare a mano:

```bash
git check-ignore -q .claude/skills/pipeline ; echo $?
# 0 = ignorato, sei nella trappola · 1 = non ignorato, tutto a posto
```

> ⚠️ **Non giudicare dall'output di `git check-ignore -v`**: quel comando stampa l'ultima regola che corrisponde **anche quando è una negazione**. Dopo la correzione stampa righe che cominciano per `!` — e sono la prova che funziona, non che è rotto. Il codice di uscita è l'unico metro.

> Scoperto sul campo il 26/08/2026, alla prima installazione su un progetto vero. È il tipo di difetto peggiore: **fallisce in silenzio e riesce ad apparire riuscito.**

### Passare da un modo all'altro

Si può in entrambe le direzioni, e gli script se ne occupano da soli: ognuno legge il registro `.claude/.software-house`, rimuove **qualunque forma** avesse l'installazione precedente — file copiati o collegamenti — e poi scrive la propria.

```bash
# da copiata a collegata
curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/collega.sh | bash

# da collegata a copiata
bash .software-house/scripts/collega.sh --stacca
curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/installa.sh | bash
```

Verificato sul campo la transizione copia → collegamento: nessun residuo, contenuto leggibile attraverso i collegamenti, e git che registra 18 collegamenti e un puntatore invece di venti file.

> **Fallo su un ramo di prova, non su quello di lavoro.** Finché il modo collegato non è verificato in una sessione vera, il ramo di lavoro deve continuare a portare l'installazione che sai funzionante. Se la prova va male si butta il ramo e non è successo niente.

### Quale scegliere

| | Modo A — collegata | Modo B — copiata |
|---|---|---|
| Cosa entra nella storia del progetto | un puntatore e dei collegamenti (~2 KB) | i file, tutti (~2.000 righe) |
| Aggiornare | sposta un puntatore | ricopia i file |
| Rischio di modifiche locali divergenti | nessuno: non c'è una copia | reale, mitigato da un avvertimento |
| Funziona ovunque senza verifiche | **da verificare** | **sì** |

> ✅ **Il Modo B è verificato sul campo** (Karica, 26/08/2026): cinque agenti disponibili in sessione e discipline aperte per nome con il contenuto giusto. Il Modo A resta da verificare.

**Parti dal Modo A. Se la verifica in sessione nuova non lo conferma, passa al Modo B senza rimpianti**: la sostanza del metodo è la stessa, cambia solo come arriva.

> In entrambi i modi la versione è **bloccata**, ed è giusto così: un aggiornamento della software house non deve cambiare il metodo sotto i piedi a chi sta lavorando. Si aggiorna quando lo decidi tu.

## 6.3 🔴 Perché NON usiamo il marketplace (e la trappola in cui siamo caduti)

Claude Code prevede un meccanismo apposta per distribuire un plugin a un team: si dichiara il marketplace nel `.claude/settings.json` del progetto, versionato, e chiunque apra quel progetto se lo ritrova.

```json
{
  "extraKnownMarketplaces": {
    "ganzomoreno": { "source": { "source": "github", "repo": "ganzomoreno/software-house" } }
  },
  "enabledPlugins": { "software-house@ganzomoreno": true }
}
```

**Questa dichiarazione non installa il plugin.** È documentato che dovrebbe farlo, e non lo fa: il marketplace viene registrato, la cache viene popolata, ma l'elenco dei plugin installati non viene mai aggiornato e agenti e discipline restano irraggiungibili.

- È un **difetto noto** di Claude Code: [issue #32606](https://github.com/anthropics/claude-code/issues/32606), chiusa senza intervento.
- C'è anche un secondo ostacolo, questo documentato: `extraKnownMarketplaces` **richiede che la cartella sia stata dichiarata affidabile** da chi apre la sessione. Finché non lo è, «non ricevono i plugin dal marketplace che il file dichiara». In un ambiente cloud quel passaggio spesso non avviene.

**Il sintomo, per riconoscerlo:** la sessione parte, il `CLAUDE.md` del progetto viene letto regolarmente, altri plugin risultano caricati — ma dei cinque agenti non c'è traccia e nessuna disciplina compare nell'elenco. Sembra un problema di configurazione del progetto, e non lo è.

> **Ci siamo cascati il 26/08/2026**, alla prima prova su un progetto vero: la dichiarazione era scritta correttamente e versionata, e la squadra non è arrivata lo stesso. Da lì nasce lo script di copia diretta.

**La dichiarazione nel `settings.json` si può lasciare** — non fa danno, e il giorno in cui il difetto verrà risolto funzionerà. Ma non è su quella che si conta.

## 6.4 🔴 Due cose da sapere prima di aprire una sessione

1. **Lo script copia dal ramo principale (`main`) della software house.** Una disciplina aggiunta su un ramo di sviluppo **non arriva ai progetti** finché non è unita a `main`.
2. **Gli agenti e le discipline si caricano all'avvio della sessione.** Una sessione già aperta **non li vede comparire**: dopo un aggiornamento serve una **sessione nuova**.
3. **La copia va portata sul ramo da cui partono le tue sessioni**, e non è per forza `main` del progetto: su progetti con più ambienti si lavora su un ramo dedicato.

---

# Strato 7 — Come si estende

## 7.1 Il cricchetto delle due volte

Quando un lavoro insegna qualcosa, la regola che ne deriva va scritta. **Dove**, si decide così:

| La regola è servita… | Va… |
|---|---|
| su **un** progetto | nel `CLAUDE.md` di **quel** progetto |
| su **due o più** progetti | **qui, nel plugin** — è mestiere dimostrato |

È l'unico vincolo che tiene la cosa convergente. Senza, ogni specificità di ogni progetto finirebbe nel plugin, e la squadra porterebbe su ogni lavoro le stranezze di tutti gli altri.

Il contrario è altrettanto vero: **se una regola qui non calza su un progetto, non la si aggira** — si guarda se era contesto travestito da mestiere. L'attrito è informazione, non fastidio.

## 7.2 Come si aggiunge una disciplina

1. **Verifica che sia mestiere e non contesto** (§7.1) e che sia **conoscenza di riferimento**, non metodo (§5.4).
2. Crea `plugins/software-house/skills/<nome>/SKILL.md`.
3. Il frontmatter richiede due campi: `name` e `description`. **La descrizione è il meccanismo di riconoscimento**: scrivici dentro le parole concrete con cui qualcuno la cercherebbe, e la condizione che la rende necessaria.
4. Struttura del corpo, come le altre: una citazione in apertura che dice **il problema che previene** · sezioni numerate con regole concrete · **almeno un esempio ❌/✅** · una checklist finale.
5. Collegala a un agente: `skills:` nel suo frontmatter se serve **sempre**, oppure una riga nella sua sezione «Discipline da consultare» con la **condizione** che la richiede.
6. Aggiorna: questo manuale (Strato 4 e la tabella 5.3), il `README.md`, e la versione in `plugin.json` **e** in `marketplace.json` — devono restare allineate.

## 7.4 Come un progetto esclude una disciplina

Il plugin porta **tutto** il mestiere. Non tutti i progetti usano tutto: una competenza può essere in mano a qualcun altro, o non applicarsi.

**L'esclusione è contesto di progetto, non mestiere.** Non si toglie la disciplina dal plugin — resta lì per gli altri progetti. Si dichiara nel `CLAUDE.md` del progetto, in una sezione dedicata, e Silvana la legge a ogni sessione.

La forma:

```markdown
## Discipline della software house NON in uso su questo progetto
- `<nome-disciplina>` — <chi se ne occupa invece> — <dal quando, e chi ha deciso>
```

**Quattro regole perché l'esclusione non diventi un buco.**

1. **Si scrive il motivo, e il motivo deve reggere da solo.** È la regola che viene prima delle altre, perché è quella che qualcuno rileggerà fra sei mesi chiedendosi se vale ancora.
2. **Si scrive chi se ne occupa al posto nostro.** Un'esclusione senza destinatario non è una delega: è una competenza che non ha più nessun proprietario.
3. **Si scrive cosa smette di essere controllato.** Escludere `sicurezza-database` significa che il `code-reviewer` non solleverà più i rilievi su permessi e policy. Va detto, perché è esattamente ciò che il cancello smette di fermare.
4. **Ha una data e un decisore.** Un'esclusione senza data non si rivede mai.

### ⭐ Quali motivi reggono, e quali no

Un motivo regge quando **descrive una proprietà del progetto** che rende quel lavoro inutile o dannoso. Non regge quando descrive una condizione temporanea di chi lavora.

| Motivo | Regge? | Perché |
|---|---|---|
| *«Questo ambiente è un prototipo: il codice verrà riscritto da altri con altre tecniche prima di andare in produzione»* | ✅ sì | il lavoro sarebbe **buttato via**. Farlo «decente» costa e non lascia nulla: tanto vale farlo dichiaratamente finto |
| *«Quel tema è di un altro team, che lo tratta con i propri strumenti e le proprie revisioni»* | ✅ sì | il presidio esiste, **altrove**, e ha un proprietario nominato |
| *«Su questo progetto non si applica»* (un progetto senza database esclude le discipline sul database) | ✅ sì | non c'è nulla da controllare |
| *«Non abbiamo tempo adesso»* | ❌ no | è un rinvio, non un'esclusione. Va nel registro come debito, con una data |
| *«Non è mai successo niente»* | ❌ no | è l'argomento che precede ogni incidente |
| *«Rallenta»* | ❌ no | se un cancello rallenta più di quanto protegge, il problema è **come è fatto**, non che esista |

> ⚠️ **Il caso del prototipo ha una condizione.** Un ambiente finto vale come motivo **solo finché resta finto**. Il giorno in cui qualcuno decide di promuoverlo invece di riscriverlo, tutte le esclusioni che poggiavano su quel motivo cadono insieme — e nessuno se ne ricorda da solo. **Va scritto nell'esclusione stessa**: *«questa esclusione vale finché l'ambiente è un prototipo destinato a essere riscritto».*

**Un esempio completo, dal campo:**

```markdown
## Discipline della software house NON in uso su questo progetto

- `sicurezza-database` — deciso da Ale, il 26/08/2026
  Motivo: questo è un ambiente prototipo. Gli sviluppatori esterni riscrivono
  sopra con le loro tecniche prima della produzione, quindi il lavoro di
  sicurezza fatto qui verrebbe buttato via. Farlo "decente" costerebbe senza
  lasciare nulla: meglio farlo dichiaratamente finto.
  Se ne occupano: gli sviluppatori esterni, sulla loro riscrittura.
  Cosa smette di essere controllato: il code-reviewer non solleverà più rilievi
  su permessi, ruoli, policy e funzioni privilegiate.
  ⚠️ Vale finché l'ambiente resta un prototipo destinato a essere riscritto.
  Se un giorno venisse promosso così com'è, questa esclusione cade.
```

> ⚠️ **L'esclusione non si estende da sola.** Vale per la disciplina nominata, non per il tema. Escludere la sicurezza del database non esclude i criteri negativi dell'analista (chi non deve potere) né le prove sulle transizioni vietate: quelli restano, perché sono correttezza funzionale, non sicurezza di sistema.

## 7.3 Candidate future

Non le scriviamo prima di averne bisogno: la regola è che una disciplina nasce da un attrito vero. Queste sono emerse come plausibili e restano in attesa di un caso reale:

| Candidata | Per chi | Il problema che coprirebbe |
|---|---|---|
| `errori-e-fallimenti` | developer | cosa si ritenta e cosa no, l'operazione ripetibile senza danno, l'errore muto |
| `percorsi-utente` | ux-designer | i flussi fra schermate, non le schermate singole |
| `prestazioni-percepite` | developer · ux | cosa si carica prima, cosa può aspettare |
| `dati-di-prova` | test-farm | come si costruisce uno stato di partenza realistico senza fabbricare l'esito |
| `tracciabilità` | analista | la matrice criterio → componente → test, per i lavori grandi |

---

# Appendice A — Glossario

| Termine | Significato in questo metodo |
|---|---|
| **Agente / specialista** | una delle cinque persone finte con un mestiere. Si chiama per nome. |
| **Silvana** | la sessione principale, il coordinatore. Non è un agente. |
| **Business** | chi commissiona: strategia, priorità, approvazione delle scelte irreversibili e di brand. È anche il collaudatore finale. |
| **Sviluppatori esterni** | le persone che possiedono l'architettura e portano in produzione. **Non** sono agenti. |
| **Disciplina / skill** | un manuale di mestiere consultabile. Non lavora da sola. |
| **Cancello / hook** | un automatismo che scatta senza che nessuno lo decida. |
| **Tier / livello** | quanto lavoro di processo richiede una richiesta, da 0 a 4. |
| **Criterio (AC)** | una frase verificabile in modo binario, numerata. Il contratto fra i ruoli. |
| **Precaricata** | disciplina iniettata per intero nell'agente all'avvio. |
| **Baseline** | quanti test passavano **prima**. Senza, un numero non dice nulla. |
| **Mutazione** | rompere il codice di proposito per vedere se il test se ne accorge. |
| **Presidio** | una protezione esistente: un permesso, una policy, un controllo, un vincolo. |
| **Fix-list** | l'elenco eseguibile di correzioni che chiude una revisione. |

# Appendice B — Mappa dei file

```
software-house/
├── README.md                          vetrina e installazione
├── scripts/
│   ├── collega.sh                     aggancia la software house a un progetto (sottomodulo + collegamenti)
│   └── installa.sh                    ripiego: la copia dentro il progetto
├── .claude-plugin/marketplace.json    definizione del marketplace  ← la versione qui
├── docs/
│   ├── MANUALE.md                     questo documento — come funziona, tutto
│   ├── AVVIO-SU-UN-PROGETTO.md        istruzioni pronte da incollare, per accendere la squadra
│   └── METODO.md                      il perché, e il piano di unificazione
├── templates/CONTESTO-PROGETTO.md     modello da compilare su ogni progetto
└── plugins/software-house/
    ├── .claude-plugin/plugin.json     manifesto del plugin  ← e anche qui
    ├── agents/                        i cinque ruoli
    ├── hooks/hooks.json               checklist all'avvio + promemoria sul commit
    └── skills/
        ├── pipeline/                  il flusso: livelli, cancelli, autonomia
        ├── interfacce-usabili/        ux · i cinque stati, accessibilità, moduli
        ├── parole-nell-interfaccia/   ux · etichette, errori, stati vuoti, bottoni
        ├── criteri-di-accettazione/   analista · SE/ALLORA, parole vietate, criteri negativi
        ├── modello-dei-dati/          analista · entità, cardinalità, cancellazione, copie
        ├── macchine-a-stati/          analista · griglia delle transizioni, effetti, chi può
        ├── regole-di-business/        analista · tabelle di decisione, completezza, precedenza
        ├── codice-verificabile/       developer · la cucitura, la baseline
        ├── casi-di-prova/             test-farm · classi, bordi, famiglia del nulla
        ├── revisione-onesta/          reviewer · cosa merita un rosso, le trappole
        ├── verifica-per-mutazione/    trasversale · provare che un test morde
        ├── migrazioni-database/       trasversale · versione vigente, solo avanti, guard
        └── sicurezza-database/        trasversale · la policy è l'autorità finale
```

# Appendice C — Decisioni prese, e perché

| Data | Decisione | Motivo |
|---|---|---|
| 2026-08-03 | Il pacchetto migliora **per attrito**, non aspettando di essere puro | il contesto è il materiale con cui il metodo si raffina, non sporcizia da rimuovere |
| 2026-08-06 | La **regola zero**: si lavora in silenzio, una risposta sola alla fine | un resoconto che va riletto aggiunge carico invece di toglierlo |
| 2026-08-26 | **Nessun agente nuovo**: le lacune si colmano con discipline | la dottrina riserva i nuovi agenti ai casi di isolamento del contesto; spezzare fasi che condividono contesto aggiunge latenza e perdita di informazione |
| 2026-08-26 | **Niente skill di sicurezza esterne** | infrastruttura e sicurezza di sistema sono degli sviluppatori esterni. La sicurezza del codice che scriviamo noi resta nostra ed è coperta da `sicurezza-database` |
| 2026-08-26 | Solo **conoscenza di riferimento**, mai metodo, dentro le discipline | una disciplina di metodo darebbe all'agente due padroni |
| 2026-08-26 | Le discipline vanno **precaricate o nominate** | un agente non vede l'elenco delle discipline disponibili: l'innesco automatico non funziona dentro di lui |

---

# Appendice D — Su cosa si fondano queste scelte

Le decisioni dell'Appendice C nascono da una ricerca condotta il **26/08/2026**: sei angoli di indagine, 24 fonti lette (quasi tutte documentazione primaria), 100 affermazioni estratte, le 25 principali verificate ciascuna da tre verificatori indipendenti incaricati di **confutarle** — 23 confermate, 2 respinte.

**Le fonti che reggono le decisioni:**

| Fonte | Cosa stabilisce |
|---|---|
| [Subagents — what loads at startup](https://code.claude.com/docs/en/sub-agents) | un agente non riceve l'elenco delle discipline disponibili (§5.1); il campo di precaricamento inietta il **contenuto completo** |
| [Skills](https://code.claude.com/docs/en/skills) | il costo di un elenco di discipline e i suoi limiti; il ciclo di vita di una disciplina in contesto |
| [How and when to use subagents](https://claude.com/blog/subagents-in-claude-code) | i nuovi agenti servono per **isolare contesto**; è sconsigliato spezzare fasi che condividono contesto |
| [Steering Claude Code](https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more) | solo gli hook e i permessi sono deterministici: una regola in un prompt non lo è (§5.5) |
| [Equipping agents with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) | il metodo di scrittura parte dai **gap osservati**, non da un catalogo scritto a tavolino |
| [Discover plugins](https://code.claude.com/docs/en/discover-plugins) | cosa offre il catalogo ufficiale, e il costo di contesto per turno di ogni pacchetto installato |

**Due cautele, dichiarate.**
1. **Nessuna fonte porta evidenza quantitativa** che una pipeline multi-agente con cancelli produca codice migliore o più veloce di una sessione singola ben attrezzata. La letteratura disponibile è descrittiva. Il nostro metro resta l'attrito sul campo.
2. **L'ecosistema evolve in fretta.** I dettagli tecnici dello Strato 5 vanno riverificati fra qualche mese: sono stati veri il 26/08/2026.

---

*Manuale del metodo costruito sul progetto Karica, 2026. Il contesto specifico di ogni progetto resta nel progetto.*
