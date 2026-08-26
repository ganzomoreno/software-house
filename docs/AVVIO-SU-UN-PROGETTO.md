# Avvio della software house su un progetto

> **A cosa serve:** accendere la software house su un progetto e adattarla al suo contesto, in due sessioni.
> **Come si usa:** si copia il blocco della **Fase 1**, si incolla in una sessione sul progetto, si aspetta. Poi si apre una sessione nuova e si incolla il blocco della **Fase 2**.
> Ultimo aggiornamento: 2026-08-26

---

## Perché servono due sessioni

Agenti e discipline vengono letti **all'avvio della sessione**. Una sessione non può accendere sé stessa: se i file non c'erano quando è partita, non li vedrà comparire nemmeno dopo averli scritti.

| | Cosa fa | Cosa serve |
|---|---|---|
| **Fase 1** | copia agenti e discipline nel progetto, scrive il contesto, porta tutto sul ramo | una sessione qualsiasi sul progetto |
| **Fase 2** | verifica che la squadra sia davvero arrivata, e la mette alla prova | una **sessione nuova**, aperta dopo la Fase 1 |

> La Fase 1 è **rieseguibile**: rimuove la copia precedente prima di riscrivere e non tocca gli agenti e le discipline propri del progetto. Non è mai dannosa.

---

# FASE 1 — Accendere la squadra

Copia da qui, incolla nella sessione sul progetto.

```text
Devi accendere su questo progetto la "software house portatile": cinque agenti
specializzati e dodici discipline di mestiere.

Il manuale completo è qui, leggilo prima di procedere:
https://github.com/ganzomoreno/software-house/blob/main/docs/MANUALE.md

Fai questi passi, in ordine, e lavora in silenzio fino alla fine.

PASSO 1 — Installa la squadra nel progetto
Dalla cartella principale del progetto, esegui:

curl -fsSL https://raw.githubusercontent.com/ganzomoreno/software-house/main/scripts/installa.sh | bash

Copia i cinque agenti e le discipline in .claude/agents/ e .claude/skills/.
Riportami cosa ha stampato: la versione, e quanti agenti e discipline ha copiato.

NON usare il marketplace e non affidarti a extraKnownMarketplaces nel
settings.json: quella dichiarazione registra il marketplace ma NON installa il
plugin (difetto noto di Claude Code, issue #32606). Se nel settings.json c'è
già, lasciala dov'è: non fa danno.

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

PASSO 4 — Portalo sul ramo giusto
Fai commit delle modifiche. Poi dimmi su QUALE ramo partono normalmente le mie
sessioni di lavoro su questo progetto, leggendolo dal CLAUDE.md: potrebbe non
essere il ramo principale.
Se il lavoro non è già su quel ramo, portacelo seguendo la convenzione del
progetto. Se la via prevista è un'unione ma questa trascinerebbe file che non
c'entrano con questo lavoro, FERMATI e dimmelo: non forzare, e proponimi la
via corretta. Non unire nulla al ramo principale senza chiedermelo.

RISPONDIMI UNA VOLTA SOLA, alla fine, in elenchi puntati:
- prima cosa serve da me (le voci di contesto mancanti del PASSO 2, e ogni dubbio)
- poi cosa hai fatto
Niente cronaca dei passi, niente tabelle.
```

## ⚠️ Fra la Fase 1 e la Fase 2 — il passaggio che si dimentica

La Fase 1 lascia il suo lavoro **su un ramo**, come deve. Ma la sessione della Fase 2 parte dal ramo che le indichi: se è il ramo principale, **non vedrà nulla di quanto scritto in Fase 1**.

Quindi, prima di aprire la sessione nuova, il lavoro della Fase 1 deve arrivare **sul ramo da cui partiranno le tue sessioni** — che **non è per forza il ramo principale**: su molti progetti si lavora su un ramo dedicato a un ambiente.

Tre modi, in ordine di preferenza:

1. **Apri la Fase 2 direttamente sul ramo della Fase 1.** È il modo più semplice e non muove niente. Se vuoi solo provare, fermati qui.
2. **Porta il lavoro sul ramo di lavoro seguendo la convenzione del progetto** (unione, oppure ricopiatura dei singoli commit: decide il progetto, non questa procedura).
3. **Uniscilo al ramo principale**, se il progetto lavora così.

### ⚠️ Attenzione a una trappola: da dove nasce il ramo della Fase 1

Una sessione crea il proprio ramo partendo dal ramo su cui è stata aperta — spesso quello **principale**. Se il tuo ramo di lavoro è un altro, unire il ramo della Fase 1 significa **trascinarci dentro tutto il ramo principale**, non le tue tre righe di documentazione.

Su progetti con più ambienti questa manovra è quasi sempre **vietata** (si propaga solo in una direzione, e verso l'ambiente di prova si porta roba scelta a mano). Il sintomo è inconfondibile: **l'unione mostra decine di file in conflitto invece dei due o tre che hai toccato.**

> **La regola:** se l'unione tocca file che non c'entrano con la Fase 1, **fermati**. La via giusta è quella prevista dal progetto per portare un lavoro su quel ramo — quasi sempre ricopiare i singoli commit, uno per volta. Tre righe di documentazione non giustificano mai di mettere le mani in un lavoro in corso.

**E in ogni caso: apri la Fase 2 sul ramo dove il lavoro è finito davvero.**

> Attenzione a cosa dipende da cosa. I file in `.claude/agents/` e `.claude/skills/` decidono **se la squadra arriva**; il `CLAUDE.md` decide **come si comporta** (le discipline escluse, il contesto). Sono sullo stesso ramo, quindi arrivano insieme — ma se porti solo una delle due cose, il sintomo è subdolo: la squadra c'è, sembra tutto a posto, e applica discipline che avevi escluso.

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
3. Esiste nel progetto il file .claude/.software-house? Riportami la riga con
   la versione. (È il registro di cosa è stato copiato dallo script.)
   Nota: la checklist di processo all'avvio arriva da un hook del plugin e con
   l'installazione per copia diretta NON c'è. Non è un difetto: il flusso di
   lavoro sta nella disciplina "pipeline", che devi vedere fra le discipline.
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
| Nessun agente, nessuna disciplina — ma altri plugin risultano caricati | la squadra non è mai stata copiata nel progetto, oppure la copia non è sul ramo da cui è partita la sessione | esegui lo script della Fase 1 e verifica su quale ramo è finita la cartella `.claude/` |
| Nessun agente, e nel `settings.json` c'è la dichiarazione del marketplace | è la trappola: quella dichiarazione **non installa il plugin** ([issue #32606](https://github.com/anthropics/claude-code/issues/32606)) | usa lo script di copia diretta, non il marketplace |
| Gli agenti ci sono, le discipline no | copia parziale, o interrotta | riesegui lo script: è rieseguibile e ripulisce da solo |
| C'era tutto ieri, oggi no | la sessione è stata aperta prima che la copia arrivasse su quel ramo | apri una sessione nuova sul ramo giusto |
| Discipline vecchie, senza le ultime aggiunte | lo script copia da `main` della software house: la novità è ancora su un ramo di sviluppo | uniscila a `main`, poi riesegui lo script |

> Lo script copia dal **ramo principale** del repository della software house. Il lavoro fatto su un ramo di sviluppo non raggiunge i progetti finché non è unito.
