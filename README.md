# Configurazione Ambiente Lab Programmazione 2

![Linux](https://img.shields.io/badge/Linux-blue?logo=linux)
![Windows 11](https://img.shields.io/badge/Windows-11-blue?logo=windows11)
![Java](https://img.shields.io/badge/Java-25.0.1-blue?logo=java)
![JavaFX](https://img.shields.io/badge/JavaFX-25.0.2-green?logo=javafx)
![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ%20IDEA-2025.3.2-purple?logo=intellijidea)
![Repo Size](https://img.shields.io/github/repo-size/StefanoVidesott/unitn-p2-configuration?color=blue)

---

Questa repository automatizza la preparazione dell'ambiente di sviluppo per i laboratori di **Programmazione 2** (UniTN) su macchine **Linux** (testato su *Ubuntu 24.04* e *Arch Linux*) e **Windows**.

L’intero processo si avvia con un unico script (`setup.sh` su Linux, `setup.ps1` su Windows) che installa e configura:

- **OpenJDK 25.0.1**
- **JavaFX 25.0.2** (SDK + Javadoc)
- **IntelliJ IDEA Ultimate 2025.3.2**
- **Template di progetto** per il corso e progetto di test **HelloFX** (già preconfigurati con le VM options per il *Native Access* di JavaFX).
- **Configurazioni IntelliJ** (variabili d'ambiente, librerie globali e whitelist per i *Trusted Projects*).

> [!IMPORTANT]
> Affinché tutto funzioni correttamente, è **fondamentale** seguire i brevi passaggi nella sezione **"Dopo l'installazione"** al termine dell'esecuzione dello script.

---

## 🔧 Prerequisiti

### 🐧 Linux
- Distribuzione basata su Ubuntu o compatibile (funziona anche su Arch Linux).
- Privilegi di amministratore (`sudo`) per installare l'IDE in `/opt`.
- Pacchetti base installati: `wget`, `tar`, `unzip`.

### 🪟 Windows
- Windows 10/11.
- PowerShell 5+ o 7+.

---

## 🚀 Installazione

### 🐧 Linux
1. Clona o scarica la repository:
```bash
git clone https://github.com/StefanoVidesott/unitn-p2-configuration.git
cd unitn-p2-configuration
```

2. Rendi eseguibile lo script e avvialo:
```bash
chmod +x setup.sh
./setup.sh
```

### 🪟 Windows

1. Avvia una finestra di PowerShell (Tasto destro sul menu Start &rarr; **Terminale** o **PowerShell**).
2. Clona o scarica la repository:
```powershell
git clone https://github.com/StefanoVidesott/unitn-p2-configuration.git
cd unitn-p2-configuration
```

3. Abilita l’esecuzione degli script (solo se è la prima volta che esegui script PS sul tuo PC):
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

4. Avvia l'installazione:
```powershell
./setup.ps1
```

---

## 🖥️ Dopo l’installazione (Molto Importante)

### 🐧 Linux

1. Avvia IntelliJ IDEA da terminale eseguendo: `/opt/idea-IU-*/bin/idea.sh`
* *(Opzionale: Una volta aperto, crea l'icona nel menu cliccando sull'ingranaggio in basso a sinistra &rarr; **Create Desktop Entry...**)*
2. Effettua il login con il tuo account JetBrains (licenza gratuita studenti).
3. Clicca su **New Project** e seleziona il template **Programmazione-2** (nella barra laterale a sinistra. *Se non appare, vedi il Troubleshooting*).
4. Verifica che il JDK sia impostato correttamente:
    * Selezionare **Project SDK &rarr; Add JDK from disk...**
    * Seleziona la cartella: `~/.local/opt/java/jdk-25.0.1`
5. Inserisci il nome del progetto e clicca su **Create**.
6. *(Se appare la finestra "Customize Your AI Experience", seleziona "AI Local" o chiudila).*
7. Apri il progetto di esempio `HelloFX` (che trovi in `~/IdeaProjects/`) e avvialo dal tasto "Play" in alto a destra per confermare che JavaFX funzioni senza errori.

### 🪟 Windows

1. Avvia IntelliJ IDEA dal menu Start o eseguendo `C:\Users\<utente>\AppData\Local\Programs\IntelliJ\bin\idea64.exe`.
2. Effettua il login con il tuo account JetBrains (licenza gratuita studenti).
3. Clicca su **New Project** e seleziona il template **Programmazione-2** (nella barra laterale a sinistra).
4. Verifica che il JDK sia impostato correttamente:
    * Selezionare **Project SDK &rarr; Add JDK from disk...**
    * Seleziona la cartella: `C:\Users\<utente>\AppData\Local\Programs\Java\jdk-25.0.1`
5. Inserisci il nome del progetto e clicca su **Create**.
6. *(Se appare la finestra "Customize Your AI Experience", seleziona "AI Local" o chiudila).*
7. Apri il progetto di esempio `HelloFX` (che trovi in `C:\Users\<utente>\IdeaProjects\`) e avvialo dal tasto "Play" in alto a destra per confermare che JavaFX funzioni senza errori.

---

## ⚙️ Dettagli tecnici: cosa fa lo script?

Indipendentemente dal sistema operativo, lo script si occupa di automatizzare le seguenti noie:

* Scarica ed estrae **OpenJDK 25.0.1** e **JavaFX 25.0.2** (`~/.local/opt/java` su Linux o `AppData\Local\Programs\Java` su Windows).
* Scarica ed installa **IntelliJ IDEA Ultimate**.
* Estrae il progetto di test **HelloFX** nella cartella `IdeaProjects`.
* Inietta le configurazioni in IntelliJ per il corso:
* Genera `path.macros.xml` per la variabile `JAVAFX_PATH`.
* Genera `applicationLibraries.xml` per la libreria globale JavaFX con Javadoc.
* Genera `trusted-paths.xml` per inserire `IdeaProjects` nella whitelist ed evitare i popup "Safe Mode".
* Installa il template del progetto `Programmazione-2.zip`.

*Nota: Lo script non dovrebbe interferire con altre versioni di Java o IntelliJ preesistenti sul sistema.*

---

## 🔧 Troubleshooting

* **Il template "Programmazione-2" non appare in IntelliJ:** Verifica che il file `Programmazione-2.zip` sia stato copiato in `~/.config/JetBrains/IntelliJIdea2025.3/projectTemplates/` (o in `AppData\Roaming\JetBrains\...` su Windows).
* **Errori di compilazione legati a JavaFX (package does not exist):** Controlla che la libreria globale JavaFX sia configurata correttamente andando su **File &rarr; Project Structure... &rarr; Platform Settings &rarr; Global Libraries**. Se manca, aggiungila puntando alla cartella `lib` di JavaFX (es. `~/.local/opt/java/javafx-sdk-25.0.2/lib` su Linux).
* **Avviso "Failed to load module appmenu-gtk-module" (Linux):** È un semplice avviso estetico di Linux e non influisce sul codice. Per rimuoverlo, installa il pacchetto dei menu GTK (es. `sudo apt install appmenu-gtk3-module` su Ubuntu o `sudo pacman -S appmenu-gtk-module` su Arch).
* **Problemi con i permessi:** Assicurati di aver dato i permessi di esecuzione allo script bash (`chmod +x setup.sh`) su Linux, o di aver modificato l'Execution Policy su Windows.
Per ulteriori dettagli, consulta il file `IstruzioniNativa.pdf` allegato o apri una Issue nella repository!

---

## 🗑️ Disinstallazione

Per rimuovere completamente l'ambiente configurato dallo script, copia ed esegui questi comandi:

### 🐧 Linux

```bash
sudo rm -rf /opt/idea-IU-*/
rm -rf ~/.config/JetBrains/IntelliJIdea2025.3/
rm -rf ~/.cache/JetBrains/IntelliJIdea2025.3/
rm -rf ~/.local/share/JetBrains/IntelliJIdea2025.3/
rm -rf ~/.local/opt/java/
# rm -rf ~/IdeaProjects/ # ATTENZIONE: Decommenta solo se vuoi rimuovere TUTTI i tuoi progetti!
```

### 🪟 Windows

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Programs\IntelliJ"
Remove-Item -Recurse -Force "$env:APPDATA\JetBrains\IntelliJIdea2025.3\"
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\JetBrains\IntelliJIdea2025.3\"
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Programs\Java"
Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\IntelliJ IDEA*.lnk"
# Remove-Item -Recurse -Force "$env:USERPROFILE\IdeaProjects\" # ATTENZIONE: Rimuove TUTTI i tuoi progetti!
```
