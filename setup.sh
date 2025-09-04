#!/bin/bash
set -e

# ====== STYLE ======
NL="\n"; NL2="${NL}${NL}"
ESC="\033"

NORM="${ESC}[0m"
BOLD="${ESC}[1m"
RVON="${ESC}[7m"
RVOFF="${ESC}[27m"

COL_DFLT="${ESC}[39m"
COL_LGRN="${ESC}[92m"
COL_LMAG="${ESC}[95m"
COL_LCYN="${ESC}[96m"

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
    _echo "${RVON}${BOLD}${COL_LMAG} $1 ${NORM}${RVOFF}"
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
mkdir -p ~/.local/opt
tar -xzf "$DOWNLOAD_DIR/jdk.tar.gz" -C ~/.local/opt/ && _ok "JDK installato in ~/.local/opt"

_title "Download e installazione JavaFX SDK"
_msg "Scaricamento JavaFX SDK..."
wget -c "$JAVAFX_SDK_URL" -O "$DOWNLOAD_DIR/javafx-sdk.zip"
_msg "Scaricamento JavaFX Javadoc..."
wget -c "$JAVAFX_DOC_URL" -O "$DOWNLOAD_DIR/javafx-doc.zip"

_msg "Estrazione JavaFX SDK..."
unzip -qo "$DOWNLOAD_DIR/javafx-sdk.zip" -d ~/.local/opt/
_msg "Estrazione JavaFX Javadoc..."
unzip -qo "$DOWNLOAD_DIR/javafx-doc.zip" -d ~/.local/opt/
_ok "JavaFX SDK e Javadoc installati in ~/.local/opt"

_title "Download e installazione IntelliJ IDEA"
_msg "Scaricamento IntelliJ IDEA Ultimate 2024.3.3..."
wget -c "$INTELLIJ_URL" -O "$DOWNLOAD_DIR/ideaIU.tar.gz"
sudo tar -xzf "$DOWNLOAD_DIR/ideaIU.tar.gz" -C /opt/ && _ok "IntelliJ estratto in /opt"

_title "Installazione HelloFX"
mkdir -p ~/IdeaProjects
tar -xzf archives/HelloFX.tar.gz -C ~/IdeaProjects/ && _ok "HelloFX installato in ~/IdeaProjects/"

_title "Configurazione IntelliJ"
CONFIG_DIR=~/.config/JetBrains/IntelliJIdea2024.3
mkdir -p $CONFIG_DIR/options
cp config/path.macros.xml $CONFIG_DIR/options/
cp config/applicationLibraries.xml $CONFIG_DIR/options/
_ok "Configurazioni copiate in $CONFIG_DIR/options"

_title "Installazione template IntelliJ..."
TEMPLATES_DIR=$CONFIG_DIR/projectTemplates
mkdir -p $TEMPLATES_DIR
cp config/templates/Programmazione-2.zip $TEMPLATES_DIR/
_ok "Template 'Programmazione-2' copiato in IntelliJ"

# Pulizia temporanei
_title "Pulizia file temporanei..."
rm -rf "$DOWNLOAD_DIR"

_title "Installazione completata"
_echo "${NL}Puoi ora avviare IntelliJ IDEA e creare un nuovo progetto utilizzando il template 'Programmazione-2'."
_echo "Il progetto HelloFX è disponibile in ~/IdeaProjects/HelloFX."
_echo "${NL}Buon lavoro!"
_echo "Per avviare IntelliJ IDEA, esegui: '/opt/idea-IU-*/bin/idea.sh'"
_echo "(poi potrai creare una desktop entry dall'IDE: Ingranaggio in basso a destra -> 'Create Desktop Entry...')."
