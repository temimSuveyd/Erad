# Script to add missing intellij-core and kotlin-compiler JAR files
# Usage: 
#   .\add-missing-jars.ps1 -IntellijCorePath "path\to\intellij-core-31.6.0.jar" -KotlinCompilerPath "path\to\kotlin-compiler-31.6.0.jar"

param(
    [Parameter(Mandatory=$false)]
    [string]$IntellijCorePath,
    
    [Parameter(Mandatory=$false)]
    [string]$KotlinCompilerPath,
    
    [switch]$SyncGradle
)

$libsDir = Join-Path $PSScriptRoot "app\libs"
$localMavenRepo = Join-Path $PSScriptRoot "local-maven-repo"

# Create directories
if (-not (Test-Path $libsDir)) {
    New-Item -ItemType Directory -Path $libsDir -Force | Out-Null
    Write-Host "Created libs directory: $libsDir" -ForegroundColor Green
}

if (-not (Test-Path $localMavenRepo)) {
    New-Item -ItemType Directory -Path $localMavenRepo -Force | Out-Null
    Write-Host "Created local Maven repository: $localMavenRepo" -ForegroundColor Green
}

# Function to install JAR to Maven repository
function Install-JarToMaven {
    param(
        [string]$JarPath,
        [string]$GroupId,
        [string]$ArtifactId,
        [string]$Version
    )
    
    if (-not (Test-Path $JarPath)) {
        Write-Host "Warning: JAR file not found: $JarPath" -ForegroundColor Yellow
        return $false
    }
    
    # Create Maven directory structure: groupId/artifactId/version
    $groupIdPath = $GroupId -replace '\.', '\' -replace '-', '\'
    $artifactDir = Join-Path $localMavenRepo $groupIdPath $ArtifactId $Version
    
    if (-not (Test-Path $artifactDir)) {
        New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null
    }
    
    # Copy JAR file
    $mavenJarName = "$ArtifactId-$Version.jar"
    $mavenJarPath = Join-Path $artifactDir $mavenJarName
    Copy-Item -Path $JarPath -Destination $mavenJarPath -Force
    
    # Create POM file
    $pomContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd" xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <modelVersion>4.0.0</modelVersion>
  <groupId>$GroupId</groupId>
  <artifactId>$ArtifactId</artifactId>
  <version>$Version</version>
  <description>POM was created from install:install-file</description>
</project>
"@
    $pomPath = Join-Path $artifactDir "$ArtifactId-$Version.pom"
    $pomContent | Out-File -FilePath $pomPath -Encoding UTF8
    
    Write-Host "Installed $ArtifactId-$Version to Maven repository" -ForegroundColor Green
    Write-Host "  Location: $mavenJarPath" -ForegroundColor Cyan
    
    # Also copy to libs
    $libsDestination = Join-Path $libsDir (Split-Path $JarPath -Leaf)
    Copy-Item -Path $JarPath -Destination $libsDestination -Force
    Write-Host "  Also copied to libs: $libsDestination" -ForegroundColor Cyan
    
    return $true
}

$installed = $false

# Install intellij-core-31.6.0.jar
if ($IntellijCorePath) {
    if (Install-JarToMaven -JarPath $IntellijCorePath -GroupId "com.android.tools.external.com-intellij" -ArtifactId "intellij-core" -Version "31.6.0") {
        $installed = $true
    }
} else {
    Write-Host "`nIntellijCorePath not provided. Skipping intellij-core-31.6.0.jar" -ForegroundColor Yellow
    Write-Host "Usage: -IntellijCorePath `"path\to\intellij-core-31.6.0.jar`"" -ForegroundColor Gray
}

# Install kotlin-compiler-31.6.0.jar
if ($KotlinCompilerPath) {
    if (Install-JarToMaven -JarPath $KotlinCompilerPath -GroupId "com.android.tools.external.com-intellij" -ArtifactId "kotlin-compiler" -Version "31.6.0") {
        $installed = $true
    }
} else {
    Write-Host "`nKotlinCompilerPath not provided. Skipping kotlin-compiler-31.6.0.jar" -ForegroundColor Yellow
    Write-Host "Usage: -KotlinCompilerPath `"path\to\kotlin-compiler-31.6.0.jar`"" -ForegroundColor Gray
}

if ($installed) {
    Write-Host "`n✓ JAR files installed successfully!" -ForegroundColor Green
    
    if ($SyncGradle) {
        Write-Host "`nSyncing Gradle..." -ForegroundColor Yellow
        Set-Location $PSScriptRoot
        .\gradlew.bat --refresh-dependencies
    } else {
        Write-Host "`nNext steps:" -ForegroundColor Yellow
        Write-Host "1. Run: cd android" -ForegroundColor Cyan
        Write-Host "2. Run: .\gradlew.bat --refresh-dependencies" -ForegroundColor Cyan
        Write-Host "3. Try building your project again" -ForegroundColor Cyan
    }
} else {
    Write-Host "`nNo JAR files were installed. Please provide file paths." -ForegroundColor Red
    Write-Host "`nExample usage:" -ForegroundColor Yellow
    Write-Host "  .\add-missing-jars.ps1 -IntellijCorePath `"C:\path\to\intellij-core-31.6.0.jar`" -KotlinCompilerPath `"C:\path\to\kotlin-compiler-31.6.0.jar`" -SyncGradle" -ForegroundColor Gray
}

