# Avvio della software house su un progetto

> **A cosa serve:** accendere la software house su un progetto e adattarla al suo contesto, in due sessioni.
> **Come si usa:** si copia il blocco della **Fase 1**, si incolla in una sessione sul progetto, si aspetta. Poi si apre una sessione nuova e si incolla il blocco della **Fase 2**.
> Ultimo aggiornamento: 2026-08-26

---

## Perché servono due sessioni

Il plugin viene letto **all'avvio della sessione**. Una sessione non può accendere sé stessa: se la configurazione non c'era quando è partita, non la vedrà comparire nemmeno dopo averla scritta.

| | Cosa fa | Cosa serve |
|---|---|---|
| **Fase 1** | scrive la configurazione e il contesto, e li porta sul ramo | una sessione qualsiasi sul progetto |
| **Fase 2** | verifica che la squadra sia davvero arrivata, e la mette alla prova | una **sessione nuova**, aperta dopo la Fase 1 |

> Se la configurazione c'è già e il ramo principale è aggiornato, la Fase 1 non fa nulla e lo dice. Non è mai dannosa.

---

# FASE 1 — Accendere la squadra

Copia da qui, incolla nella sessione sul progetto.

```text
Devi accendere su questo progetto la "software house portatile": un plugin con
cinque agenti specializzati e dodici discipline di mestiere.

Il manuale completo è qui, leggilo prima di procedere:
https://github.com/ganzomoreno/software-house/blob/main/docs/MANUALE.md

Fai questi passi, in ordine, e lavora in silenzio fino alla fine.

PASSO 1 — Configurazione del progetto
Verifica se esiste .claude/settings.json in questo repository e se contiene il
richiamo al marketplace "ganzomoreno". Se manca, o se manca solo una delle due
chiavi, aggiungilo SENZA rimuovere le altre impostazioni già presenti:

{
  "extraKnownMarketplaces": {
    "ganzomoreno": { "source": { "source": "github", "repo": "ganzomoreno/software-house" } }
  },
  "enabledPlugins": { "software-house@ganzomoreno": true }
}

Va nel file di configurazione DEL PROGETTO (versionato), non su quello della
macchina: è l'unico modo perché funzioni anche in cloud e per chiunque nel team.

PASSO 2 — Contesto di progetto
Il plugin porta il mestiere; il contesto resta qui. Verifica che il CLAUDE.md di
questo progetto copra le voci del modello:
https://github.com/ganzomoreno/software-house/blob/main/templates/CONTESTO-PROGETTO.md

Non riscrivere quello che c'è già. Elencami solo le voci MANCANTI, senza inventarle:
chi sono gli sviluppatori esterni, rami e ambienti, stack e comandi, dove vive il
registro di sviluppo, utenze di prova, incidenti da non ripetere, vincoli specifici.

PASSO 3 — Discipline escluse su questo progetto
Aggiungi al CLAUDE.md questa sezione, esattamente com'è:

## Discipline della software house NON in uso su questo progetto

- `sicurezza-database` — deciso da Ale, il 26/08/2026
  Motivo: questo è un ambiente prototipo. Gli sviluppatori esterni riscrivono sopra
  con le loro tecniche prima della produzione, quindi il lavoro di sicurezza fatto
  qui verrebbe buttato via. Farlo "decente" costerebbe senza lasciare nulla: meglio
  farlo dichiaratamente finto.
  Se ne occupano: gli sviluppatori esterni, sulla loro riscrittura.
  Cosa smette di essere controllato: il code-reviewer non solleverà più rilievi su
  permessi, ruoli, policy e funzioni privilegiate.
  ⚠️ Vale finché l'ambiente resta un prototipo destinato a essere riscritto. Se un
  giorno venisse promosso così com'è, questa esclusione cade.

> L'esclusione vale per la disciplina nominata, non per il tema. Restano attivi i
> criteri negativi dell'analista (chi non deve potere) e le prove sulle transizioni
> vietate: sono correttezza funzionale, non sicurezza di sistema.

PASSO 4 — Portalo sul ramo
Fai commit delle modifiche e portale sul ramo di lavoro. Non unire nulla al ramo
principale senza chiedermelo.

RISPONDIMI UNA VOLTA SOLA, alla fine, in elenchi puntati:
- prima cosa serve da me (le voci di contesto mancanti del PASSO 2, e ogni dubbio)
- poi cosa hai fatto
Niente cronaca dei passi, niente tabelle.
```

