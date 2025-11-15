# Advanced PowerShell script to add JAR files with Maven coordinates
# Usage examples:
#   .\add-jar-advanced.ps1 -JarPath "kotlin-compiler-31.6.0.jar" -GroupId "com.android.tools.external.com-intellij" -ArtifactId "kotlin-compiler" -Version "31.6.0"
#   .\add-jar-advanced.ps1 -JarPath "intellij-core-31.6.0.jar" -GroupId "com.android.tools.external.com-intellij" -ArtifactId "intellij-core" -Version "31.6.0"

param(
    [Parameter(Mandatory=$true)]
    [string]$JarPath,
    
    [string]$GroupId,
    [string]$ArtifactId,
    [string]$Version,
    
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

# If Maven coordinates are provided, create Maven repository structure
if ($GroupId -and $ArtifactId -and $Version) {
    Write-Host "Installing JAR with Maven coordinates..." -ForegroundColor Yellow
    Write-Host "  GroupId: $GroupId" -ForegroundColor Cyan
    Write-Host "  ArtifactId: $ArtifactId" -ForegroundColor Cyan
    Write-Host "  Version: $Version" -ForegroundColor Cyan
    
    # Create Maven repository structure: groupId/artifactId/version/
    $groupIdPath = $GroupId -replace '\.', '\' -replace '-', '\'
    $mavenRepoPath = Join-Path $PSScriptRoot "local-maven-repo"
    $artifactPath = Join-Path $mavenRepoPath $groupIdPath $ArtifactId $Version
    
    if (-not (Test-Path $artifactPath)) {
        New-Item -ItemType Directory -Path $artifactPath -Force | Out-Null
    }
    
    # Copy JAR file with proper naming
    $mavenJarName = "$ArtifactId-$Version.jar"
    $mavenJarPath = Join-Path $artifactPath $mavenJarName
    Copy-Item -Path $JarPath -Destination $mavenJarPath -Force
    
    Write-Host "Installed to Maven repository: $mavenJarPath" -ForegroundColor Green
    
    # Also copy to libs for direct file access
    $libsDestination = Join-Path $libsDir $fileName
    Copy-Item -Path $JarPath -Destination $libsDestination -Force
    Write-Host "Also copied to libs: $libsDestination" -ForegroundColor Green
} else {
    # Simple copy to libs directory
    $destination = Join-Path $libsDir $fileName
    Copy-Item -Path $JarPath -Destination $destination -Force
    Write-Host "Successfully copied $fileName to libs directory" -ForegroundColor Green
    Write-Host "Location: $destination" -ForegroundColor Cyan
    Write-Host "`nNote: For Maven coordinate support, use:" -ForegroundColor Yellow
    Write-Host "  .\add-jar-advanced.ps1 -JarPath `"$fileName`" -GroupId `"group.id`" -ArtifactId `"artifact-id`" -Version `"version`"" -ForegroundColor Gray
}

# Sync Gradle if requested
if ($SyncGradle) {
    Write-Host "`nSyncing Gradle..." -ForegroundColor Yellow
    Set-Location $PSScriptRoot
    .\gradlew.bat --refresh-dependencies
} else {
    Write-Host "`nNote: Run '.\gradlew.bat --refresh-dependencies' to sync Gradle" -ForegroundColor Yellow
}

