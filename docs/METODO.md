# Il metodo — cos'è, perché lo stiamo unificando, e il piano

> Documento funzionale. Scritto per essere **letto e studiato**, e per fare da base a una spiegazione verso l'esterno.
> Nessun gergo non spiegato: dove serve una parola tecnica, viene definita.
> Ultimo aggiornamento: 2026-08-06.

---

## 0. 🔴 Come si lavora con il Business — regola che viene prima di tutte

> **Richiesta di Ale, 2026-08-06:** *"io ti do dei prompt, tu ci lavori in silenzio e in background, ti prendi tutto il tempo che serve e poi mi dai una risposta sintetica. Se serve trovi spiegazione in documenti che tu via via salvi. Perché io ti lancio dei comandi e torno dopo, alle volte minuti, alle volte ore, a guardare. Mi ritrovo un flusso di parole che non riesco a capire."*

**Il modo di lavorare è questo, e non cambia:**

| | |
|---|---|
| **Lui lancia** | un comando, e se ne va |
| **Noi lavoriamo** | in silenzio, quanto serve — minuti oppure ore |
| **Noi rispondiamo** | **una volta sola, alla fine**, in poche righe |
| **Il resto** | sta nei documenti, salvati man mano |

### Le regole della risposta finale

1. **Elenchi puntati.** Mai paragrafi, mai racconto.
2. **Prima i punti aperti**, cioè cosa serve da lui. Poi cosa è stato fatto.
3. **Ogni punto spiegato in modo facile**, in una riga: cosa cambia per lui, non come funziona dentro.
4. **Niente cronaca del lavoro.** Non gli interessa cosa è stato provato, in che ordine, quante volte.
5. **Il perché sta nei documenti**, con il link. In chat ci va solo il risultato.

### Cosa è vietato

- ❌ Commentare i passi mentre si lavora.
- ❌ Mandare messaggi intermedi di avanzamento.
- ❌ Raccontare i tentativi falliti, i ripensamenti, i dettagli tecnici.
- ❌ Rispondere più volte allo stesso comando.

> **Il metro:** Ale torna dopo tre ore e legge il messaggio. **Deve capire in trenta secondi** cosa è successo e cosa deve fare. Se per capirlo deve rileggere, il messaggio è sbagliato — anche se ogni parola era vera.

**Perché è la regola numero zero.** Il metodo esiste per ridurre il carico di chi decide. Un resoconto che va riletto **aggiunge** carico invece di toglierlo: contraddice lo scopo stesso del lavoro, per quanto bene sia stato fatto il lavoro.

---

## 1. Di cosa stiamo parlando

Quando si sviluppa con l'intelligenza artificiale, il rischio non è che il lavoro non venga fatto: è che venga fatto **in fretta e senza controllo**. Il codice esce plausibile, i test escono verdi, e il difetto si scopre in produzione.

Il metodo che abbiamo costruito risponde a questo con un'idea sola:

> ### Chi giudica non è chi esegue.

Chi scrive il lavoro non decide se funziona. Chi verifica non riceve le conclusioni di chi ha lavorato: riceve il lavoro e la specifica, e si fa un'idea propria. Tutto il resto — i cinque ruoli, i cancelli, i livelli di prova — discende da qui.

**I cinque ruoli**, in ordine di intervento:

| Ruolo | Cosa fa | Cosa non fa |
|---|---|---|
| **Designer** | guarda la schermata con gli occhi di chi la usa | non scrive codice |
| **Analista** | trasforma la richiesta in **criteri binari e numerati** (SE… ALLORA…) | non implementa |
| **Sviluppatore** | realizza *esattamente* quei criteri | non scrive i propri test, non pubblica |
| **Collaudo** | scrive le prove **partendo dai criteri, non dal lavoro fatto** | non tocca ciò che è stato costruito |
| **Revisore** | **cancello bloccante** prima di pubblicare | non applica correzioni: emette un verdetto |

*(Dentro il pacchetto i cinque si chiamano `ux-designer`, `analista-funzionale`, `developer`, `test-farm`, `code-reviewer`: stessi ruoli, stessi confini, nome tecnico.)*

Sopra di loro c'è un **coordinatore** (Silvana): decide, ordina, tiene i registri. Esegue da sola solo i lavori triviali: **non sostituisce nessuno dei cinque sulle modifiche sostanziali**.

---

## 2. Perché lo stiamo unificando — l'asse

Oggi il metodo **funziona**, ma esiste come un'abitudine, non come un oggetto. Tre conseguenze concrete:

