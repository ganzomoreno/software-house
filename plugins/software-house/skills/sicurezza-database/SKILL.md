---
name: sicurezza-database
description: Le trappole ricorrenti della sicurezza a livello di database — viste che ignorano le policy, UPDATE senza WITH CHECK, funzioni privilegiate esposte, autorizzazioni su dati modificabili dall'utente — con le query di verifica eseguibili. Da usare quando si revisiona o si scrive codice che tocca ruoli, permessi, policy o funzioni privilegiate.
---

# Sicurezza a livello di database

## Il principio che governa tutto

> **La policy sul database è l'autorità finale.** Un controllo applicativo è un'ottimizzazione dell'esperienza utente, non una difesa.
> Se una cosa non deve essere possibile, deve essere **impossibile nel database** — anche chiamando l'API direttamente, con un token valido, saltando l'interfaccia.

**Corollario:** un controllo applicativo che duplica una policy non è sicurezza in più, è **churn** — due punti da tenere allineati, di cui uno mente prima o poi.

## Le quattro trappole ricorrenti

1. **Viste che ignorano le policy.** Una vista non eredita le policy delle tabelle sottostanti a meno che non sia dichiarata esplicitamente. **È un modo perfettamente legale di aggirare una policy senza accorgersene.**

2. **Policy `UPDATE` senza `WITH CHECK`.** `USING` filtra *quali righe* puoi aggiornare; `WITH CHECK` vincola *in cosa* puoi trasformarle. Senza, si può aggiornare una riga propria **trasformandola in una riga altrui**.

3. **Funzione privilegiata in uno schema pubblico = API pubblica.** Ogni funzione a esecuzione privilegiata in uno schema esposto è chiamabile da chiunque abbia la chiave anonima. Serve permesso esplicito e `search_path` fissato.

4. **Autorizzare su dati che l'utente può modificare.** I metadati utente sono spesso scrivibili dall'utente stesso: non si autorizza mai su quelli. Si usa una funzione di ruolo lato database.

## ⭐ L'errore sottile: il percorso di degradazione

Quando esiste una gerarchia di ruoli e un amministratore può assegnarne solo di inferiori al proprio, il controllo ingenuo guarda **il livello del ruolo assegnato**. È insufficiente.

> Un amministratore assegna il ruolo *più basso* a un utente di livello *più alto* del suo. Non sta promuovendo — sta **degradando**. Se il controllo guarda solo il livello in arrivo, passa.

Il controllo corretto guarda **il livello attuale del bersaglio**, non solo quello del ruolo in arrivo. Vale su applicativo **e** database. E include la protezione da sé: nessuno può revocare il proprio ruolo.

## Query di verifica — eseguibili, non retoriche

```bash
# Policy UPDATE senza WITH CHECK
grep -rn "FOR UPDATE" <migrazioni>/*.sql | grep -v "WITH CHECK"

# Funzioni privilegiate senza search_path fissato
grep -rn -A5 "SECURITY DEFINER" <migrazioni>/*.sql | grep -B3 -L "search_path"

# Viste che non dichiarano di rispettare le policy del chiamante
grep -rn "CREATE.*VIEW" <migrazioni>/*.sql | grep -v "security_invoker"

# Autorizzazioni basate su metadati modificabili dall'utente (devono essere zero)
grep -rn "user_metadata" src/ <migrazioni>/
```

## Chiave di servizio

- **La chiave di servizio bypassa TUTTE le policy.** Vive solo lato server, mai in codice che raggiunge il browser.
- Ogni uso va giustificato: *perché questa operazione non può passare dalla policy?* Se la risposta è *"perché sarebbe scomodo"*, la risposta è sbagliata.
- Le variabili con prefisso pubblico sono pubbliche per definizione: se ci finisce un segreto, è compromesso.

## Checklist di review

- [ ] La regola è applicata **nel database**, non solo nell'applicativo
- [ ] Le policy `UPDATE` hanno `WITH CHECK`, non solo `USING`
- [ ] Ogni funzione privilegiata ha `search_path` fissato e permessi espliciti
- [ ] Le viste nuove rispettano le policy del chiamante, o è dichiarato perché no
- [ ] Nessuna autorizzazione basata su dati modificabili dall'utente
- [ ] Se tocca i ruoli: testato il **percorso di degradazione**, non solo la promozione
- [ ] Ogni uso della chiave di servizio è giustificato per iscritto
