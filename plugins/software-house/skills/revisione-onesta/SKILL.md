---
name: revisione-onesta
description: Come si emette un verdetto che tiene — cosa merita davvero un bloccante, le trappole che sbilanciano verso il sì e quelle che sbilanciano verso il no, cosa fare quando non puoi verificare, il segnale che stai validando invece di dubitare. Da usare in ogni code review e ogni volta che si deve dare un giudizio su lavoro altrui.
---

# Revisione onesta

> Una revisione può fallire in **due direzioni**, e costano uguale:
> **approvare un difetto** manda in produzione un guasto. **Bloccare su un gusto** ferma il lavoro, brucia la fiducia nel cancello, e la volta dopo nessuno lo prende sul serio.
> Il mestiere sta nel non sbilanciarsi né di qua né di là.

## 1. Cosa merita un 🔴

Un bloccante richiede un **difetto dimostrabile**. Uno di questi quattro:

1. **Un criterio di accettazione violato** — cita il numero del criterio.
2. **Un difetto riproducibile** — dì con quale ingresso, e quale esito sbagliato.
3. **Una regressione** — qualcosa che funzionava e ora no, o un file toccato fuori perimetro.
4. **Un presidio saltato** — un controllo di sicurezza, un permesso, un vincolo che c'era e non c'è più.

Tutto il resto è 🟡 (da valutare) o 🟢 (nota). **Un sospetto non è un bloccante.** Se pensi che ci sia un difetto ma non sai mostrarlo, dillo come 🟡 e scrivi cosa andrebbe verificato.

## 2. ⭐ Le trappole che ti spingono a dire di sì

Sono le più pericolose, perché non si sentono: sembrano ragionevolezza.

| Trappola | Come si manifesta | L'antidoto |
|---|---|---|
| **L'ancoraggio** | ti arriva il diff **insieme alla conclusione** di chi l'ha scritto («è a posto, ho verificato») | leggi il diff **prima** di leggere la sua sintesi. Chi te lo passa dovrebbe darti l'artefatto, non il verdetto |
| **La dichiarazione** | «i test passano», «ho controllato» | **verifica tu.** Una dichiarazione non è un esito |
| **La stanchezza del diff lungo** | i primi file revisionati bene, gli ultimi scorsi | se è troppo lungo, dillo e chiedi di spezzarlo: è un rilievo legittimo |
| **Il test che sembra proteggere** | c'è un test col nome giusto, quindi il caso è coperto | **mutalo**: rompi la riga di produzione, controlla che il test fallisca, ripristina. Un test che non morde è teatro |
| **La fretta** | «è piccola, cosa vuoi che sia» | la dimensione del diff non è correlata alla dimensione del danno |

## 3. Le trappole che ti spingono a dire di no

| Trappola | Come si manifesta | L'antidoto |
|---|---|---|
| **Il gusto** | «l'avrei chiamato diversamente», «avrei usato un altro impianto» | è 🟢, salvo che tu possa mostrare un danno |
| **Il rifacimento mascherato** | proponi di riscrivere una parte che il diff si limitava a sfiorare | fuori perimetro: se serve, è un lavoro a parte |
| **Il rosso per prudenza** | non hai capito una parte, quindi blocchi | **chiedi**, o dichiara di non aver potuto verificare. Bloccare per non aver capito è scaricare su altri |
| **La checklist generica** | applichi una lista di controlli che il progetto non usa | chiedi al progetto **quali sono i suoi presidi concreti** e verifica quelli |

## 4. Rosso per progetto, rosso per difetto

Alcuni controlli falliscono **di proposito**: guardie di perimetro, limiti dichiarati, prove che documentano un vincolo noto. Non sono difetti da riparare.

Prima di segnalare un rosso, chiedi: **era previsto che fallisse?** È una violazione solo se non lo era. Segnalare un fallimento voluto come difetto fa perdere un giro e insegna a ignorare i tuoi rilievi.

## 5. Quando non puoi verificare, dillo

Un revisore onesto ha **tre** esiti possibili su ogni punto, non due:

- **verificato, va bene**
- **verificato, non va bene** → rilievo
- **non verificabile da me** → dichiarato, con il motivo

Il terzo è quello che quasi nessuno scrive, ed è quello che protegge chi legge. *«Non ho potuto provare il comportamento con l'utente di ruolo X perché non ho le credenziali»* è un'informazione preziosa. Dedurlo dal codice e scriverlo come verificato è il modo più veloce per far passare un guasto.

**Non dedurre mai da un documento ciò che si può osservare da un sistema.**

## 6. 🚨 Il segnale che stai validando invece di dubitare

> **Se in due giri consecutivi non produci nulla di azionabile, il problema non sono i diff: sei tu.**

Nessun lavoro reale è perfetto due volte di fila. Se succede, quasi sempre una di queste:

- ti stanno passando la conclusione insieme all'artefatto (§2, ancoraggio);
- stai leggendo la sintesi invece del diff;
- stai revisionando un perimetro troppo grande per essere letto davvero.

Rivedi **cosa ti viene passato e come lo leggi**, non i tuoi rilievi.

## 7. Il verdetto e la lista

Il verdetto è **bloccante**: `DA RILAVORARE` significa che non si committa. Non addolcire per non fermare il lavoro — è esattamente il compito.

Chiudi sempre con una **lista di correzioni eseguibile**, una riga per rilievo:

```
file:riga · cosa cambiare · criterio di riferimento
```

Deve poter essere girata **così com'è** a chi ha implementato, senza che nessuno la ritraduca. Una lista che va interpretata costa un giro in più a tutti.

E riporta gli **esiti numerici reali** delle verifiche che hai eseguito. Mai «tutto verde».

## Checklist prima di emettere il verdetto

- [ ] Ho letto il **diff** prima della sintesi di chi l'ha scritto
- [ ] Ogni 🔴 ha un difetto dimostrabile fra i quattro del §1, con il riferimento
- [ ] Ho **mutato** almeno un test che dichiara di proteggere qualcosa
- [ ] Ho eseguito le verifiche disponibili e riporto i **numeri**, non un giudizio
- [ ] Ho distinto il rosso previsto dalla violazione
- [ ] Ciò che non ho potuto verificare è **dichiarato**, non dedotto
- [ ] I miei rilievi di gusto sono 🟢, non 🔴
- [ ] La fix-list è eseguibile così com'è
