# ===== STYLE =====
function Write-Title($msg) {
    Write-Host "`n==== $msg ====" -ForegroundColor Magenta
}
function Write-Ok($msg) {
    Write-Host "✔ $msg" -ForegroundColor Green
}

# ===== VARIABILI =====
$baseDir     = "$env:LOCALAPPDATA\Programs"
$ideaDir     = "$baseDir\IntelliJ"
$javaDir     = "$baseDir\Java"
$configDir   = "$env:APPDATA\JetBrains\IntelliJIdea2024.3"
$templateDir = "$configDir\projectTemplates"
$ideaZip     = "ideaIU-2024.3.3.win.zip"
$jdkZip      = "openjdk-23.0.2_windows-x64_bin.zip"
$javafxZip   = "openjfx-21.0.6_windows-x64_bin-sdk.zip"
$javafxDoc   = "openjfx-21.0.6-javadoc.zip"
$helloFxZip  = "HelloFX.tar.gz"

# ===== DOWNLOAD =====
Write-Title "Scarico i pacchetti"
$downloads = @{
    $ideaZip = "https://download.jetbrains.com/idea/ideaIU-2024.3.3.win.zip";
    $jdkZip  = "https://download.java.net/java/GA/jdk23.0.2/6da2a6609d6e406f85c491fcb119101b/7/GPL/openjdk-23.0.2_windows-x64_bin.zip";
    $javafxZip = "https://download2.gluonhq.com/openjfx/21.0.6/openjfx-21.0.6_windows-x64_bin-sdk.zip";
    $javafxDoc = "https://download2.gluonhq.com/openjfx/21.0.6/openjfx-21.0.6-javadoc.zip"
}
New-Item -ItemType Directory -Force -Path downloads | Out-Null
foreach ($file in $downloads.Keys) {
    $url = $downloads[$file]
    $out = "downloads\$file"
    if (-Not (Test-Path $out)) {
        Write-Host "↓ $file"
        Invoke-WebRequest -Uri $url -OutFile $out
    } else {
        Write-Host "$file già presente, skip"
    }
}

# ===== INSTALL JDK + JAVAFX =====
Write-Title "Installazione JDK e JavaFX"
Expand-Archive -Force "downloads\$jdkZip" -DestinationPath $javaDir
Expand-Archive -Force "downloads\$javafxZip" -DestinationPath "$javaDir"
Expand-Archive -Force "downloads\$javafxDoc" -DestinationPath "$javaDir"
Write-Ok "Java + JavaFX installati in $javaDir"

# ===== INSTALL INTELLIJ =====
Write-Title "Installazione IntelliJ IDEA"
Expand-Archive -Force "downloads\$ideaZip" -DestinationPath $ideaDir
Write-Ok "IntelliJ estratto in $ideaDir"

# ===== HELLOFX =====
Write-Title "Installazione HelloFX"
$ideaProjects = "$env:USERPROFILE\IdeaProjects"
New-Item -ItemType Directory -Force -Path $ideaProjects | Out-Null
tar -xzf "archives\$helloFxZip" -C $ideaProjects
Write-Ok "HelloFX estratto in $ideaProjects"

# ===== CONFIGURAZIONE INTELLIJ =====
Write-Title "Configurazione IntelliJ"
New-Item -ItemType Directory -Force -Path "$configDir\options" | Out-Null
# genera path.macros.xml con path corretto
$xmlMacros = @"
<application>
  <component name="PathMacrosImpl">
    <macro name="JAVAFX_PATH" value="$javaDir\javafx-sdk-21.0.6\lib" />
    <macro name="MAVEN_REPOSITORY" value="$env:USERPROFILE\.m2\repository" />
  </component>
</application>
"@
$xmlMacros | Out-File "$configDir\options\path.macros.xml" -Encoding UTF8

Write-Title "Configurazione IntelliJ - applicationLibraries"
$javafxLib = "$javaDir\javafx-sdk-21.0.6\lib"
$javafxDoc = "$javaDir\javafx-21.0.6-javadoc"
$xmlLibraries = @"
<application>
  <component name="libraryTable">
    <library name="javafx-sdk-21">
      <CLASSES>
        <root url="file://$javafxLib" />
      </CLASSES>
      <JAVADOC>
        <root url="file://$javafxDoc/javafx.base" />
        <root url="file://$javafxDoc/javafx.controls" />
        <root url="file://$javafxDoc/javafx.fxml" />
        <root url="file://$javafxDoc/javafx.graphics" />
        <root url="file://$javafxDoc/javafx.media" />
        <root url="file://$javafxDoc/javafx.swing" />
        <root url="file://$javafxDoc/javafx.web" />
      </JAVADOC>
      <NATIVE>
        <root url="file://$javafxLib" />
      </NATIVE>
      <SOURCES />
      <jarDirectory url="file://$javafxLib" recursive="false" />
    </library>
  </component>
</application>
"@
$xmlLibraries | Out-File "$configDir\options\applicationLibraries.xml" -Encoding UTF8
Write-Ok "applicationLibraries.xml generato con path per l'utente"

New-Item -ItemType Directory -Force -Path $templateDir | Out-Null
Copy-Item "config\templates\Programmazione-2.zip" $templateDir -Force
Write-Ok "Config e template copiati in $configDir"

# ===== PULIZIA TEMPORANEI =====
Write-Ok "Pulizia file temporanei"
Remove-Item -Recurse -Force downloads

# ===== CREAZIONE LINK INTELIJ A START MENU =====
Write-Ok "Creazione collegamento a Start Menu"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\IntelliJ IDEA.lnk")
$shortcut.TargetPath = "$ideaDir\bin\idea64.exe"
$shortcut.Save()

# ===== FINE =====
Write-Title "Installazione completata!"
Write-Host "Puoi ora avviare IntelliJ IDEA da $ideaDir\bin\idea64.exe"
Write-Host "IMPORTANTE: Seguire le istruzioni sul README per la corretta configurazione dopo l'installazione!"
Write-Host "Imposta il JDK in File > Project Structure > Platform Settings > SDKs > + > Add JDK from disk... e seleziona $javaDir\jdk-23.0.2"
Write-Host "HelloFX disponibile in $ideaProjects\HelloFX"
Write-Title "Buon lavoro!"