## ⚠️ Fra la Fase 1 e la Fase 2 — il passaggio che si dimentica

La Fase 1 lascia il suo lavoro **su un ramo**, come deve. Ma la sessione della Fase 2 parte dal ramo che le indichi: se è il ramo principale, **non vedrà nulla di quanto scritto in Fase 1**.

Quindi, prima di aprire la sessione nuova, una delle due:

- **unisci il ramo della Fase 1** al ramo principale del progetto (la via normale), **oppure**
- **apri la Fase 2 direttamente su quel ramo**, se preferisci provare prima di unire.

> Attenzione a cosa dipende da cosa. La configurazione `.claude/settings.json` decide **se il plugin arriva**; il `CLAUDE.md` decide **come si comporta** (le discipline escluse, il contesto). Se la configurazione c'era già da prima, il plugin arriva comunque — ma le esclusioni scritte in Fase 1 restano invisibili finché il ramo non è unito. **Il sintomo è subdolo:** la squadra c'è, sembra tutto a posto, e applica discipline che avevi escluso.

**Poi chiudi la sessione della Fase 1.**

---

# FASE 2 — Verificare che sia arrivata davvero, e provarla

Apri una **sessione nuova** sul progetto. Copia da qui, incolla.

```text
Su questo progetto dovrebbe essere attiva la "software house portatile": cinque
agenti specializzati con dodici discipline di mestiere, orchestrati da te
(sei tu Silvana, il coordinatore).

Manuale: https://github.com/ganzomoreno/software-house/blob/main/docs/MANUALE.md

Prima di qualsiasi altra cosa, VERIFICA che sia davvero arrivata e dimmi cosa vedi:

1. Quali agenti hai a disposizione? Devono essere questi cinque:
   ux-designer · analista-funzionale · developer · test-farm · code-reviewer
2. Quali discipline (skill) vedi elencate? Devono essercene dodici:
   interfacce-usabili · parole-nell-interfaccia · criteri-di-accettazione ·
   modello-dei-dati · macchine-a-stati · regole-di-business · codice-verificabile ·
   casi-di-prova · revisione-onesta · verifica-per-mutazione ·
   migrazioni-database · sicurezza-database
   (più "pipeline", che è il flusso di lavoro)
3. All'avvio di questa sessione hai ricevuto una checklist di processo della
   software house? Riportami la prima riga.
4. Il CLAUDE.md di questo progetto contiene la sezione «Discipline della software
   house NON in uso su questo progetto»? Riportamela testualmente.
   Se NON c'è, quasi certamente il ramo della Fase 1 non è stato unito: dimmelo,
   non proseguire.

Se manca qualcosa, FERMATI e dimmelo: non provare a rimediare da sola.
Se c'è tutto, dimmi "squadra a bordo" e aspetta il primo lavoro.
```

---

# FASE 3 — Il primo lavoro vero

Quando la Fase 2 dice «squadra a bordo», dalle un lavoro di **livello 2**: una funzione piccola ma con dentro **una regola con eccezioni**. È il caso che mette alla prova più discipline in un colpo solo.

```text
[descrivi qui il lavoro, con le sue eccezioni: "... tranne quando ..."]

Trattalo come un livello 2 e segui la pipeline per intero. Voglio vedere:
- la spec dell'analista con i criteri numerati, PRIMA che si scriva codice —
  fermati lì e fammela leggere
- poi implementazione, test e revisione

Alla fine, oltre al lavoro, dimmi due cose:
- quali discipline hanno aperto gli agenti, e quale è servita davvero
- dove il metodo ha stretto: una regola che non calzava, un passaggio inutile,
  una cosa che il plugin dà per scontata e qui non vale
```

