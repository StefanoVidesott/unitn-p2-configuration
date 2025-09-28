# Configurazione Ambiente Lab Programmazione 2

![Linux](https://img.shields.io/badge/Linux-blue?logo=linux)
![Windows 11](https://img.shields.io/badge/Windows-11-blue?logo=windows11)
![Java](https://img.shields.io/badge/Java-23.0.2-blue?logo=java)
![JavaFX](https://img.shields.io/badge/JavaFX-21.0.6-green?logo=javafx)
![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ%20IDEA-2024.3.3-purple?logo=intellijidea)
![Repo Size](https://img.shields.io/github/repo-size/StefanoVidesott/unitn-p2-configuration?color=blue)


---

Questa repository permette di configurare automaticamente il computer con la configurazione dei laboratori di **Programmazione 2** (Unitn) su **Linux** (è stato testato su *Ubuntu 24.04* e *Arch Linux*) o **Windows**.
L’intero processo si avvia con un unico script (`setup.sh` su Linux, `setup.ps1` su Windows) che installa e configura:

- **OpenJDK 23.0.2**
- **JavaFX 21.0.6** (SDK + Javadoc)
- **IntelliJ IDEA Ultimate 2024.3.3**
- **Template derivato e Progetto HelloFX**
- **Configurazioni IntelliJ** (variabili di percorso, librerie, template di progetto)

> [!Important]
> Per la corretta configurazione dell'**SDK** e del progetto, seguire le istruzioni nella sezione **Dopo l'installazione** dopo aver eseguito lo script.


---

## 📂 Struttura della repository
```bash
.
├── archives/
│   └── HelloFX.tar.gz # progetto di esempio HelloFX
├── config/
│   ├── path.macros.template.xml # template variabile di percorso JAVAFX_PATH
│   ├── applicationLibraries.xml # libreria globale JavaFX
│   └── templates/
│       └── Programmazione-2.zip # template personalizzato
├── setup.sh # script di installazione automatica per Linux
├── setup.ps1 # script di installazione automatica per Windows
├── IstruzioniNativa.pdf # istruzioni ufficiali del corso
└── README.md
```
---

## 🔧 Prerequisiti

### Linux
- **Ubuntu** (o distribuzione compatibile)
- Accesso a `sudo` (necessario per installare IntelliJ in `/opt`)
- Connessione Internet attiva
- Pacchetti richiesti
```bash
wget # download dei file da internet
tar # estrazione archivi .tar.gz
unzip # estrazione archivi .zip
```

### Windows
- PowerShell 5+ o 7+
- Connessione Internet attiva

---

## 🚀 Installazione

### Linux
1. Clonare o scaricare la repository:
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
### Windows
1. Avviare una finestra di PowerShell (tasto destro su Start Menu → Terminal o PowerShell)
2. Clonare (o scaricare) la repository:
   ```powershell
   git clone https://github.com/StefanoVidesott/unitn-p2-configuration.git
   cd unitn-p2-configuration
   ```
3. Abilitare l’esecuzione degli script (solo se non già fatto):
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
4. Lanciare l’installazione:
   ```powershell
   ./setup.ps1
   ```

## 🖥️ Dopo l’installazione
### Linux
1. Avviare IntelliJ IDEA (`/opt/idea-IU-243.24978.46/bin/idea.sh`)
2. Effettuare login con account JetBrains (necessario per la licenza gratuita studenti)
3. *(opzionale) Creare la desktop entry: `Ingranaggio in basso a destra -> Create Desktop Entry...`*
4. Premere su `New Project` e selezionare il template `Programmazione-2` (dovrebbe essere in basso a sinistra, *se non appare -> vedere sezione Troubleshooting*)
5. Se il JDK non è selezionato di default (**o diverso da** `23 Oracle OpenJDK 23.0.2`):
    - Project SDK → Add JDK from disk...
    - Selezionare `~/.local/opt/java/jdk-23.0.2`
6. Selezionare il nome e altri dettagli del progetto e premere `Create`
7. Se si apre una finestra `Customize Your AI Experience`, premere `AI Local` e chiudere la finestra.
8. Provare a eseguire il progetto di esempio e verificare che la configurazione con **JavaFX** funzioni correttamente senza errori

### Windows
1. Avviare IntelliJ IDEA (collegamento su Start Menu o `C:\Users\<utente>\AppData\Local\Programs\IntelliJ\bin\idea64.exe`)
2. Effettuare login con account JetBrains (necessario per la licenza gratuita studenti)
3. Premere su `New Project` e selezionare il template `Programmazione-2` (dovrebbe essere in basso a sinistra, *se non appare -> vedere sezione Troubleshooting*)
4. Se il JDK non è selezionato di default (**o diverso da** `23 Oracle OpenJDK 23.0.2`):
    - Project SDK → Add JDK from disk...
    - Selezionare `C:\Users\<utente>\AppData\Local\Programs\Java\jdk-23.0.2`
5. Selezionare il nome e altri dettagli del progetto e premere `Create`
6. Se si apre una finestra `Customize Your AI Experience`, premere `AI Local` e chiudere la finestra.
7. Provare a eseguire il progetto di esempio e verificare che la configurazione con **JavaFX** funzioni correttamente senza errori

## ⚙️ Cosa fa lo script
### Linux
- Scarica ed estrae **Java** e **JavaFX** in `~/.local/opt/java`
- Scarica ed estrae **IntelliJ** in `/opt`
- Estrae il progetto **HelloFX** in `~/IdeaProjects/`
- **Configura IntelliJ** copiando:
    - `path.macros.xml` (imposta `JAVAFX_PATH`)
    - `applicationLibraries.xml` (libreria globale **JavaFX** con **Javadoc**)
    - Installa il template **Programmazione-2** per i nuovi progetti

### Windows
- Scarica ed estrae:
    - **OpenJDK 23.0.2** in `C:\Users\<utente>\AppData\Local\Programs\Java\jdk-23.0.2`
    - **JavaFX 21.0.6** (SDK + Javadoc) in `C:\Users\<utente>\AppData\Local\Programs\Java\`
    - **IntelliJ IDEA Ultimate 2024.3.3** in `C:\Users\<utente>\AppData\Local\Programs\JetBrains\`
- Copia ed adatta i file di **configurazione di IntelliJ** (applicationLibraries.xml, path.macros.xml non basati su quelli presenti in `./config`) con i percorsi Windows
- Installa il template **Programmazione-2**
- Estrae il progetto **HelloFX** in `C:\Users\<utente>\IdeaProjects\`

## 🔎 Note
- Lo script è stato testato su Ubuntu 24.04.3 LTS e Windows 11
- Lo script non modifica o rimuove eventuali installazioni di Java o IntelliJ già presenti sul sistema, verificare quindi di avviare il programma e versioni di Java corrette se presenti più versioni

## 🔧 Troubleshooting

- Se il template Programmazione-2 non appare, controlla che il file `Programmazione-2.zip` sia stato copiato in `~/.config/JetBrains/IntelliJIdea2024.3/projectTemplates/`, se non funziona aprire il progetto `HelloFX` e creare il template manualmente.
- Se il JDK non è selezionato di default, aggiungerlo manualmente come descritto nella sezione "Dopo l'installazione".
- Se il progetto non compila o dà errori relativi a JavaFX, controllare che la libreria globale `JavaFX` sia presente in `File -> Project Structure... -> Platform Settings -> Global Libraries`. In caso contrario, importarla manualmente da `~/.local/opt/java/javafx-sdk-21.0.6/lib` (Linux) o `C:\Users\<utente>\AppData\Local\Programs\Java\javafx-sdk-21.0.6\lib` (Windows).
- Se lo script non funziona, controllare i permessi di esecuzione (Linux) o la politica di esecuzione degli script (Windows).
- Per ogni altro problema consultare il file `IstruzioniNativa.pdf` allegato alla repository. Eventualmente l'apertura di un issue su GitHub è ben accetta ed aiuta a migliorare lo script : )

## Disinstallazione
Per rimuovere IntelliJ e Java installati dallo script, eseguire (sostituendo con la versione effettivamente installata se modificata):
### Linux
```bash
sudo rm -rf /opt/idea-IU-243.24978.46/
rm -rf ~/.config/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.cache/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.local/share/JetBrains/IntelliJIdea2024.3/
rm -rf ~/.local/opt/java/
rm -rf ~/IdeaProjects/ # (opzionale, rimuove i progetti creati)
```
### Windows
```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Programs\IntelliJ"
Remove-Item -Recurse -Force "$env:APPDATA\JetBrains\IntelliJIdea2024.3\"
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\JetBrains\IntelliJIdea2024.3\"
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Programs\Java"
Remove-Item -Recurse -Force "$env:USERPROFILE\IdeaProjects\" # (opzionale, rimuove i progetti creati)
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\IntelliJ IDEA 2024.3.lnk" # rimuove il collegamento a Start Menu
```
