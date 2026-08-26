---
name: prove-dal-front-end
description: Come si prova un criterio dal front end, con l'utenza del ruolo che lo vive — la matrice ruolo per criterio, le utenze dedicate, cosa distingue una prova vera da una scorciatoia, e il formato del resoconto. Da usare ogni volta che si prova qualcosa che l'utente vede o fa, e ogni volta che si deve dire "funziona".
---

# Prove dal front end

> **Una prova unitaria dimostra che una funzione calcola bene. Non dimostra che una persona riesca a fare quello per cui è venuta.**
> Fra le due cose ci sono: un percorso, un ruolo, dei permessi, uno stato di partenza e un'interfaccia. È lì che vive la metà dei difetti, ed è la metà che l'utente incontra per prima.

## 1. ⭐ La regola, e non ha eccezioni condizionali

**Se un criterio descrive qualcosa che una persona vede o fa, si prova dal front end.** Non «quando serve», non «se il tempo lo consente»: sempre.

Le prove unitarie restano — sono più rapide, più precise e coprono i casi limite. Ma **non sostituiscono il passaggio dal front end**, lo preparano. Un criterio coperto solo da prove unitarie è un criterio **non ancora dimostrato**, e va riportato come tale.

L'unica eccezione legittima: un criterio che **nessuna persona incontra mai** — una regola interna, un vincolo di struttura, un lavoro programmato senza interfaccia. Quello si prova come si può, e si dichiara perché non passa dal front end.

## 2. La matrice: non basta «provato», serve «provato da chi lo vive»

Un criterio non è coperto quando funziona una volta. È coperto quando funziona **per ogni ruolo che lo incontra**, e quando è **negato** per ogni ruolo che non deve incontrarlo.

|  | ruolo A | ruolo B | ruolo C | anonimo |
|---|---|---|---|---|
| AC3 · vede il pulsante | ✅ deve | ✅ deve | ❌ non deve | ❌ non deve |
| AC4 · l'azione va a buon fine | ✅ | ❌ rifiutata | ❌ rifiutata | ❌ rifiutata |

**Le caselle ❌ sono metà del lavoro**, e sono quelle che nessuno prova. Un permesso che funziona è un permesso che *nega*: se non hai provato che il ruolo sbagliato viene fermato, non hai provato il permesso — hai provato solo che il ruolo giusto passa.

E vanno provate **su due piani**, perché sono due difetti diversi:
- **l'interfaccia** non mostra il comando (cortesia verso l'utente);
- **il sistema** rifiuta il comando se arriva lo stesso (la difesa vera).

Nascondere un pulsante non è un controllo di sicurezza. Chi chiama il sistema direttamente il pulsante non lo vede nemmeno.

## 3. Le utenze di prova — una per ruolo, o la matrice è vuota

Senza un'utenza per ogni ruolo, la matrice del §2 non si può riempire, e la copertura è un'opinione.

**Le utenze sono contesto di progetto** — quali ruoli esistono, come si chiamano, dove vivono le credenziali — ma il **requisito** è mestiere: *devono esistere, essere dedicate, ed essere raggiungibili da chi prova.*

| | Utenze **di prova** | Credenziali **vere** |
|---|---|---|
| Cosa sono | account dedicati, creati per provare, su ambiente **non di produzione** | l'accesso di una persona reale |
| Chi le usa | chi prova, direttamente | **solo la persona**, che le digita |
| Dove vivono | nella configurazione del progetto, mai nel codice versionato | da nessuna parte, se non nella testa di chi le possiede |
| Si possono automatizzare | **sì** | **mai** |

> **La linea:** un'utenza di prova dedicata su un ambiente che non è la produzione **si usa**. Le credenziali di una persona reale **non si toccano**: si porta il browser alla pagina di accesso e si chiede.
>
> Se il progetto non ha utenze di prova per tutti i ruoli, **è una lacuna da segnalare**, non un motivo per saltare la prova. Si prova quello che si può e si dichiara cosa è rimasto scoperto, e per quale ruolo.

## 4. Cosa distingue una prova vera da una scorciatoia

Il modo più facile di ingannarsi è **partire già arrivati**.

