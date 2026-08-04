# Il metodo — cos'è, perché lo stiamo unificando, e il piano

> Documento funzionale. Scritto per essere **letto e studiato**, e per fare da base a una spiegazione verso l'esterno.
> Nessun gergo non spiegato: dove serve una parola tecnica, viene definita.
> Ultimo aggiornamento: 2026-08-04.

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
| **Analista** | trasforma la richiesta in **criteri verificabili** (SE… ALLORA…) | non implementa |
| **Sviluppatore** | realizza *esattamente* quei criteri | non scrive i propri test, non pubblica |
| **Collaudo** | scrive le prove **partendo dai criteri, non dal lavoro fatto** | non tocca ciò che è stato costruito |
| **Revisore** | **cancello bloccante** prima di pubblicare | non applica correzioni: emette un verdetto |

Sopra di loro c'è un **coordinatore** (il PM): decide, ordina, tiene i registri. Non sostituisce nessuno dei cinque.

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

| | Mossa | Stato | Chi |
|---|---|---|---|
| 1 | Specialisti che raggiungono tutto | ✅ fatta | PM |
| 2 | Una sola definizione dei ruoli | ⏳ da fare | PM |
| 3 | Metodo attivo su ogni progetto | ⏳ 2 su 8 | PM |
| 4 | Coordinatore ↔ Franka | ⏳ da fare | PM |

Le mosse 2 e 3 sono reversibili in pochi minuti. La 4 aggiunge due comportamenti, non cambia niente di esistente. **Nessuna delle quattro tocca il codice dei tuoi progetti.**
