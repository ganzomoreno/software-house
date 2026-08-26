# Contesto di progetto — modello da compilare

> Copia questo file nel `CLAUDE.md` del progetto (o accanto ad esso) e compilalo.
> Il plugin `software-house` porta il **mestiere**; qui va il **contesto**, che il plugin non può conoscere.
> Se una voce non si applica al progetto, scrivilo esplicitamente invece di lasciarla vuota: "non applicabile" è un'informazione, il vuoto è un dubbio.
> Ultimo aggiornamento: 2026-08-26

## Chi è chi
- **Business / committente**: chi decide priorità e prodotto.
- **Sviluppatori esterni**: chi possiede l'architettura, revisiona e porta in produzione. Nome, canale di contatto, link alla loro guida operativa.
- **Chi fa il collaudo finale.**

## Rami e ambienti
| Ramo | Ambiente | Dati | Chi ci scrive |
|---|---|---|---|
| | | | |

Regole di propagazione fra rami, e le operazioni **vietate** (con il motivo: un divieto senza motivo non regge alla prima fretta).

## Stack e comandi
- Framework, database, servizi esterni.
- Come si avvia in locale (porta compresa), come si eseguono test, controllo tipi, lint.

## Dove vive la documentazione
- Registro di sviluppo (il file dove ogni lavoro lascia traccia).
- Task list (il metodo di lavoro condiviso col Business).
- Specifiche funzionali.

## Utenze di prova — una per ruolo

Senza un'utenza per **ogni** ruolo, la matrice delle prove dal front end non si può riempire e la copertura resta un'opinione. Compila questa tabella per intero: una riga per ruolo, comprese le utenze che servono solo a verificare che qualcuno **non** possa fare qualcosa.

| Ruolo | Utenza | Dove sta la password | Cosa serve a dimostrare |
|---|---|---|---|
| | | | |
| | | | |
| anonimo (non autenticato) | — | — | che ciò che è riservato resti irraggiungibile |

- **Dove sta la password**: nella configurazione dell'ambiente, mai nel codice versionato. Scrivi *dove si trova*, non il valore.
- Se serve una **casella di posta** raggiungibile per verificare le notifiche, indicala qui: senza, i criteri sulle email non sono dimostrabili.
- **Utenze di prova dedicate** su ambiente non di produzione: le usa chi prova.
  **Credenziali di persone reali**: mai, quelle le digita l'utente in prima persona.
- Se un ruolo non ha ancora un'utenza, **scrivilo qui come lacuna aperta** invece di lasciare la riga vuota: è ciò che resterà non dimostrato a ogni consegna.

## Incidenti da non ripetere
Uno per riga: cosa è successo, quale regola ne è nata. Sono la parte più preziosa e la più facile da perdere.

## Discipline della software house NON in uso su questo progetto

Il plugin porta tutto il mestiere; non tutti i progetti usano tutto. Qui si dichiara cosa **non** si applica, e chi se ne occupa al posto nostro.

```
- `<nome-disciplina>` — deciso da <chi>, il <data>
  Motivo: <perché su questo progetto quel lavoro è inutile o dannoso>
  Se ne occupano: <chi, al posto nostro>
  Cosa smette di essere controllato: <cosa il code-reviewer non solleverà più>
  ⚠️ Vale finché: <la condizione che regge il motivo>
```

Quattro regole perché l'esclusione non diventi un buco:
1. **Il motivo** va scritto, e deve reggere da solo fra sei mesi. Un motivo regge quando descrive una proprietà del progetto (*«è un prototipo che verrà riscritto»*, *«è di un altro team»*, *«non si applica»*), non una condizione di chi lavora (*«non abbiamo tempo»*, *«non è mai successo niente»*).
2. **Chi se ne occupa al posto nostro** va nominato. Senza destinatario non è una delega: è una competenza rimasta senza proprietario.
3. **Cosa smette di essere controllato** va scritto: è esattamente ciò che il cancello non fermerà più.
4. **Data e decisore**, sempre. Un'esclusione senza data non si rivede mai.

Se il motivo poggia su una condizione (un ambiente finto, una fase del progetto), **scrivi la condizione**: il giorno in cui cade, cadono con lei tutte le esclusioni che ci poggiavano, e nessuno se ne ricorda da solo.

> L'esclusione vale per la **disciplina nominata**, non per il tema. Escludere la sicurezza del database non toglie i criteri negativi dell'analista né le prove sulle transizioni vietate: quelli sono correttezza funzionale, non sicurezza di sistema.

## Vincoli specifici
Limiti del piano di hosting, aggiramenti di rete, vincoli normativi, vincoli di brand e tipografia.
