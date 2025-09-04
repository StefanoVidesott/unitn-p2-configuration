# Configurazione Ambiente Programmazione 2

Questa repository permette di configurare automaticamente il computer per i laboratori di **Programmazione 2** (Unitn) su **Ubuntu Linux**.
L’intero processo si avvia con un unico script (`setup.sh`) che installa e configura:

- **OpenJDK 23.0.2**
- **JavaFX 21.0.6** (SDK + Javadoc)
- **IntelliJ IDEA Ultimate 2024.3.3**
- **Progetto HelloFX**
- **Configurazioni IntelliJ** (variabili di percorso, librerie, template di progetto)

---

## Struttura della repository
```
.
├── archives/
│ ├── java.tar.gz # contiene JDK + JavaFX
│ ├── ideaIU-2024.3.3.tar.gz # IntelliJ Ultimate
│ └── HelloFX.tar.gz # progetto di esempio HelloFX
├── config/
│ ├── path.macros.xml # variabile JAVAFX_PATH
│ ├── applicationLibraries.xml # libreria globale JavaFX
│ └── templates/
│ └── Programmazione-2.zip # template personalizzato
├── setup.sh # script di installazione automatica
├── IstruzioniNativa.pdf # istruzioni ufficiali del corso
└── README.md
```
---

## Prerequisiti

- **Ubuntu** (o distribuzione compatibile)
- Accesso a `sudo` (necessario per installare IntelliJ in `/opt`)
- Connessione Internet attiva (per login a JetBrains al primo avvio)

---

## Installazione

1. Clonare la repository (o copiare la cartella su un PC con Ubuntu o simile):
   ```bash
   git clone https://github.com/StefanoVidesott/unitn-p2-configuration.git
   cd unitn-p2-configuration
   ```

2. Rendere eseguibile lo script:
    ```bash
    chmod +x setup.sh
    ```

3. Lanciare l’installazione:
    ```bash
    ./setup.sh
    ```

## Cosa fa lo script
- Estrae **Java** e **JavaFX** in `~/.local/opt/java`

- Estrae **IntelliJ** in `/opt`

- Copia il progetto **HelloFX** in `~/IdeaProjects/`

- **Configura IntelliJ** copiando:

    - `path.macros.xml` (imposta `JAVAFX_PATH`)

    - `applicationLibraries.xml` (libreria globale **JavaFX** con **Javadoc**)

    - Installa il template Programmazione-2 per i nuovi progetti

## Dopo l’installazione
1. Avviare IntelliJ IDEA

2. Effettuare login con account JetBrains (necessario per la licenza gratuita studenti)

3. Creare un nuovo progetto selezionando il template Programmazione-2

4. Provare a eseguire il progetto di esempio (HelloFX)

## Note
- Le configurazioni sono pensate per Linux: su Windows/Mac i percorsi vanno adattati.

- Lo script **NON installa Java/IntelliJ da Internet**, ma utilizza gli archivi già presenti nella cartella `archives/`.

## Troubleshooting
Se al primo avvio appare `<No SDK>` in IntelliJ, assicurati che la cartella `jdk-23.0.2` sia stata estratta correttamente in `~/.local/opt/java`.

Se il template Programmazione-2 non appare, controlla che il file `Programmazione-2.zip` sia stato copiato in `~/.config/JetBrains/IntelliJIdea2024.3/projectTemplates/`, se non funziona aprire il progetto `HelloFX` e creare il template manualmente.
