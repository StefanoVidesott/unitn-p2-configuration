#!/bin/bash
set -e

# ====== STYLE ======
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

# ====== URL DOWNLOAD ======
INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIU-2024.3.3.tar.gz"
JDK_URL="https://download.java.net/java/GA/jdk23.0.2/6da2a6609d6e406f85c491fcb119101b/7/GPL/openjdk-23.0.2_linux-x64_bin.tar.gz"
JAVAFX_SDK_URL="https://download2.gluonhq.com/openjfx/21.0.6/openjfx-21.0.6_linux-x64_bin-sdk.zip"
JAVAFX_DOC_URL="https://download2.gluonhq.com/openjfx/21.0.6/openjfx-21.0.6-javadoc.zip"

DOWNLOAD_DIR=~/Downloads/setup_temp
mkdir -p "$DOWNLOAD_DIR"

# ====== START ======

_title "Download e installazione JDK"
_msg "Scaricamento JDK 23.0.2..."
wget -c "$JDK_URL" -O "$DOWNLOAD_DIR/jdk.tar.gz"
mkdir -p ~/.local/opt/java
_msg "Estrazione JDK..."
tar -xzf "$DOWNLOAD_DIR/jdk.tar.gz" -C ~/.local/opt/java && _ok "JDK installato in ~/.local/opt/java"

_title "Download e installazione JavaFX SDK"
_msg "Scaricamento JavaFX SDK..."
wget -c "$JAVAFX_SDK_URL" -O "$DOWNLOAD_DIR/javafx-sdk.zip"
_msg "Scaricamento JavaFX Javadoc..."
wget -c "$JAVAFX_DOC_URL" -O "$DOWNLOAD_DIR/javafx-doc.zip"

_msg "Estrazione JavaFX SDK..."
unzip -qo "$DOWNLOAD_DIR/javafx-sdk.zip" -d ~/.local/opt/java && _ok "JavaFX SDK installato in ~/.local/opt/java"
_msg "Estrazione JavaFX Javadoc..."
unzip -qo "$DOWNLOAD_DIR/javafx-doc.zip" -d ~/.local/opt/java
_ok "JavaFX SDK e Javadoc installati in ~/.local/opt/java"

_title "Download e installazione IntelliJ IDEA"
_msg "Scaricamento IntelliJ IDEA Ultimate 2024.3.3..."
wget -c "$INTELLIJ_URL" -O "$DOWNLOAD_DIR/ideaIU.tar.gz"
_msg "Estrazione IntelliJ IDEA..."
sudo tar -xzf "$DOWNLOAD_DIR/ideaIU.tar.gz" -C /opt/ && _ok "IntelliJ estratto in /opt"

_title "Installazione HelloFX"
mkdir -p ~/IdeaProjects
tar -xzf archives/HelloFX.tar.gz -C ~/IdeaProjects/ && _ok "HelloFX installato in ~/IdeaProjects/"

_title "Configurazione IntelliJ"
CONFIG_DIR=~/.config/JetBrains/IntelliJIdea2024.3
mkdir -p "$CONFIG_DIR/options"
sed "s|{{HOME}}|$HOME|g" config/path.macros.template.xml > "$CONFIG_DIR/options/path.macros.xml" # sostituzione {{HOME}} con $HOME
cp config/applicationLibraries.xml "$CONFIG_DIR/options/"
_ok "Configurazioni copiate in $CONFIG_DIR/options"

_title "Installazione template IntelliJ..."
TEMPLATES_DIR=$CONFIG_DIR/projectTemplates
mkdir -p $TEMPLATES_DIR
cp config/templates/Programmazione-2.zip $TEMPLATES_DIR/
_ok "Template 'Programmazione-2' copiato in IntelliJ"

# Pulizia temporanei
_msg "Pulizia file temporanei..."
rm -rf "$DOWNLOAD_DIR"

_title "Installazione completata"
_echo "${NL}${COL_CYN}Puoi ora avviare IntelliJ IDEA e creare un nuovo progetto utilizzando il template 'Programmazione-2'."
_echo "${COL_RED}IMPORTANTE:${NORM}${COL_YEL} Quando configuri il primo progetto assicurati di selezionare il 'Project SDK' se non selezionato di default: 'NO SDK' -> 'Add JDK from disk -> '~/.local/opt/java/jdk-23.0.2'"
_echo "${COL_CYN}Il progetto HelloFX è disponibile in ~/IdeaProjects/HelloFX."
_echo "${NL}Per avviare IntelliJ IDEA, esegui: '/opt/idea-IU-243.24978.46/bin/idea.sh'"
_echo "(poi potrai creare una desktop entry dall'IDE: Ingranaggio in basso a destra -> 'Create Desktop Entry...'). ${NORM}"
_title "Buon lavoro!"
