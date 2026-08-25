---
name: verifica-per-mutazione
description: Come si prova che un test intercetta davvero il difetto invece di fotografarlo — protocollo, catalogo delle mutazioni per classe di difetto, formato di riporto. Da usare in ogni code review che valuta test nuovi o modificati, e ogni volta che si sta per dichiarare che un presidio è attivo.
---

# Verifica per mutazione

> Un test verde non dimostra che il codice funziona: dimostra che il test passa.
> **La differenza si misura solo rompendo il codice di proposito e verificando che il test se ne accorga.**

## Il protocollo

1. **Scegli l'invariante** che il test dovrebbe difendere. Scrivila a parole *prima* di toccare il codice.
2. **Muta la riga di produzione** — non il test — in modo che l'invariante sia violata.
3. **Esegui.** Il test deve fallire, e deve fallire **per la ragione giusta**: leggi il messaggio, non solo il colore.
4. **Ripristina** e verifica che l'albero sia tornato identico (`git diff --stat` vuoto).
5. **Riporta con i numeri**: `N mutazioni applicate / M intercettate`. La sopravvissuta si **nomina**.

## Catalogo delle mutazioni, per classe di difetto

| Classe | Mutazione da applicare |
|---|---|
| Query incompleta | togliere una colonna dalla proiezione |
| Cache non invalidata | rimuovere l'invalidazione dopo una scrittura |
| Guardia invertita | negare la condizione di un controllo di autorizzazione |
| Arrotondamento | arrotondamento per eccesso → per difetto |
| Fuso orario | UTC → ora locale |
| Protocollo | rimuovere un flag o un header |
| Errore muto | rendere silenzioso un errore di scrittura |
| Presidio dichiarativo | togliere una policy dal testo che il guard verifica |

## Le due regole conquistate sul campo

**1. Un commento che dichiara "mutazione verificata" vale zero se la mutazione non è stata eseguita davvero.**
Se non c'è il numero, non è stata fatta. È già successo che un presidio dichiarato affidabile in un commento fosse inerte — e che fosse stato *sostituito* da un altro presidio inerte.

**2. Un'invariante verificata solo nella modalità predefinita non è verificata.**
Se un comportamento ha modalità alternative — animazioni ridotte, tema scuro, ruolo diverso, stato vuoto — l'invariante va provata **in ciascuna**. Caso reale: una barra di avanzamento corretta in modalità normale che, con le animazioni ridotte, restava piena e immobile e diceva esattamente *"sono bloccata"*.

## Come si riporta

✅ **Così:** *"20 mutazioni applicate, 20 intercettate. Albero ripristinato e verificato identico. Le mutazioni su X e Y falliscono entrambe col messaggio atteso."*

❌ **Non così:** *"Ho verificato che i test coprono i casi. Tutte le mutazioni sono state catturate."*

La seconda non ha numeri, non nomina cosa è stato mutato, non dice che l'albero è stato ripristinato. **Non è una verifica: è un'affermazione.**

## Quando è obbligatorio

- Test nuovi su autorizzazioni, calcoli economici, date e fusi orari
- Guard test di migrazione
- Ogni volta che si sta per **dichiarare che un presidio è attivo**
- Quando un test è stato scritto *dopo* aver visto il bug: è il caso in cui è più facile fotografare il difetto invece di intercettarlo
