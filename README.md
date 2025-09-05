# Configurazione Ambiente Lab Programmazione 2

![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-orange?logo=ubuntu)
![Shell](https://img.shields.io/badge/Shell-Bash-yellow?logo=gnu-bash)
![Java](https://img.shields.io/badge/Java-23.0.2-blue?logo=java)
![JavaFX](https://img.shields.io/badge/JavaFX-21.0.6-green?logo=javafx)
![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ%20IDEA-2024.3.3-purple?logo=intellijidea)
![Repo Size](https://img.shields.io/github/repo-size/StefanoVidesott/unitn-p2-configuration?color=blue)

---

Questa repository permette di configurare automaticamente il computer con la configurazione dei laboratori di **Programmazione 2** (Unitn) su **Ubuntu Linux**.
L’intero processo si avvia con un unico script (`setup.sh`) che installa e configura:

- **OpenJDK 23.0.2**
- **JavaFX 21.0.6** (SDK + Javadoc)
- **IntelliJ IDEA Ultimate 2024.3.3**
- **Template derivato e Progetto HelloFX**
- **Configurazioni IntelliJ** (variabili di percorso, librerie, template di progetto)

> [!Caution]
> **IMPORTANTE:** <br>
> L'unico passaggio lasciato all'utente è il login con un account JetBrains (necessario per la licenza gratuita studenti) ed alla prima configurazione di un progetto, se il Project SDK non è selezionato di default: *Project SDK* -> *Add JDK from disk...* -> `~/.local/opt/java/jdk-23.0.2`.


---

## 📂 Struttura della repository
```bash
.
├── archives/
│   └── HelloFX.tar.gz # progetto di esempio HelloFX
├── config/
│   ├── path.macros.xml # variabile JAVAFX_PATH
│   ├── applicationLibraries.xml # libreria globale JavaFX
│   └── templates/
│       └── Programmazione-2.zip # template personalizzato
├── setup.sh # script di installazione automatica
├── IstruzioniNativa.pdf # istruzioni ufficiali del corso
└── README.md
```
---

## 🔧 Prerequisiti

- **Ubuntu** (o distribuzione compatibile)
- Accesso a `sudo` (necessario per installare IntelliJ in `/opt`)
- Connessione Internet attiva

---

## 🚀 Installazione

1. Clonare la repository:
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

## ⚙️ Cosa fa lo script
- Scarica ed estrae **Java** e **JavaFX** in `~/.local/opt/java`

- Scarica ed estrae **IntelliJ** in `/opt`

- Estrae il progetto **HelloFX** in `~/IdeaProjects/`

- **Configura IntelliJ** copiando:

    - `path.macros.xml` (imposta `JAVAFX_PATH`)

    - `applicationLibraries.xml` (libreria globale **JavaFX** con **Javadoc**)

    - Installa il template **Programmazione-2** per i nuovi progetti

## 🖥️ Dopo l’installazione
1. Avviare IntelliJ IDEA (`/opt/idea-IU-243.24978.46/bin/idea`)

2. Effettuare login con account JetBrains (necessario per la licenza gratuita studenti)

3. *(opzionale) Creare la desktop entry: Ingranaggio in basso a destra -> **Create Desktop Entry...***

3. Selezionare il template **Programmazione-2**

4. Non sempre l'SDK viene selezionato automaticamente. Se il JDK non è selezionato di default: Project SDK -> Add JDK from disk... ->**: `~/.local/opt/java/jdk-23.0.2`

5. Provare a eseguire il progetto di esempio (HelloFX)

## 🔎 Note
- Le configurazioni sono pensate per Linux: su Windows/Mac i percorsi vanno adattati.

- Lo script è stato testato su Ubuntu 24.04.

## 🔧 Troubleshooting

- Se il template Programmazione-2 non appare, controlla che il file `Programmazione-2.zip` sia stato copiato in `~/.config/JetBrains/IntelliJIdea2024.3/projectTemplates/`, se non funziona aprire il progetto `HelloFX` e creare il template manualmente.

- Per ogni altro problema consultare il file `IstruzioniNativa.pdf` allegato alla repository.

## Disinstallazione
Per rimuovere IntelliJ e Java installati dallo script, eseguire (sostituendo con la versione effettivamente installata se diversa):
```bash
sudo rm -rf /opt/idea-IU-243.24978.46/
rm -rf ~/.config/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.cache/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.local/share/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.local/opt/java/
rm -rf ~/IdeaProjects/ # (opzionale, rimuove i progetti creati)
```