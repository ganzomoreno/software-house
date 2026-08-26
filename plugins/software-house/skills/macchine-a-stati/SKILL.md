---
name: macchine-a-stati
description: Come si specifica qualcosa che ha stati — l'elenco chiuso degli stati, la tabella delle transizioni permesse e vietate, chi può farle, cosa scatta al passaggio e cosa succede se il passaggio fallisce a metà. Da usare quando la richiesta riguarda ordini, pratiche, richieste, utenti, pubblicazioni, o qualsiasi cosa che "passa da uno stato all'altro".
---

# Macchine a stati

> Quasi ogni sistema gestionale è, sotto, **una macchina a stati travestita**: un ordine, una pratica, un utente, un articolo, un ticket.
> E quasi ogni specifica descrive **gli stati** dimenticando **le transizioni** — che sono la parte dove vivono i difetti, perché nessuno le prova.

## 1. L'elenco degli stati è chiuso

Prima regola: gli stati sono un elenco **finito, chiuso e con nomi propri**. Non «in lavorazione o simili».

- Ogni stato ha **un nome solo**, usato ovunque allo stesso modo (non «annullato» in un punto e «cancellato» in un altro: sono due stati o uno solo? decidilo).
- C'è **uno stato iniziale** e va detto quale.
- Ci sono **stati finali**, da cui non si esce più. Dichiarali: sono quelli che proteggono i dati.
- Non esistono stati impliciti. Se una cosa può essere «né questo né quello», quello è uno stato e va nominato.

## 2. ⭐ La tabella delle transizioni — permesse E vietate

Non basta dire «da bozza si va a inviato». Serve **la griglia completa**: da ogni stato, verso ogni stato, permesso o vietato.

|  da ↓ / a → | Bozza | Inviata | Approvata | Respinta | Archiviata |
|---|---|---|---|---|---|
| **Bozza** | — | ✅ l'autore | ❌ | ❌ | ✅ l'autore |
| **Inviata** | ✅ l'autore, entro 24h | — | ✅ l'approvatore | ✅ l'approvatore | ❌ |
| **Approvata** | ❌ | ❌ | — | ❌ | ✅ automatico dopo 90 gg |
| **Respinta** | ✅ l'autore | ❌ | ❌ | — | ✅ l'autore |
| **Archiviata** | ❌ | ❌ | ❌ | ❌ | — |

**Le caselle ❌ sono metà del contratto**, e sono quelle che diventano criteri negativi:

> *«AC12 · SE una richiesta in stato Approvata riceve un comando di passaggio a Bozza, ALLORA il comando viene rifiutato e nessun dato cambia.»*

Le caselle ✅ portano sempre **due informazioni**: che è permessa, e **chi** la può fare.

## 3. Le quattro transizioni che nessuno prova

Scorrile sempre, su ogni macchina:

1. **Il salto** — si può arrivare allo stato finale saltando quelli in mezzo? (bozza → approvata)
2. **Il ritorno** — si può tornare indietro? Se sì, cosa succede a ciò che era già scattato (mail inviate, numeri assegnati, soldi movimentati)?
3. **La ripetizione** — cosa succede se la stessa transizione viene chiesta due volte? La seconda deve essere **innocua**, non un secondo effetto.
4. **La partenza da uno stato finale** — chiusa, archiviata, annullata: da lì, nulla.

## 4. Chi può farla — e non è solo una questione di ruolo

Per ogni transizione permessa, tre condizioni possibili, e vanno scritte tutte e tre:

- **Chi** (il ruolo): l'approvatore, l'autore, il sistema.
- **Quando** (la finestra): entro 24 ore, solo in giorni lavorativi, solo prima della scadenza.
- **A quali condizioni** (lo stato dei dati): solo se ha almeno una riga, solo se il totale è sotto la soglia, solo se l'anagrafica è completa.

> ⚠️ **La condizione più dimenticata è quella su sé stessi.** Chi approva può approvare la *propria* richiesta? Chi assegna ruoli può togliere il *proprio*? Quasi sempre la risposta è no, e quasi sempre non è scritto.

## 5. Cosa scatta al passaggio, e cosa succede se fallisce a metà

Una transizione raramente cambia solo un'etichetta. Di solito **fa scattare degli effetti**: manda una mail, assegna un numero progressivo, blocca una modifica, avvia un conteggio.

Per ognuno, la specifica deve dire:

- **Che cosa scatta**, in quale ordine.
- **Cosa è definitivo** e cosa si può disfare. Un numero di protocollo assegnato non si restituisce; una mail inviata non si richiama.
- **Cosa succede se un effetto fallisce**: lo stato cambia lo stesso o no? Se cambia, il sistema resta a metà — e va detto **chi se ne accorge e come si ripara**.

Questa è la parte che distingue una specifica scritta da un analista da una scritta da chi non lo è.

## 6. Lo stato non lo decide l'interfaccia

Se un bottone è nascosto quando la transizione non è permessa, **bene: è buona interfaccia**. Ma non è il controllo.

> **Il controllo sta dove sta il dato.** Un bottone nascosto è una cortesia verso l'utente; chi chiama il sistema direttamente non lo vede nemmeno.

Ogni transizione vietata va quindi in **due criteri**: uno sull'interfaccia (il comando non è disponibile) e uno sul sistema (il comando, se arriva, viene rifiutato). Sono due cose diverse, e provarle richiede due prove diverse.

## 7. Come si scrive nella spec

```
STATI: Bozza (iniziale) · Inviata · Approvata · Respinta · Archiviata (finale)

TRANSIZIONI PERMESSE
  Bozza     → Inviata      · autore · solo se ha almeno una riga
  Inviata   → Bozza        · autore · entro 24h dall'invio
  Inviata   → Approvata    · approvatore · MAI su richiesta propria
  Inviata   → Respinta     · approvatore · richiede una motivazione
  Approvata → Archiviata   · sistema · 90 giorni dopo l'approvazione

VIETATE (criteri negativi, uno per riga, rifiuto lato sistema)
  qualsiasi → Bozza da Approvata o Archiviata
  Bozza     → Approvata (salto)
  Archiviata→ qualsiasi

EFFETTI
  → Inviata:    numero di protocollo assegnato (DEFINITIVO), mail all'approvatore
  → Approvata:  righe immutabili, mail all'autore
  se la mail fallisce: lo stato cambia comunque, l'errore va nel registro
```

## Checklist prima di consegnare la spec

- [ ] L'elenco degli stati è chiuso, con un nome solo per stato
- [ ] Sono dichiarati lo stato iniziale e quelli finali
- [ ] Esiste la **griglia completa** da ogni stato verso ogni stato
- [ ] Le transizioni vietate sono diventate criteri negativi
- [ ] Provati sulla carta: il salto, il ritorno, la ripetizione, la partenza da uno stato finale
- [ ] Per ogni permessa: **chi**, **quando**, **a quali condizioni sui dati**
- [ ] Verificato il caso «su sé stessi» (approvare la propria, togliersi il ruolo)
- [ ] Per ogni transizione: cosa scatta, cosa è definitivo, cosa succede se fallisce a metà
- [ ] Ogni divieto ha **due** criteri: interfaccia e sistema