**L'ultima domanda è la più importante.** L'attrito è il dato con cui il metodo si corregge: una regola che non calza su un progetto sta dicendo che era contesto travestito da mestiere. Riportamelo e la sistemiamo.

---

## Se qualcosa non arriva — le tre cause, in ordine di frequenza

| Sintomo | Causa quasi certa | Rimedio |
|---|---|---|
| Nessun agente, nessuna disciplina | manca `.claude/settings.json`, o non è sul ramo che la sessione usa | rifai la Fase 1 e verifica su quale ramo è finita |
| Gli agenti ci sono, le discipline no | il plugin arriva da una versione vecchia del ramo principale | verifica che `main` di `ganzomoreno/software-house` sia almeno alla v0.6.0 |
| C'era tutto ieri, oggi no | la sessione è stata aperta prima dell'aggiornamento | apri una sessione nuova |

## Appendice — Rami e ambienti, per chi non è tecnico

### Cos'è un ramo

Immagina il repository come **un raccoglitore di documenti condiviso**.

- Il **ramo principale** (`main`) è la copia ufficiale: quella che vale, quella che gli altri leggono.
- Un **ramo** è una **fotocopia di lavoro**. Ci scrivi sopra senza disturbare nessuno: finché stai lì, la copia ufficiale non cambia di una virgola.
- **Unire un ramo** (*merge*) vuol dire: *«prendi le mie modifiche e portale sulla copia ufficiale».* Da quel momento valgono per tutti.

Finché un ramo non è unito, **il suo lavoro esiste ma non conta**: chi legge la copia ufficiale non lo vede.

### Perché ci sono tanti rami e nessuno li ha fatti apposta

Ogni sessione di lavoro ne crea uno nuovo, automaticamente, per non pestare i piedi alle altre. Quindi si accumulano: sono i resti delle sessioni passate. **Non fanno danno** — sono fotocopie ferme in un cassetto. Si possono cancellare quando il loro lavoro è stato unito, ma non è urgente.

### Rami e ambienti: due cose diverse che si somigliano

Un **ambiente** è un posto dove il programma **gira davvero**: produzione (i clienti veri), staging (le prove prima di pubblicare), sandbox (il campo giochi).

Un **ramo** è solo testo in un raccoglitore: non gira da nessuna parte.

Il legame è una **convenzione decisa dal progetto**: «quando qualcosa arriva su questo ramo, il sistema lo pubblica su quell'ambiente». La mappa non è mai deducibile da fuori — **sta scritta nel `CLAUDE.md` del progetto**, alla voce rami e ambienti. Se non sai qual è la tua, chiedila alla sessione: lei quel file lo legge.

### ⭐ La cosa che toglie l'ansia: la configurazione non è programma

I file che questa procedura tocca — `.claude/settings.json` e la parte di `CLAUDE.md` sulla software house — **non sono codice del prodotto**.

- **Non vengono pubblicati** su nessun ambiente. Non finiscono davanti a un cliente.
- **Non girano.** Nessuno li esegue: sono istruzioni che una sessione di lavoro legge quando parte.
- **Non cambiano il comportamento del programma.** Cambiano il comportamento **dell'assistente**.

> Conseguenza pratica: **non c'è un ambiente giusto o sbagliato dove metterli.** Devono solo stare **sul ramo da cui partono le tue sessioni**. Chi lavora su altri rami semplicemente non li vede, e per lui è come se non esistessero.

È il motivo per cui questa procedura non interferisce con nessuno: non tocca niente di ciò che va in produzione.

---

> Il plugin viene servito dal **ramo principale** del repository della software house. Il lavoro fatto su un ramo di sviluppo non raggiunge i progetti finché non è unito.
