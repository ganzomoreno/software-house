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

## Utenze di prova
Quali esistono, per quale ruolo, e **come si accede** (le credenziali le digita l'utente, non l'assistente).

## Incidenti da non ripetere
Uno per riga: cosa è successo, quale regola ne è nata. Sono la parte più preziosa e la più facile da perdere.

## Discipline della software house NON in uso su questo progetto

Il plugin porta tutto il mestiere; non tutti i progetti usano tutto. Qui si dichiara cosa **non** si applica, e chi se ne occupa al posto nostro.

```
- `<nome-disciplina>` — se ne occupa: <chi> — deciso da <chi>, il <data>
  Cosa smette di essere controllato: <cosa il code-reviewer non solleverà più>
```

Tre regole perché l'esclusione non diventi un buco:
1. **Chi se ne occupa al posto nostro** va nominato. Senza destinatario non è una delega: è una competenza rimasta senza proprietario.
2. **Cosa smette di essere controllato** va scritto: è esattamente ciò che il cancello non fermerà più.
3. **Data e decisore**, sempre. Un'esclusione senza data non si rivede mai.

> L'esclusione vale per la **disciplina nominata**, non per il tema. Escludere la sicurezza del database non toglie i criteri negativi dell'analista né le prove sulle transizioni vietate: quelli sono correttezza funzionale, non sicurezza di sistema.

## Vincoli specifici
Limiti del piano di hosting, aggiramenti di rete, vincoli normativi, vincoli di brand e tipografia.