**① Ogni correzione va fatta più volte.** I cinque ruoli esistono in **due copie**: una dentro il pacchetto condiviso, una dentro il progetto Karica. Ogni volta che miglioriamo un ruolo, bisogna ricordarsi di farlo in entrambe. Prima o poi qualcuno se ne dimentica, le due copie divergono, e non si sa più quale sia quella buona.

**② Quello che impariamo su un progetto resta lì.** Su Franka abbiamo scoperto tre difetti nel modo in cui i ruoli sono scritti. Su Karica quei difetti ci sono ancora, identici, semplicemente perché nessuno li ha copiati.

**③ Un progetto nuovo riparte da zero.** Ogni volta si rimonta a mano lo stesso impianto.

> **L'asse è questo: trasformare un'abitudine in un prodotto.**
> Un'abitudine si spiega a voce e si perde. Un prodotto si installa, si aggiorna in un punto solo, e **si può vendere**.

È anche la ragione per cui questa parte viene *prima* di Franka o del CRM: quei progetti sono i casi d'uso, il metodo è la cosa che resta.

---

## 3. Com'è oggi, come sarà dopo

| | **Oggi** | **Dopo** |
|---|---|---|
| I ruoli | due copie che divergeranno | **una sola definizione** |
| Correggere un ruolo | va fatto in ogni copia | una volta, arriva ovunque |
| Un progetto nuovo | si rimonta tutto a mano | eredita il metodo già fatto |
| Ciò che si impara su un progetto | resta in quel progetto | **sale** nel metodo, se serve due volte |
| Il coordinatore all'avvio | conosce solo quel progetto | sa **da dove veniamo** e cosa ha priorità |
| Franka | non sa cosa succede nello sviluppo | riceve le consegne e le ricorda |

---

## 3-bis. Come funziona davvero — i tre piani

> Questa è la parte che genera più confusione, ed è giusto che la generi: stiamo scrivendo **regole che valgono ovunque** mentre lavoriamo **dentro un progetto specifico**. Sembra una contraddizione. Non lo è, e il motivo è uno solo:

### 🔑 La cartella in cui sei seduto non è la cartella in cui scrivi

Una sessione si apre **dentro una cartella** — di solito quella del progetto su cui stai lavorando. Ma da lì si scrive **in cartelle diverse del computer**, e ognuna di quelle appartiene a un **repository diverso**.

È come stare a una scrivania in un ufficio e spedire lettere a tre indirizzi. **La scrivania non decide la destinazione.**

### I tre piani

| | Cosa contiene | Dove sta fisicamente | Vale per |
|---|---|---|---|
| **1 · Come lavorare con te** | comunicazione, autonomia, chi è Silvana, le regole di metodo | un file **sul tuo computer**, `~/.claude/CLAUDE.md` — **fuori da ogni progetto** | ogni sessione su questa macchina |
| **2 · Il mestiere** | i cinque ruoli, la pipeline, i cancelli, i livelli di prova | il repository **`software-house`** — un progetto **a sé**, che non appartiene a nessuno degli altri | ogni progetto che lo **accende** |
| **3 · Il contesto** | rami, ambienti, stack, chi sono gli sviluppatori, incidenti, utenze di prova | dentro **ciascun** progetto (`CLAUDE.md`) | solo quel progetto |

**Il piano 2 è la risposta alla domanda "come fa a valere ovunque".** Non sta dentro Karica né dentro Franka: sta **accanto** a loro. È un repository indipendente, e ogni progetto lo dichiara.

### Come viene "acceso" su un progetto

Dentro il progetto, in un file di configurazione (`.claude/settings.json`), si dichiarano due cose: **dove trovare il pacchetto** e **che lo si vuole usare**. Sono tre righe.

Da quel momento, aprendo una sessione su quel progetto, i cinque ruoli ci sono già — senza copiarli, senza duplicarli.

### Perché la configurazione va nel progetto e non sul computer

C'è anche un modo di accenderlo **sul computer**, valido per tutte le sessioni di quella macchina. Funziona, ma ha un limite fatale:

| Dove metti l'accensione | Vale in locale | Vale in **cloud** | Vale su un **altro computer** | Vale per **altre persone** |
|---|---|---|---|---|
| sul computer | ✅ | ❌ | ❌ | ❌ |
| **dentro il progetto** | ✅ | ✅ | ✅ | ✅ |

