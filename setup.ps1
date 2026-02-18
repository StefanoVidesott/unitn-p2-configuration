function Write-Title($msg) {
    Write-Host "`n==== $msg ====" -ForegroundColor Magenta
}
function Write-Ok($msg) {
    Write-Host "OK - $msg" -ForegroundColor Green
}

$baseDir     = "$env:LOCALAPPDATA\Programs"
$ideaDir     = "$baseDir\IntelliJ"
$javaDir     = "$baseDir\Java"
$configDir   = "$env:APPDATA\JetBrains\IntelliJIdea2025.3"
$templateDir = "$configDir\projectTemplates"

$ideaZip     = "ideaIU-2025.3.2.win.zip"
$jdkZip      = "openjdk-25.0.1_windows-x64_bin.zip"
$javafxZip   = "openjfx-25.0.2_windows-x64_bin-sdk.zip"
$javafxDoc   = "openjfx-25.0.2-javadoc.zip"
$helloFxZip  = "HelloFX.tar.gz"

Write-Title "Scarico i pacchetti"
$downloads = [ordered]@{
    $ideaZip   = "https://download.jetbrains.com/idea/ideaIU-2025.3.2.win.zip";
    $jdkZip    = "https://download.java.net/java/GA/jdk25.0.1/2fbf10d8c78e40bd87641c434705079d/8/GPL/openjdk-25.0.1_windows-x64_bin.zip";
    $javafxZip = "https://download2.gluonhq.com/openjfx/25.0.2/openjfx-25.0.2_windows-x64_bin-sdk.zip";
    $javafxDoc = "https://download2.gluonhq.com/openjfx/25.0.2/openjfx-25.0.2-javadoc.zip"
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

Write-Title "Installazione JDK e JavaFX"
Expand-Archive -Force "downloads\$jdkZip" -DestinationPath $javaDir
Expand-Archive -Force "downloads\$javafxZip" -DestinationPath "$javaDir"
Expand-Archive -Force "downloads\$javafxDoc" -DestinationPath "$javaDir"
Write-Ok "Java + JavaFX installati in $javaDir"

Write-Title "Installazione IntelliJ IDEA"
Expand-Archive -Force "downloads\$ideaZip" -DestinationPath $ideaDir
Write-Ok "IntelliJ estratto in $ideaDir"

Write-Title "Installazione HelloFX"
$ideaProjects = "$env:USERPROFILE\IdeaProjects"
New-Item -ItemType Directory -Force -Path $ideaProjects | Out-Null
tar -xzf "archives\$helloFxZip" -C $ideaProjects
Write-Ok "HelloFX estratto in $ideaProjects"

Write-Title "Configurazione IntelliJ"
New-Item -ItemType Directory -Force -Path "$configDir\options" | Out-Null

$javaDirXml = $javaDir -replace '\\', '/'
$userProfileXml = $env:USERPROFILE -replace '\\', '/'

$xmlMacros = @"
<application>
  <component name="PathMacrosImpl">
    <macro name="JAVAFX_PATH" value="$javaDir\javafx-sdk-25.0.2\lib" />
    <macro name="MAVEN_REPOSITORY" value="$env:USERPROFILE\.m2\repository" />
  </component>
</application>
"@
$xmlMacros | Out-File "$configDir\options\path.macros.xml" -Encoding UTF8
Write-Ok "path.macros.xml generato"

$javafxLibUrl = "$javaDirXml/javafx-sdk-25.0.2/lib"
$javafxDocUrl = "$javaDirXml/javafx-25.0.2-javadoc"

$xmlLibraries = @"
<application>
  <component name="libraryTable">
    <library name="javafx-sdk-25">
      <CLASSES>
        <root url="file://$javafxLibUrl" />
      </CLASSES>
      <JAVADOC>
        <root url="file://$javafxDocUrl/javafx.base" />
        <root url="file://$javafxDocUrl/javafx.controls" />
        <root url="file://$javafxDocUrl/javafx.fxml" />
        <root url="file://$javafxDocUrl/javafx.graphics" />
        <root url="file://$javafxDocUrl/javafx.media" />
        <root url="file://$javafxDocUrl/javafx.swing" />
        <root url="file://$javafxDocUrl/javafx.web" />
      </JAVADOC>
      <NATIVE>
        <root url="file://$javafxLibUrl" />
      </NATIVE>
      <SOURCES />
      <jarDirectory url="file://$javafxLibUrl" recursive="false" />
    </library>
  </component>
</application>
"@
$xmlLibraries | Out-File "$configDir\options\applicationLibraries.xml" -Encoding UTF8
Write-Ok "applicationLibraries.xml generato"

Write-Host "Configurazione percorsi sicuri (Trusted Projects)..." -ForegroundColor Cyan
$userProjectsXml = "$env:USERPROFILE\IdeaProjects" -replace '\\', '/'

$xmlTrusted = @"
<application>
  <component name="Trusted.Paths">
    <option name="TRUSTED_PROJECT_PATHS">
      <map>
        <entry key="$userProjectsXml" value="true" />
      </map>
    </option>
  </component>
</application>
"@
$xmlTrusted | Out-File "$configDir\options\trusted-paths.xml" -Encoding UTF8
Write-Ok "trusted-paths.xml generato"

New-Item -ItemType Directory -Force -Path $templateDir | Out-Null
Copy-Item "config\templates\Programmazione-2.zip" $templateDir -Force
Write-Ok "Template 'Programmazione-2' copiato in IntelliJ"

Write-Ok "Pulizia file temporanei"
Remove-Item -Recurse -Force downloads

Write-Ok "Creazione collegamento a Start Menu"
$shell = New-Object -ComObject WScript.Shell
$shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\IntelliJ IDEA 2025.3.lnk"
$shortcut = $shell.CreateShortcut($shortcutPath)

$ideaExe = Get-ChildItem -Path $ideaDir -Filter "idea64.exe" -Recurse | Select-Object -First 1
if ($ideaExe) {
    $shortcut.TargetPath = $ideaExe.FullName
    $shortcut.Save()
    $ideaFinalPath = $ideaExe.FullName
} else {
    $ideaFinalPath = "$ideaDir\bin\idea64.exe"
}

Write-Title "Installazione completata!"
Write-Host "Puoi ora avviare IntelliJ IDEA da: $ideaFinalPath" -ForegroundColor Cyan
Write-Host "IMPORTANTE: Segui le istruzioni sul README per la corretta configurazione dopo l'installazione!" -ForegroundColor Yellow
Write-Host "Imposta il JDK in File > Project Structure > Platform Settings > SDKs > + > Add JDK from disk... e seleziona:"
Write-Host "$javaDir\jdk-25.0.1" -ForegroundColor Cyan
Write-Host "HelloFX è disponibile in $ideaProjects\HelloFX"
Write-Title "Buon lavoro!"
