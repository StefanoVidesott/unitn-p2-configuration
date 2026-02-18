#!/bin/bash
set -e

NL="\n"
ESC="\033"

NORM="${ESC}[0m"
BOLD="${ESC}[1m"
RVON="${ESC}[7m"
RVOFF="${ESC}[27m"

COL_LGRN="${ESC}[92m"
COL_LMAG="${ESC}[95m"
COL_LCYN="${ESC}[96m"
COL_RED="${ESC}[91m"
COL_YEL="${ESC}[93m"
COL_CYN="${ESC}[36m"

function _echo {
    echo -e "$1";
}

function _msg {
    _echo "${BOLD}${COL_LCYN}==>${NORM} ${COL_LGRN}$1${NORM}"
}

function _ok {
    _echo "${COL_LGRN}✔ $1${NORM}"
}

function _title {
    _echo "${NL}${RVON}${BOLD}${COL_LMAG} $1 ${NORM}${RVOFF}"
}

INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIU-2025.3.2.tar.gz"
JDK_URL="https://download.java.net/java/GA/jdk25.0.1/2fbf10d8c78e40bd87641c434705079d/8/GPL/openjdk-25.0.1_linux-x64_bin.tar.gz"
JAVAFX_SDK_URL="https://download2.gluonhq.com/openjfx/25.0.2/openjfx-25.0.2_linux-x64_bin-sdk.zip"
JAVAFX_DOC_URL="https://download2.gluonhq.com/openjfx/25.0.2/openjfx-25.0.2-javadoc.zip"

DOWNLOAD_DIR=downloads
mkdir -p "$DOWNLOAD_DIR"

_title "Download delle risorse"
_msg "Scaricamento JDK 25.0.1..."
wget -c "$JDK_URL" -O "$DOWNLOAD_DIR/jdk.tar.gz"
_msg "Scaricamento JavaFX SDK..."
wget -c "$JAVAFX_SDK_URL" -O "$DOWNLOAD_DIR/javafx-sdk.zip"
_msg "Scaricamento JavaFX Javadoc..."
wget -c "$JAVAFX_DOC_URL" -O "$DOWNLOAD_DIR/javafx-doc.zip"
_msg "Scaricamento IntelliJ IDEA Ultimate 2025.3.2..."
wget -c "$INTELLIJ_URL" -O "$DOWNLOAD_DIR/ideaIU.tar.gz"
_ok "Download completati"

_title "Installazione delle risorse"
mkdir -p ~/.local/opt/java
_msg "Estrazione JDK..."
tar -xzf "$DOWNLOAD_DIR/jdk.tar.gz" -C ~/.local/opt/java && _ok "JDK installato in ~/.local/opt/java"
_msg "Estrazione JavaFX SDK..."
unzip -qo "$DOWNLOAD_DIR/javafx-sdk.zip" -d ~/.local/opt/java && _ok "JavaFX SDK installato in ~/.local/opt/java"
_msg "Estrazione JavaFX Javadoc..."
unzip -qo "$DOWNLOAD_DIR/javafx-doc.zip" -d ~/.local/opt/java
_ok "JavaFX SDK e Javadoc installati in ~/.local/opt/java"
_msg "Estrazione IntelliJ IDEA..."
sudo tar -xzf "$DOWNLOAD_DIR/ideaIU.tar.gz" -C /opt/ && _ok "IntelliJ estratto in /opt"
_ok "Installazione delle risorse completata"

_title "Installazione HelloFX"
mkdir -p ~/IdeaProjects
tar -xzf archives/HelloFX.tar.gz -C ~/IdeaProjects/ && _ok "HelloFX installato in ~/IdeaProjects/"

_title "Configurazione IntelliJ"
CONFIG_DIR=~/.config/JetBrains/IntelliJIdea2025.3
mkdir -p "$CONFIG_DIR/options"
sed "s|{{HOME}}|$HOME|g" config/path.macros.template.xml > "$CONFIG_DIR/options/path.macros.xml"
cp config/applicationLibraries.xml "$CONFIG_DIR/options/"
_msg "Configurazione percorsi sicuri (Trusted Projects)..."
cp config/trusted-paths.xml "$CONFIG_DIR/options/trusted-paths.xml"
_ok "Configurazioni copiate in $CONFIG_DIR/options"

_title "Installazione template IntelliJ..."
TEMPLATES_DIR=$CONFIG_DIR/projectTemplates
mkdir -p $TEMPLATES_DIR
cp config/templates/Programmazione-2.zip $TEMPLATES_DIR/
_ok "Template 'Programmazione-2' copiato in IntelliJ"

_msg "Pulizia file temporanei..."
rm -rf "$DOWNLOAD_DIR"

_title "Installazione completata"
_echo "${NL}${COL_CYN}Puoi ora avviare IntelliJ IDEA scrivendo a terminale o eseguendo: ${BOLD}/opt/idea-IU-*/bin/idea.sh${NORM}"
_echo "${COL_RED}IMPORTANTE:${NORM}${COL_YEL} Segui le istruzioni nella sezione ${BOLD}'Dopo l'installazione'${NORM}${COL_YEL} per la corretta configurazione dell'SDK e del progetto.${NORM}"
_echo "${NL}${COL_CYN}Imposta il JDK in File -> Project Structure -> Platform Settings -> SDKs -> + -> Add JDK from disk... e seleziona ${BOLD}~/.local/opt/java/jdk-25.0.1${NORM}"
_echo "HelloFX è disponibile in ~/IdeaProjects/HelloFX."
_title "Buon lavoro!"