**In cloud la macchina è nuova ogni volta**: qualunque cosa tu abbia configurato sul tuo portatile lì non esiste. L'unica cosa che sopravvive è ciò che sta **dentro il repository**, perché il repository viaggia.

> Per questo l'accensione va versionata nel progetto. È l'unico modo perché il metodo ci sia anche quando apri una sessione dal telefono.

### Un'unica conseguenza, ed è quella che stiamo sistemando

Se un progetto ha **una copia locale** dei ruoli, quella copia **vince** sul pacchetto. È comodo per un caso particolare, ma significa che le correzioni fatte al pacchetto **su quel progetto non arrivano**. È esattamente la situazione di Karica oggi, ed è la **mossa 2**.

---

## 4. Il piano — quattro mosse

### ✅ Mossa 1 — Gli specialisti raggiungono tutto *(fatta il 04/08)*

**Il problema.** I cinque ruoli sapevano leggere solo **file e riga di comando**. Qualunque cosa vivesse fuori — le automazioni di Franka, i documenti su Drive, la posta, il browser — era per loro invisibile. Risultato: ogni volta che serviva guardare lì, il lavoro finiva ad agenti generici, **fuori dal metodo**.

**Cosa è stato fatto.** Non abbiamo elencato i servizi uno per uno: abbiamo dato a tutti e cinque **la capacità di cercarsi gli strumenti da soli**. Così raggiungono qualunque servizio sia collegato, senza che il pacchetto debba conoscerne i nomi — che cambiano da computer a computer.

**Cosa cambia per te.** Quando chiedi un'analisi su Franka, la fa **l'analista**, non un agente qualunque. Il metodo copre anche i progetti che non sono fatti di codice.

---

### ⏳ Mossa 2 — Una sola definizione dei ruoli

**Il problema.** Due copie della stessa cosa. Quella dentro Karica ha la precedenza, quindi oggi il pacchetto condiviso **su Karica non viene nemmeno usato**: correggerlo non ha effetto lì.

**Cosa si fa.** I ruoli dentro Karica si **archiviano** (non si cancellano: restano leggibili nella storia). Resta il pacchetto come unica fonte. Il contesto specifico di Karica — rami, ambienti, chi sono gli sviluppatori esterni, gli incidenti passati — **resta dov'è**: non si perde niente, si separa soltanto *il mestiere* dal *contesto*.

**Cosa cambia per te.** Una correzione al metodo arriva su tutti i progetti insieme. Oggi non succede.

**Rischio, detto onestamente.** Se il pacchetto avesse un difetto, quel difetto arriverebbe ovunque in un colpo. È il prezzo di avere una fonte sola, ed è il motivo per cui il pacchetto è versionato: si torna indietro.

---

### ⏳ Mossa 3 — Il metodo attivo su ogni progetto

**Il problema.** Il pacchetto è acceso su **due** progetti su otto. Sugli altri, aprire una sessione significa lavorare senza rete.

**Cosa si fa.** Tre righe di configurazione dentro ogni progetto. Vanno nel progetto e non sul computer, perché è l'unico modo perché valgano **anche dal telefono e dal cloud**.

**Cosa cambia per te.** Apri una sessione su qualunque tuo progetto e la squadra c'è già.

---

### ⏳ Mossa 4 — Il coordinatore e Franka condividono la memoria

**Il desiderio dichiarato.** *"Franka è Franka, ma quando serve è anche il coordinatore dello sviluppo, così ha sempre il contesto."*

**Cosa è possibile e cosa no.** Non possono essere lo stesso programma: Franka vive sulle automazioni e parla su Telegram, il coordinatore vive dentro un progetto. **Ma possono avere la stessa memoria**, e i pezzi esistono già: Franka sa **raccontare** il contesto, e sa **ricevere** una consegna.

**Cosa si fa.** Due regole:
1. il coordinatore **legge il contesto di Franka quando apre**;
2. il coordinatore **deposita una consegna quando chiude** un lavoro.

**Cosa cambia per te.** Da Telegram chiedi a Franka *"a che punto siamo col CRM?"* — e lo sa. E quando apri una sessione di sviluppo, quella sessione sa che l'uscita da Moltiply viene prima di una tranche del CRM.

> **Un soggetto solo con due corpi e una memoria condivisa si comporta come un soggetto solo.** Non è un ripiego rispetto al desiderio: è il modo in cui si realizza.

---

## 5. Cosa noterai, in concreto

