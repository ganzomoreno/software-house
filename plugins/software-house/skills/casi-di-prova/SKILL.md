---
name: casi-di-prova
description: Come si scelgono i casi da provare — classi di equivalenza, i bordi, la famiglia del nulla, le transizioni di stato, il flusso reale contro l'unità isolata, e il caso che l'utente farà davvero. Da usare quando si decide quali test scrivere a partire dai criteri di accettazione.
---

# Casi di prova

> La verifica per mutazione dice se un test **morde**. Non dice quali casi **mancano**.
> Questa disciplina copre il buco: non quante prove hai scritto, ma se hai guardato dove i difetti si nascondono davvero.

## Il principio che viene prima di tutto

**Parti dai criteri, non dal codice.** Chi apre il codice e scrive un test per ogni ramo produce test che fotografano ciò che il codice fa — **difetti compresi**. Il criterio dice cosa *deve* fare: è l'unico metro indipendente che hai.

## 1. Le classi di equivalenza — non provi ogni valore, provi ogni famiglia

Per ogni ingresso, dividi i valori possibili in **famiglie che il sistema tratta allo stesso modo**. Poi provane **uno per famiglia**, e i bordi fra una famiglia e l'altra.

> Sconto per fascia d'età: 0–17 gratis, 18–64 pieno, 65+ ridotto.
> Tre famiglie → tre prove (10, 30, 70). Più i bordi, che sono il punto vero: **17, 18, 64, 65**.

Provare 30, 31 e 32 non aggiunge nulla: sono la stessa famiglia. Provare 17 e 18 aggiunge tutto.

## 2. ⭐ I bordi — dove si annidano i difetti

La stragrande maggioranza dei difetti di calcolo vive **a un passo dal confine**, non in mezzo alla fascia.

Per ogni soglia, ogni limite, ogni conteggio: **prova il valore prima, il valore esatto, e il valore dopo.**

| Il confine è… | Prova |
|---|---|
| una soglia numerica *n* | `n-1`, `n`, `n+1` |
| una quantità di elementi | zero, uno, due, il massimo, il massimo + 1 |
| un intervallo di date | il giorno prima, il primo giorno, l'ultimo giorno, il giorno dopo |
| una lunghezza massima | massimo-1, massimo, massimo+1 |

Il difetto classico — includere o escludere per sbaglio l'estremo — **si vede solo così**.

## 3. La famiglia del nulla

Sono sei cose diverse, e il codice le tratta spesso in tre modi diversi senza che nessuno se ne accorga:

**assente** (il campo non c'è) · **nullo** · **stringa vuota** · **solo spazi** · **zero** · **falso**

E i loro travestimenti: la stringa `"0"`, la stringa `"false"`, la lista vuota, l'oggetto senza chiavi.

Su ogni ingresso che può mancare, provane almeno **assente, vuoto e solo spazi**. Lo spazio bianco è quello che passa sempre inosservato, e che l'utente produce sempre incollando.

## 4. Le transizioni di stato, non solo gli stati

Se una cosa ha stati (bozza → inviato → approvato → archiviato), non provare solo che ogni stato esiste. Prova i **passaggi**, e soprattutto quelli **che non devono essere possibili**:

- il salto (bozza → approvato, saltando l'invio)
- il ritorno (approvato → bozza)
- la ripetizione (approvare due volte)
- il passaggio da uno stato finale (archiviato → qualsiasi cosa)

Le transizioni vietate sono la metà del contratto, e quasi nessuno le prova.

## 5. Il flusso reale contro l'unità isolata

Una prova unitaria dimostra che **una funzione** calcola bene. Non dimostra che **il sistema** produce quell'esito: la funzione giusta chiamata nel punto sbagliato, o non chiamata affatto, passa tutte le prove unitarie del mondo.

**Se il criterio attesta un esito per l'utente, percorri il flusso che dovrebbe produrlo**, non solo l'unità in fondo.

Regola pratica: almeno **una** prova per criterio deve attraversare il percorso vero. Le altre possono restare isolate.

## 6. Il caso che l'utente farà davvero

L'ultimo giro, prima di chiudere: **cosa farà una persona reale che non ha letto la specifica?**

- Preme due volte il bottone.
- Incolla del testo con spazi in fondo, o con le virgolette curve.
- Apre due schede e lavora in tutte e due.
- Torna indietro col tasto del browser a metà.
- Chiude a metà e riapre.
- Ha zero elementi il primo giorno, e tremila dopo un anno.

Non serve provarli tutti ogni volta. Serve **scorrere l'elenco** e chiedersi quale di questi il criterio in mano non regge.

## 7. Cosa non si prova, si dichiara

Un criterio che non hai potuto coprire va **scritto**, non omesso. E va distinto:

- ❌ **KO della prova** — la funzione non si attiva come previsto.
- 🐛 **difetto a monte** — il sistema non produce mai quell'esito, con nessun ingresso.

Sono due cose diverse e vanno indirizzate a persone diverse. Confonderle fa perdere un giro a tutti.

## Checklist prima di consegnare

- [ ] I casi nascono dai **criteri**, non dalla lettura del codice
- [ ] Per ogni ingresso: una prova per famiglia, non dieci della stessa
- [ ] Per ogni soglia: il valore prima, quello esatto e quello dopo
- [ ] La famiglia del nulla provata (almeno assente, vuoto, solo spazi)
- [ ] Le transizioni **vietate** provate, non solo quelle permesse
- [ ] Almeno una prova per criterio attraversa il flusso reale
- [ ] Scorso l'elenco «cosa farà l'utente davvero»
- [ ] Ciò che non è coperto è dichiarato, distinguendo KO da difetto a monte
