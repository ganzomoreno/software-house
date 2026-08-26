---
name: regole-di-business
description: Come si esprime una regola con più condizioni senza ambiguità e senza buchi — la tabella di decisione, la prova di completezza e di non contraddizione, l'ordine di precedenza, il caso di default. Da usare quando la richiesta contiene "se… tranne quando…", sconti, tariffe, priorità, idoneità, o qualsiasi regola con più di una condizione.
---

# Regole di business

> Una regola con **tre condizioni** ha **otto combinazioni**. Una descrizione a parole ne copre in genere tre o quattro, e nessuno si accorge delle altre finché un cliente non ci finisce dentro.
> La tabella di decisione esiste per una ragione sola: **rende visibile ciò che manca.**

## 1. Il segnale: quando serve una tabella

Appena in una richiesta compaiono queste parole, la prosa non basta più:

> *«tranne quando…»* · *«a meno che…»* · *«ma se invece…»* · *«in quel caso però…»* · *«di norma…»*

Sono i punti in cui chi parla sta comprimendo una tabella dentro una frase. Il tuo lavoro è riaprirla.

## 2. ⭐ La tabella di decisione

Si costruisce in quattro mosse.

**a. Isola le condizioni** — le variabili che influenzano l'esito, ognuna con i suoi valori possibili.

**b. Conta le combinazioni** — è il prodotto dei valori. Due condizioni sì/no = 4 righe. Tre = 8. Una a tre valori più due sì/no = 12.

**c. Scrivi tutte le righe.** Tutte, anche quelle che «non capiteranno mai» — sono esattamente quelle che capitano.

**d. Riempi l'esito di ogni riga.** Se per una riga nessuno sa rispondere, **hai trovato un buco nella richiesta**: è la domanda da portare al Business, ed è il motivo per cui questa disciplina esiste.

> **Sconto: cliente storico? · ordine sopra 500€? · periodo di saldi?**
>
> | storico | >500€ | saldi | sconto |
> |---|---|---|---|
> | sì | sì | sì | 25% |
> | sì | sì | no | 15% |
> | sì | no | sì | 20% |
> | sì | no | no | 10% |
> | no | sì | sì | 20% |
> | no | sì | no | 5% |
> | no | no | sì | 15% |
> | no | no | no | **0%** ← il caso di default, quasi sempre dimenticato |

Otto righe, otto criteri di accettazione, otto casi di prova. Nessuna interpretazione possibile.

## 3. Le due prove che la tabella deve superare

**Completezza** — ogni combinazione ha esattamente una riga. Nessun buco.
> Il buco tipico: il caso in cui **tutte le condizioni sono false**. È il comportamento predefinito, e quasi nessuno lo scrive.

**Non contraddizione** — nessuna combinazione ha due esiti diversi.
> La contraddizione tipica nasce da due regole scritte in momenti diversi: *«i clienti storici hanno il 10%»* e *«sotto i 500 € nessuno sconto»*. Un cliente storico con un ordine da 300 €: quale vince? Finché non è scritto, vince quella che chi implementa ha letto per ultima.

## 4. La precedenza, quando le regole si sovrappongono

Se le regole restano espresse come elenco invece che come tabella, **l'ordine diventa parte della regola** e va dichiarato:

- **La prima che si applica vince** (e allora l'ordine dell'elenco è vincolante: scrivilo).
- **La più specifica vince** (e allora va definito cosa rende una regola più specifica di un'altra).
- **Si sommano** (e allora serve sapere se si sommano prima o dopo l'arrotondamento, e se c'è un tetto).

Non dichiararlo è il modo più efficace per ottenere un risultato diverso da quello atteso senza che nessuno abbia sbagliato niente.

## 5. I dettagli che cambiano il risultato e nessuno scrive

Su ogni regola che produce un numero:

- **Arrotondamento**: a quante cifre, e per eccesso, per difetto o al più vicino? Su un totale di 10.000 righe, la scelta si vede.
- **Ordine delle operazioni**: lo sconto prima o dopo l'IVA? La percentuale sul lordo o sul netto?
- **Tetti e pavimenti**: c'è un massimo? Un minimo? Cosa succede se il calcolo va sotto zero?
- **L'unità**: euro o centesimi, giorni o giorni lavorativi, incluso o escluso l'estremo.
- **Il fuso e il calendario**: «entro il 31» significa fino a che ora, in quale fuso?

Ognuno di questi è un criterio, ed è anche un caso di prova sul bordo.

## 6. Quando la regola cambia nel tempo

Una regola di business ha quasi sempre una **data di inizio validità**, anche se nessuno la nomina. Chiedi:

- Vale da quando? **E cosa succede a ciò che è già stato calcolato con la regola vecchia?**
- Si ricalcola all'indietro, o le cose passate restano come sono?

La risposta corretta è quasi sempre «restano come sono» — ma è una decisione del Business, non un'assunzione di chi scrive la specifica. E se restano come sono, **il sistema deve conservare quale regola ha usato**, altrimenti fra un anno nessuno saprà spiegare un numero.

## 7. Come finisce nella spec

La tabella si copia **così com'è** dentro la specifica, e ogni riga diventa un criterio numerato:

```
AC5   · La tabella sconti (8 righe) è applicata integralmente.
AC5.1 · SE storico E >500€ E saldi ALLORA sconto 25%
AC5.2 · SE storico E >500€ E non saldi ALLORA sconto 15%
...
AC5.8 · SE non storico E non >500€ E non saldi ALLORA sconto 0%

AC6 · Lo sconto è calcolato sull'imponibile, prima dell'IVA.
AC7 · Il risultato è arrotondato a 2 decimali, al più vicino.
AC8 · Lo sconto non supera mai il 25%, nemmeno sommando promozioni.
```

Chi prova scrive **otto** casi, non «qualche caso». Chi revisiona ha **otto** caselle da spuntare.

## Checklist prima di consegnare la spec

- [ ] Ogni «tranne quando» della richiesta è diventato una riga di tabella
- [ ] Le combinazioni sono **tutte** presenti (prodotto dei valori, contate)
- [ ] Il caso «tutte le condizioni false» ha un esito scritto
- [ ] Nessuna combinazione ha due esiti diversi
- [ ] Se le regole restano un elenco, la precedenza è dichiarata
- [ ] Arrotondamento, ordine delle operazioni, tetti, unità e fusi sono scritti
- [ ] È dichiarato da quando vale, e cosa succede al passato
- [ ] Ogni riga della tabella è un criterio numerato