| Situazione | Oggi | Dopo |
|---|---|---|
| Apri una sessione su un progetto nuovo | non c'è niente | i cinque ruoli ci sono |
| Chiedi un'analisi su qualcosa che non è codice | la fa un agente generico | la fa l'analista |
| Correggiamo un difetto del metodo | vale su un progetto | vale su tutti |
| Chiedi a Franka a che punto è lo sviluppo | non lo sa | lo sa |
| Apri una sessione dopo settimane | riparte a freddo | sa da dove veniamo |

---

## 6. Come il metodo migliora — la regola che evita la discarica

Il metodo **dipende dal contesto** e viene corretto un progetto alla volta. Non lo si tiene fermo aspettando che sia perfetto: lo si usa ancora sporco, e **l'attrito che genera è il dato** — dice quale regola era specifica di un progetto travestita da regola generale.

Perché questo converga invece di accumulare le stranezze di tutti, c'è **una** soglia:

> **Una regola entra nel metodo condiviso solo quando è servita su DUE progetti.**
> Su uno solo, resta nel progetto.

**Sta già funzionando.** Su Franka, in due giorni, sono emerse quattro correzioni al metodo, tutte da attrito reale:

| Cosa non calzava | Regola che ne è nata |
|---|---|
| «cita il file e la riga» | cita **la fonte**, nella forma che il materiale ha |
| «isola la logica per la prova» | usa **i mezzi che il progetto ha davvero** |
| «elenca tutti i punti d'ingresso» | e se non hai potuto guardare, **dichiara l'elenco incompleto** |
| i ruoli vedevano solo file | raggiungono **qualunque servizio collegato** |

La terza è quella che ha pagato di più: ha impedito due volte di costruire su un'informazione sbagliata.

---

## 7. Per l'uso esterno — cosa è vendibile e cosa non ancora

**Il prodotto è questo:** un metodo di sviluppo assistito dall'AI in cui *chi esegue non giudica*, installabile su qualunque progetto in un minuto, che migliora in un punto solo e si porta dietro le lezioni imparate altrove.

**La promessa difendibile:** non "l'AI scrive il codice", ma **"il lavoro dell'AI viene verificato da qualcun altro che non ha interesse ad approvarlo"**. È la differenza fra velocità e affidabilità, ed è ciò che un cliente compra.

**Cosa NON è ancora dimostrato, e non va promesso:**
- gira su **due** progetti, non su dieci: che sia generale resta un'ipotesi in verifica;
- non abbiamo **misure** di quanto riduca i difetti — abbiamo episodi, non numeri;
- il modo in cui i ruoli sono *scritti* non è validato: sappiamo che funziona, non che sia il modo migliore.

> Vendere ciò che è dimostrato e dichiarare ciò che non lo è **è** il metodo, non un limite del metodo. Un cliente che scopre da solo il confine si sente ingannato; uno a cui lo dici prima si fida.

---

## 8. Ordine e stato

| | Mossa | Stato | Chiusa il |
|---|---|---|---|
| 1 | Specialisti che raggiungono tutto | ✅ **fatta** | 04/08 |
| 2 | Una sola definizione dei ruoli | ✅ **fatta** | 04/08 |
| 3 | Metodo attivo su ogni progetto | ✅ **fatta — 9 su 9** | 04/08 |
| 4 | Coordinatore ↔ Franka | ✅ **regole scritte**, in uso da qui in avanti | 04/08 |

**Nessuna delle quattro ha toccato il codice dei progetti.**

### Cosa è successo davvero, in sintesi

- **Mossa 2** non è stata un semplice spostamento: le copie locali contenevano **conoscenza specifica di Karica** accumulata nel tempo. È stata **estratta prima** in un documento di progetto (9 temi, 8 trappole con l'incidente che le ha generate), poi le copie sono state archiviate. Il pacchetto è generico di proposito e non poteva ospitarla.
- **Mossa 3** ha rivelato un tranello: su un progetto la cartella di configurazione era interamente ignorata, quindi il comando riportava *successo* senza aver salvato niente. **Scoperto solo verificando sul remoto** invece di fidarsi dell'esito. Ora quel progetto versiona la configurazione del metodo e continua a ignorare le scelte personali.
- **Un presidio è rimasto scoperto, ed è dichiarato:** il controllo automatico che verificava i prompt dei ruoli leggeva le copie locali. Archiviato con esse. **Va ricreato qui**, dove i prompt vivono adesso — un guardiano deve stare accanto alla cosa che sorveglia. Finché non c'è, nessuno si accorge se un ruolo perde una regola.
