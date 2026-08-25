---
name: migrazioni-database
description: Come si scrive una migrazione di database senza perdere per strada un presidio — numerazione, forward-only, "riparti dalla versione vigente", guard test come parte della consegna. Da usare ogni volta che si crea, modifica o revisiona una migrazione, o si tocca una funzione, una policy o un trigger del database.
---

# Migrazioni di database

> La classe di difetto più cara che esista su un database: **riscrivere un oggetto partendo da una versione vecchia**, e rimuovere senza accorgersene un presidio che qualcuno aveva aggiunto dopo.
> È già costata, in un progetto reale, una migrazione di riparazione: la nuova versione fu scritta partendo da una RPC obsoleta, reintrodusse bug già risolti **e rimosse un gate di sicurezza**.

## 1. Numerazione — si guarda, non si indovina

```bash
ls <cartella_migrazioni>/*.sql | tail -1
```

Il prefisso è incrementale univoco. **Mai dedurre il numero a memoria o dal contesto della conversazione.**

## 2. ⭐ Riparti SEMPRE dalla versione vigente

Prima di riscrivere una funzione, una policy o un trigger, trova l'**ultima** versione applicata:

```bash
grep -rn "<nome_oggetto>" <cartella_migrazioni>/*.sql | tail -1
```

L'ultima vince. Una versione vecchia può contenere logica **deliberatamente superata**: ripartire da lì annulla silenziosamente il lavoro che l'aveva corretta.

Prima di consegnare, rispondi per iscritto a questa domanda:

> **Quale presidio c'era nella versione vigente e non c'è nella mia?**

Se non sai rispondere, non hai fatto questo passo.

## 3. Forward-only

Una migrazione già applicata **non si riscrive mai**. Se ne aggiunge una che la supera, e nell'intestazione si dichiara **cosa supera e perché**.

## 4. I presìdi da riportare avanti

| Presidio | Come si perde |
|---|---|
| Row-level security e policy | Si ricrea la tabella senza riabilitarla |
| Permessi (`GRANT`) ai ruoli | Si droppa e ricrea la funzione |
| Esecuzione privilegiata (`SECURITY DEFINER`) | Omessa nella riscrittura |
| `search_path` fissato | Omesso su una funzione privilegiata = superficie d'attacco |
| Gate applicativi (finestre temporali, limiti) | Il caso dell'incidente: sparito senza che nessuno se ne accorgesse |

Nell'output finale **elencali per nome**. Non scrivere "presìdi preservati": scrivi quali.

## 5. Ordine di applicazione

**Ambiente di prova → sviluppo → produzione.** Mai il contrario. Con esecuzione a vuoto (`--dry-run`) prima di ogni passo.

## 6. Il guard test è parte della consegna, non un passo successivo

Ogni migrazione nuova vuole il suo guard. Se l'ambiente di test non ha un database — caso comune — **il guard verifica staticamente il testo della migrazione**.

Regole del guard:
- Un test per **criterio di accettazione**, con l'ID del criterio nel nome. È ciò che rende il contratto verificabile a valle.
- Verifica i **presìdi** del §4, non solo la forma della tabella: è lì che si perde qualcosa.
- L'intestazione dichiara **perché** il guard è statico e a quale specifica risponde.

## Checklist prima di consegnare

- [ ] Numero letto dal filesystem, non indovinato
- [ ] Trovata la versione **vigente** con grep e ripartito da quella
- [ ] Elencati per nome i presìdi preservati
- [ ] Risposto a: *quale presidio c'era prima e non c'è ora?*
- [ ] `search_path` fissato su ogni funzione privilegiata
- [ ] Guard test scritto, con gli ID dei criteri
- [ ] Applicata prima all'ambiente di prova