| ❌ Scorciatoia | ✅ Prova vera |
|---|---|
| entrare già autenticati, saltando l'accesso | percorrere l'accesso almeno una volta per ruolo |
| aprire direttamente l'indirizzo della pagina | arrivarci **dal percorso** che ci arriverebbe l'utente |
| scrivere nel database lo stato di partenza | crearlo **attraverso il sistema**, come farebbe una persona |
| controllare la risposta del server | controllare **cosa compare a video** |
| scrivere il risultato atteso nei dati | far calcolare il risultato al sistema |

> **La regola del dato fabbricato:** se la riga che stai inserendo è **ciò che la prova dovrebbe dimostrare**, è un dato fabbricato. Dare a un'utenza di prova lo stato di un utente *legittimo* è ammesso — l'esito resta calcolato dal sistema reale.

**E il percorso vero include gli stati storti.** Non solo il caso in cui tutto va bene: la lista vuota il primo giorno, l'attesa, l'errore, il modulo compilato male. Sono criteri anche quelli, e l'utente li incontra prima degli altri.

## 5. ⭐ Il resoconto — «funziona» non è un resoconto

Chi legge deve capire **cosa è dimostrato, per chi, e cosa no** senza chiedere niente a nessuno.

```
PROVE DAL FRONT END — <cosa> — <ambiente> — <data>

Utenze usate: <ruolo> = <utenza> · <ruolo> = <utenza> · …

CRITERIO   RUOLO      ATTESO              ESITO   EVIDENZA
AC3        operatore  vede il pulsante    ✅      schermata 1
AC3        cliente    NON lo vede         ✅      schermata 2
AC4        operatore  azione riuscita     ✅      schermata 3
AC4        cliente    azione rifiutata    ✅      schermata 4  (interfaccia)
AC4        cliente    rifiutata dal server ✅     risposta 403
AC5        operatore  email ricevuta      ⚠️      non verificabile: vedi sotto

Totale: 5 su 6 dimostrati.

NON DIMOSTRATO
- AC5 · nessuna utenza di prova ha una casella di posta raggiungibile:
  serve una casella dedicata al ruolo operatore. Lacuna di progetto, segnalata.

STATI PROVATI
  pieno ✅ · vuoto ✅ · in caricamento ✅ · in errore ✅ · troppo pieno ❌ non provato
```

Le tre regole del resoconto:
1. **Una riga per criterio E per ruolo.** Un criterio provato con un ruolo solo è coperto per un terzo, e la tabella lo deve mostrare.
2. **Ciò che non è dimostrato ha una sezione sua**, con il motivo. Un esito omesso viene letto come positivo.
3. **I numeri, non gli aggettivi.** «5 su 6», non «quasi tutto a posto».

## 6. Le evidenze

Ogni ✅ ha un'evidenza a cui si può tornare: una schermata, la risposta del server, il testo comparso a video. **Un ✅ senza evidenza è una dichiarazione**, e vale quanto vale la parola di chi la scrive.

Per le caselle ❌ del §2 — quelle in cui l'azione **deve** essere negata — l'evidenza è doppia: che l'interfaccia non offra il comando, **e** che il sistema lo rifiuti quando arriva.

## 7. Quando l'esito atteso è irraggiungibile

Se percorrendo il flusso al meglio l'esito non arriva, **non è solo una prova fallita**. Distingui, perché sono due cose diverse e vanno a persone diverse:

- ❌ **KO della prova** — il percorso è sbagliato, la precondizione manca, l'utenza non ha i permessi. Si ripara la prova.
- 🐛 **difetto a monte** — il sistema non produce mai quell'esito, con nessun ingresso e nessun ruolo. Si alza la mano.

Confonderli fa perdere un giro a tutti.

## Checklist prima di dire «funziona»

- [ ] Ogni criterio che una persona vede o fa è passato dal front end
- [ ] La matrice è riempita: ogni criterio per **ogni ruolo** che lo incontra
- [ ] Le caselle ❌ sono provate: chi non deve, non riesce — **a video E lato sistema**
- [ ] L'accesso è stato percorso almeno una volta per ruolo, non saltato
- [ ] Lo stato di partenza è stato creato **attraverso il sistema**
- [ ] Provati anche gli stati storti: vuoto, attesa, errore
- [ ] Ogni ✅ ha un'evidenza a cui si può tornare
- [ ] Il resoconto ha i numeri, e una sezione per ciò che **non** è dimostrato
- [ ] Le lacune di utenze sono segnalate come lacune, non nascoste
