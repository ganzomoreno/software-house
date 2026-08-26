---
name: criteri-di-accettazione
description: Come si scrive un criterio di accettazione davvero binario — la forma SE/ALLORA, le parole che rendono un criterio inverificabile, un criterio un comportamento, i criteri negativi, i casi limite e il censimento dei punti d'ingresso. Da usare ogni volta che si scrive o si revisiona una specifica.
---

# Criteri di accettazione

> Un criterio che due persone leggono in due modi **non è un criterio: è un desiderio**.
> Il criterio è il contratto fra tre ruoli: chi implementa lo segue, chi prova lo cita nel nome del test, chi revisiona lo spunta. Se è ambiguo, tutti e tre lavorano su tre cose diverse — e nessuno se ne accorge finché non è tardi.

## 1. La forma

```
AC3 · SE <condizione osservabile> ALLORA <esito osservabile>
```

Entrambe le metà devono essere **osservabili dall'esterno**: qualcuno che non ha letto il codice deve poter dire se è successo o no, guardando il sistema.

- ✅ *«SE l'utente invia il modulo con la data vuota, ALLORA compare il messaggio "Inserisci una data" accanto al campo e il modulo non viene inviato.»*
- ❌ *«Il sistema valida correttamente la data.»*

Numera in modo **gerarchico**: `AC1`, poi `AC1.1` e `AC1.2` per i sotto-casi. L'identificativo non cambia mai una volta pubblicato: è la chiave con cui il test lo cita.

## 2. ⭐ Le parole che rendono un criterio inverificabile

Se una di queste compare in un criterio, il criterio non è ancora scritto.

| Parola | Perché non funziona | Cosa scrivere invece |
|---|---|---|
| **correttamente** | non dice quale sia il comportamento corretto | l'esito atteso, per esteso |
| **appropriato**, **adeguato** | rimanda un giudizio a chi legge | il valore o la regola |
| **intuitivo**, **chiaro** | non verificabile da nessuno | il numero di passi, o il testo esatto |
| **veloce**, **rapido** | ogni lettore ha la sua soglia | un tempo in secondi |
| **se necessario**, **eventualmente** | lascia la decisione all'implementatore | la condizione esatta |
| **gestisce**, **tiene conto di** | non dice cosa fa | l'azione osservabile |
| **e così via**, **ecc.** | la parte non scritta non verrà implementata | l'elenco completo |

**La prova:** copri l'esito con una mano e chiedi a qualcun altro di predirlo dal solo criterio. Se non ci riesce, riscrivilo.

## 3. Un criterio, un comportamento

La congiunzione **«e»** nell'esito è quasi sempre il segnale di due criteri travestiti da uno.

> ❌ *«SE il pagamento fallisce, ALLORA compare l'errore e viene inviata la mail e l'ordine resta in sospeso.»*

Tre cose. Se ne funzionano due su tre, il criterio è verde o rosso? Non si sa — ed è esattamente il caso in cui i difetti sopravvivono. Spacchetta in `AC4.1`, `AC4.2`, `AC4.3`.

## 4. I criteri negativi — quelli che nessuno scrive

Ogni specifica dice cosa deve succedere. Quasi nessuna dice **cosa non deve succedere** — ed è lì che vivono i difetti costosi, perché nessun test li copre.

Per ogni comportamento nuovo, chiediti:
- Chi **non** deve poterlo fare? → un criterio.
- Cosa **non** deve cambiare mentre questo cambia? → un criterio.
- Quale scorciatoia **non** deve funzionare (chiamata diretta, indirizzo copiato, tasto indietro)? → un criterio.

> *«AC7 · SE un utente senza il ruolo X chiama l'operazione direttamente, ALLORA riceve un rifiuto e nessun dato viene modificato.»*

## 5. I casi limite meritano un numero proprio

Un caso limite nascosto dentro un criterio principale non viene provato. Estrailo.

La famiglia da scorrere ogni volta: **niente** (vuoto, nullo, non impostato) · **uno solo** · **moltissimi** · **il primo e l'ultimo** · **il duplicato** · **il concorrente** (due persone insieme) · **l'interrotto** (chiude a metà).

Non tutti si applicano sempre. Quelli che non si applicano, **dichiarali fuori scope** invece di ometterli: la differenza fra «non serve» e «non ci ho pensato» la vede solo chi scrive.

## 6. Il censimento dei punti d'ingresso

Se cambi o togli un comportamento, cerca **ogni strada che ci arriva**: schermate, indirizzi, funzioni richiamate altrove, automazioni, canali esterni, lavori programmati. Elencali nei criteri.

**Una correzione che ne dimentica uno è una correzione che il difetto aggira.**

Se non hai potuto ispezionare tutto, **dichiara il censimento incompleto**. Un elenco presentato come completo e che non lo è vale meno di nessun elenco: chi legge smette di cercare.

## 7. Ogni criterio dice come si verifica

Accanto al criterio, una riga: **con quale mezzo si dimostra**, fra quelli che il progetto ha davvero.

- Logica isolabile → prova unitaria su una funzione pura (dì quale, e dove va messa).
- Ciò che l'utente vede → verifica a video, con la precondizione necessaria.
- Ciò che non si può eseguire (struttura, vincoli, testo di una migrazione) → controllo statico sul file.

Se un criterio non è verificabile con nessun mezzo disponibile, **dillo**: o si riscrive, o si accetta consapevolmente che nessuno lo proverà.

## Checklist prima di consegnare la spec

- [ ] Ogni criterio è nella forma SE/ALLORA, con entrambe le metà osservabili
- [ ] Nessuna delle parole vietate del §2 è rimasta
- [ ] Nessun criterio contiene due comportamenti («e» nell'esito)
- [ ] Ci sono criteri **negativi**: chi non può, cosa non cambia, quale scorciatoia non funziona
- [ ] I casi limite hanno un numero proprio, o sono dichiarati fuori scope
- [ ] Il censimento dei punti d'ingresso è completo — o dichiarato incompleto
- [ ] Ogni criterio dice con quale mezzo si verifica
- [ ] Ogni affermazione sullo stato attuale cita una fonte ritrovabile
