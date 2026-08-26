---
name: modello-dei-dati
description: Come si legge e si descrive un modello dati prima di scrivere una specifica — entità, cardinalità, chiavi, il ciclo di vita di un record, cosa succede alla cancellazione, i campi opzionali e le denormalizzazioni. Da usare quando una richiesta tocca dati che devono essere creati, collegati, modificati o cancellati.
---

# Modello dei dati

> **Un criterio scritto senza aver capito il modello dati è un criterio che l'implementazione non può soddisfare.**
> È la causa più frequente di specifica rifiutata: non era sbagliata l'idea, era impossibile la struttura.

## 1. Le quattro domande, prima di scrivere qualsiasi criterio

Per ogni entità che la richiesta tocca:

1. **Chi la possiede?** Un record appartiene a un utente, a un'organizzazione, a nessuno? Da questa risposta discendono tutti i criteri di visibilità e di permesso.
2. **Quanti a quanti?** Un ordine ha *una* fattura o *molte*? Un utente sta in *un* gruppo o in *molti*? Sbagliare la cardinalità in specifica costa un rifacimento, non una correzione.
3. **Cosa la rende unica?** Se due record possono avere gli stessi valori, il sistema li distingue come? E cosa succede se qualcuno crea il duplicato?
4. **Che cosa le succede nel tempo?** Nasce, cambia, muore. Ogni passaggio è un criterio.

## 2. ⭐ Le cardinalità e come si scrivono

Non scrivere «l'ordine ha le righe». Scrivi la cardinalità **su entrambi i lati**, con i minimi:

| Forma | Come si legge | La domanda che risolve |
|---|---|---|
| **1 → 0..N** | un ordine ha zero o più righe | può esistere un ordine **vuoto**? |
| **1 → 1..N** | un ordine ha almeno una riga | l'ordine vuoto è vietato: chi lo impedisce, e quando? |
| **0..1 → 1** | una riga può non avere ordine | esistono righe orfane? come ci arrivano? |
| **N ↔ N** | utenti e gruppi | serve una terza entità, e **quella entità ha campi propri?** (da quando, con che ruolo) |

**Il minimo è la parte che tutti dimenticano**, ed è quella che genera i casi limite: `0..N` vuol dire che lo stato vuoto esiste e va disegnato.

## 3. Il ciclo di vita di un record

Per ogni entità nuova, la specifica deve rispondere a queste, esplicitamente:

- **Chi la crea**, da quale schermata o processo, e con quali campi obbligatori al primo salvataggio.
- **Chi la può modificare**, e **quali campi diventano immutabili dopo un certo punto** (il prezzo dopo la conferma, il codice fiscale dopo la validazione).
- **Chi la può cancellare**, e — la domanda vera — **cosa succede a ciò che le è attaccato**.
- **Se sopravvive alla cancellazione di chi la possiede** (un ordine resta se l'utente viene rimosso?).

## 4. La cancellazione — dove si fanno i danni

Ci sono tre comportamenti possibili, e **vanno scelti, non subiti**:

| Comportamento | Cosa fa | Quando è giusto |
|---|---|---|
| **Blocca** | non si può cancellare finché ci sono figli | il collegamento ha valore legale o contabile |
| **Trascina** | cancella anche i figli | i figli non hanno senso da soli (le righe di un ordine) |
| **Slega** | i figli restano, senza padre | il figlio ha vita propria (un commento resta se la categoria sparisce) |

E poi la domanda che cambia tutto: **la cancellazione è reale o è una marcatura?**
Se il record resta e viene solo marcato come cancellato, **ogni singola lettura del sistema deve escluderlo** — e ogni punto che se lo dimentica è un difetto. Se scegli la marcatura, va scritto come criterio: *«i record marcati non compaiono in nessun elenco, conteggio o esportazione»*.

## 5. I campi opzionali sono decisioni, non pigrizia

Un campo che può essere vuoto raddoppia i casi da provare, per sempre. Prima di dichiararlo opzionale:

- **È opzionale sempre, o solo all'inizio?** (spesso è: obbligatorio dal momento X in poi — e quello è un criterio)
- **Cosa mostra l'interfaccia quando è vuoto?** Un trattino, uno spazio bianco, un valore predefinito? Va deciso qui, non lasciato a chi implementa.
- **Vuoto e zero sono la stessa cosa?** Quasi mai. «Sconto non impostato» e «sconto zero» sono due situazioni diverse, e confonderle è un difetto classico.

## 6. I dati copiati (denormalizzazioni)

Quando lo stesso dato vive in due posti — il nome del cliente copiato sulla fattura, il totale salvato invece che ricalcolato — **è una scelta legittima**, ma genera un obbligo:

> **Chi tiene allineate le due copie, e cosa succede quando l'originale cambia?**

Due casi opposti, entrambi corretti:
- Il totale della fattura **non si aggiorna** se il listino cambia: la fattura è una fotografia. → criterio esplicito.
- Il nome del cliente in elenco **si aggiorna** se cambia in anagrafica. → criterio esplicito, e qualcuno deve propagarlo.

Se la specifica non lo dice, chi implementa sceglie a caso, e la metà delle volte sceglie l'opposto di quello che serviva.

## 7. Cosa scrivere nella spec

Non serve un diagramma. Servono queste righe, per ogni entità toccata:

```
ENTITÀ: Fattura
  possiede: Organizzazione (1 → 0..N)
  contiene: Riga (1 → 1..N, mai vuota)
  unica per: numero + anno, per organizzazione
  immutabile dopo: emissione (numero, data, totale)
  cancellazione: BLOCCATA se emessa; marcatura, mai reale
  copie: nome e indirizzo cliente sono fotografia, NON si aggiornano
```

Sei righe che evitano tre giri di chiarimenti.

## Checklist prima di consegnare la spec

- [ ] Per ogni entità: chi la possiede, cardinalità **con i minimi**, cosa la rende unica
- [ ] Il ciclo di vita è scritto: chi crea, chi modifica, cosa diventa immutabile e quando
- [ ] La cancellazione ha un comportamento **scelto** (blocca / trascina / slega)
- [ ] Se è marcatura e non cancellazione reale, c'è il criterio che esclude i marcati **ovunque**
- [ ] Ogni campo opzionale dice cosa mostra l'interfaccia quando è vuoto
- [ ] Vuoto e zero sono stati distinti dove serve
- [ ] Ogni dato copiato dichiara se è fotografia o se si aggiorna
