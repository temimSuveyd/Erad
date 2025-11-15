# PowerShell script to automatically add JAR files to the project
# Usage: .\add-jar.ps1 -JarPath "path\to\your\file.jar"

param(
    [Parameter(Mandatory=$true)]
    [string]$JarPath,
    
    [switch]$SyncGradle
)

$libsDir = Join-Path $PSScriptRoot "app\libs"

# Create libs directory if it doesn't exist
if (-not (Test-Path $libsDir)) {
    New-Item -ItemType Directory -Path $libsDir -Force | Out-Null
    Write-Host "Created libs directory: $libsDir" -ForegroundColor Green
}

# Check if source file exists
if (-not (Test-Path $JarPath)) {
    Write-Host "Error: JAR file not found at: $JarPath" -ForegroundColor Red
    exit 1
}

# Get the filename
$fileName = Split-Path $JarPath -Leaf

# Copy the JAR file to libs directory
$destination = Join-Path $libsDir $fileName

try {
    Copy-Item -Path $JarPath -Destination $destination -Force
    Write-Host "Successfully copied $fileName to libs directory" -ForegroundColor Green
    Write-Host "Location: $destination" -ForegroundColor Cyan
    
    # Sync Gradle if requested
    if ($SyncGradle) {
        Write-Host "`nSyncing Gradle..." -ForegroundColor Yellow
        Set-Location $PSScriptRoot
        .\gradlew.bat --refresh-dependencies
    } else {
        Write-Host "`nNote: Run '.\gradlew.bat --refresh-dependencies' to sync Gradle" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error copying file: $_" -ForegroundColor Red
    exit 1
}

