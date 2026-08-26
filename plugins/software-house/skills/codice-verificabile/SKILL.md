---
name: codice-verificabile
description: Come si scrive e si modifica codice che qualcun altro possa dimostrare — la cucitura fra logica e mondo, cosa rende un test impossibile, versioni prima dei pattern, sostituire senza cancellare, il perimetro e la baseline nei numeri. Da usare ogni volta che si implementa o si modifica codice esistente.
---

# Codice verificabile

> Il lavoro non è finito quando funziona. È finito quando **qualcun altro può dimostrare che funziona**, senza doverlo chiedere a te.
> È la conseguenza pratica del principio della squadra — *chi giudica non è chi esegue*: se chi prova non può raggiungere la tua logica, il presidio salta, e non per colpa sua.

## 1. ⭐ La cucitura: dove passa il confine fra la logica e il mondo

Il **mondo** è tutto ciò che non controlli: l'ora, la rete, il database, il caso, l'utente, il disco.
La **logica** è la decisione: cosa si calcola, cosa si sceglie, cosa si rifiuta.

Se le due cose stanno nella stessa funzione, quella funzione **non è provabile**: per provarla devi ricreare il mondo.

```
❌  funzione: legge il database, calcola lo sconto, invia la mail
✅  funzione pura: (dati, data) → sconto          ← qui si prova
    funzione di bordo: legge, chiama la pura, invia   ← qui non c'è niente da provare
```

**La regola:** la decisione va in una funzione che riceve tutto ciò che le serve **come argomento** e restituisce un valore, senza toccare nulla. Il resto le sta intorno.

Quando isoli una funzione così, **dichiarane il nome e la posizione nell'output finale**: è l'aggancio con cui chi prova la raggiunge.

## 2. Le cinque cose che rendono un test impossibile

| Cosa | Perché rompe la prova | Come si ripara |
|---|---|---|
| **L'ora corrente** letta dentro la logica | il risultato cambia domani | la data entra **come argomento** |
| **La casualità** presa dentro | due esecuzioni, due esiti | il valore casuale entra come argomento |
| **La rete o il database** dentro il calcolo | serve un mondo intero per una riga | prima leggi, poi calcola |
| **Lo stato globale nascosto** (variabili condivise, cache) | l'ordine dei test cambia l'esito | passa lo stato, non pescarlo |
| **L'effetto in mezzo al calcolo** (scrive mentre decide) | non si può provare la decisione senza provocare l'effetto | decidi, poi agisci |

Se non puoi ripararle nel perimetro che hai, **dichiaralo**: chi prova saprà che quel criterio richiede una verifica dal vivo, invece di scoprirlo sbattendoci.

## 3. Versioni prima dei pattern

**Prima di scrivere codice che dipende da una libreria o da un impianto, leggi il file delle dipendenze e dichiara cosa hai trovato.**

Un modo di fare corretto due versioni fa spesso **compila e sbaglia in silenzio** sulla versione attuale: nessun errore, comportamento diverso. È la classe di difetto più difficile da vedere in revisione, perché il codice sembra giusto.

> Nell'output: *«dipendenze verificate: X 4.2, Y 15.1 — il modo usato è quello della 4.x»*.

## 4. Sostituire non è cancellare

Quando rimpiazzi qualcosa che esiste, **ciò che sostituisci resta conservato ed esportato**, non eliminato.

Il motivo è pratico: non sai chi lo sta usando finché non l'hai tolto. Il censimento dei punti d'ingresso lo fa l'analista, ma l'ultima riga di difesa sei tu.

E vale anche al contrario: **se un test esistente si rompe, non rilassarlo per farlo passare.** Capisci perché. Se fotografava il vecchio comportamento e il comportamento è cambiato **per specifica**, dichiaralo. Se non sai dire quale dei due casi è, **fermati e chiedi**: la decisione non è tua.

## 5. Il perimetro

Tocchi solo i file previsti dalla specifica. Se una modifica ti costringe a uscire, **chiedi invece di allargare da solo**: un diff che esonda è un diff che nessuno riesce a revisionare, e la revisione è il cancello che protegge tutti.

Gli errori preesistenti che non sono tuoi: **segnalali, non correggerli**. Correggerli in mezzo al tuo lavoro rende impossibile capire cosa ha rotto cosa.

## 6. I numeri con la baseline, sempre

«Tutto verde» non è una consegna verificabile. La forma giusta ha tre pezzi:

> *«Prove: 148 passate, 2 fallite. Prima erano 147 passate, 2 fallite. Delta: +1 passata (la nuova su AC3). Le 2 fallite sono preesistenti e riguardano X, non toccato da questa modifica.»*

**Quanti passano ora · quanti passavano prima · perché è cambiato.** Senza il "prima", il numero non dice nulla.

Se non hai potuto eseguire una verifica, **scrivi che non l'hai eseguita**. Un esito omesso viene letto come un esito positivo.

## Checklist prima di consegnare

- [ ] La logica sta in funzioni che ricevono tutto come argomento e non toccano il mondo
- [ ] Nome e posizione delle funzioni chiave dichiarati, perché chi prova le raggiunga
- [ ] Ora, casualità, rete e stato globale non sono letti dentro la logica
- [ ] Versioni delle dipendenze lette e dichiarate **prima** di usare un impianto
- [ ] Ciò che ho sostituito è conservato, non cancellato
- [ ] Nessun file toccato fuori dal perimetro; errori altrui segnalati, non corretti
- [ ] Numeri riportati con la baseline e il delta spiegato
- [ ] Dichiarato cosa **non** ho potuto verificare
