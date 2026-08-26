---
name: interfacce-usabili
description: Le regole verificabili di un'interfaccia che funziona — i cinque stati di ogni schermata, il pavimento di accessibilità, il tempo di risposta, lo schermo stretto, i moduli. Da usare quando si progetta o si revisiona una schermata, si fa un audit di usabilità, o si decide se un rilievo è un problema o una preferenza.
---

# Interfacce usabili

> Una schermata non è finita quando è bella. È finita quando **regge i suoi stati** e chi la usa riesce a fare quello per cui è venuto.
> Il difetto di interfaccia più diffuso non è brutto: è **una schermata disegnata solo per il caso in cui tutto va bene**.

## 1. ⭐ Ogni schermata ha cinque stati, non uno

Chi disegna ne vede uno: quello pieno di dati giusti. L'utente incontra gli altri quattro.

| Stato | Cosa deve dire | L'errore tipico |
|---|---|---|
| **Pieno** | il contenuto | l'unico che viene disegnato |
| **Vuoto** | perché è vuoto e **cosa fare adesso** | «Nessun risultato», punto. Vicolo cieco |
| **In caricamento** | che sta lavorando, e su cosa | schermata bianca: sembra rotta |
| **In errore** | cosa è andato storto e **come rimediare** | «Si è verificato un errore» |
| **Troppo pieno** | come si restringe (filtro, ricerca, pagine) | 2.000 righe e nessun modo di trovarne una |

**Uno stato vuoto senza una via d'uscita è un vicolo cieco.** Se l'utente arriva lì e non sa cosa fare, la schermata ha fallito anche se il codice è corretto.

## 2. Il pavimento di accessibilità — non è opinabile

Sotto queste righe non si scende. Sono verificabili, non sono gusti.

- **Contrasto**: testo normale almeno 4.5:1 sul suo sfondo, testo grande almeno 3:1.
- **Bersagli**: nulla di cliccabile sotto i 44×44 punti su schermo tattile.
- **Il colore non porta mai da solo un'informazione**: rosso *e* un'icona, o rosso *e* una parola. Chi non distingue i colori è circa un uomo su dodici.
- **Il fuoco da tastiera si vede sempre.** Rimuovere il contorno del fuoco senza sostituirlo rende la pagina inutilizzabile senza mouse.
- **Ogni campo ha un'etichetta vera**, non solo un testo grigio dentro il campo: quello sparisce appena si scrive, e chi si distrae non sa più cosa stava compilando.
- **Ogni immagine che porta significato ha una descrizione**; quelle decorative sono dichiarate tali.
- **Si arriva a tutto con il solo tasto di tabulazione**, nell'ordine in cui si legge.

## 3. Il tempo è parte del disegno

- Sotto **0,1 s** la risposta sembra istantanea: ogni azione deve avere un riscontro visivo entro questa soglia (il bottone si preme, la riga si evidenzia).
- Oltre **1 s** serve uno stato di attesa esplicito, altrimenti l'utente ripete l'azione.
- **Un'azione che parte due volte è colpa dell'interfaccia**, non dell'utente: il bottone si disabilita mentre lavora.
- **Un'attesa lunga dice a che punto è.** Una barra ferma e piena comunica *«sono bloccata»* anche quando non lo è.

## 4. Lo schermo stretto non è la versione ridotta

- La parte **alta e centrale** dello schermo è la più difficile da raggiungere col pollice: le azioni frequenti stanno in basso.
- **Niente scorre in orizzontale** tranne ciò che è dichiaratamente scorrevole (una tabella, una galleria) e che lo mostra.
- **Cosa si vede senza scorrere** è una decisione di progetto, non un caso: dichiarala.
- Una tabella larga su schermo stretto **non si rimpicciolisce: si ripensa** (schede, colonne prioritarie, dettaglio a scomparsa).

## 5. I moduli — dove si perde la gente

- **L'errore sta accanto al campo che lo ha causato**, non in cima alla pagina.
- **Dice come si ripara**: non «Data non valida» ma «Usa il formato gg/mm/aaaa».
- **Si valida quando l'utente esce dal campo**, non a ogni tasto (che accusa mentre si scrive) e non solo all'invio (che accusa quando è tardi).
- **Ciò che l'utente ha scritto non si perde mai.** Un errore che svuota il modulo è il modo più veloce per far abbandonare.
- **Si chiede solo ciò che serve adesso.** Ogni campo in più è gente che se ne va.

## 6. Problema o preferenza — il test prima di alzare un 🔴

Un rilievo rosso costa lavoro a qualcun altro. Prima di alzarlo, rispondi:

> **Cosa non riesce a fare l'utente, o cosa fa di sbagliato, a causa di questo?**

Se la risposta è una conseguenza concreta per chi usa → è un problema (🔴/🟡).
Se la risposta è *«sarebbe più pulito»*, *«io l'avrei fatto diverso»* → è una preferenza (🟢), e va detta come tale.

**«Più pulito» non è una motivazione. «L'utente non deve più tenere a mente il passo precedente» sì.**

## 7. Dichiara sempre come hai guardato

Un audit visto a video e uno dedotto dal codice sono due cose diverse, e chi legge deve saperlo.

- **Osservato a video** — hai aperto la schermata e l'hai usata.
- **Letto da codice** — hai ricostruito il comportamento leggendo. Vale meno, e va scritto.
- **Non osservato** — dichiaralo invece di dedurlo.

## Checklist prima di consegnare la nota di design

- [ ] Tutti e cinque gli stati hanno una risposta (anche solo «resta com'è»)
- [ ] Lo stato vuoto offre una via d'uscita, non un vicolo cieco
- [ ] Contrasto, bersagli, fuoco da tastiera ed etichette verificati
- [ ] Nessuna informazione affidata al solo colore
- [ ] Dichiarato cosa si vede senza scorrere, e il comportamento su schermo stretto
- [ ] Ogni rilievo 🔴 supera il test «cosa non riesce a fare l'utente»
- [ ] Dichiarato **come** hai osservato: a video, da codice, o non osservato
