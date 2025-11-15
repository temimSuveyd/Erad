# Drag and drop script - JAR dosyasını bu scriptin üzerine sürükleyip bırakın
# Veya: .\drop-jar-here.ps1 "path\to\file.jar"

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Files
)

# Eğer dosya yolu parametre olarak verilmediyse, kullanıcıdan iste
if ($Files.Count -eq 0) {
    Write-Host "JAR dosyasının yolunu girin (veya dosyayı bu scriptin üzerine sürükleyip bırakın):" -ForegroundColor Yellow
    $filePath = Read-Host
    if ($filePath) {
        $Files = @($filePath)
    }
}

$libsDir = Join-Path $PSScriptRoot "app\libs"
$localMavenRepo = Join-Path $PSScriptRoot "local-maven-repo"

# Create directories
if (-not (Test-Path $libsDir)) {
    New-Item -ItemType Directory -Path $libsDir -Force | Out-Null
}
if (-not (Test-Path $localMavenRepo)) {
    New-Item -ItemType Directory -Path $localMavenRepo -Force | Out-Null
}

foreach ($file in $Files) {
    # Remove quotes if present (from drag and drop)
    $file = $file.Trim('"')
    
    if (-not (Test-Path $file)) {
        Write-Host "Dosya bulunamadı: $file" -ForegroundColor Red
        continue
    }
    
    $fileName = Split-Path $file -Leaf
    Write-Host "`nİşleniyor: $fileName" -ForegroundColor Cyan
    
    # Detect which JAR file it is
    $isIntellijCore = $fileName -like "*intellij-core*31.6.0*"
    $isKotlinCompiler = $fileName -like "*kotlin-compiler*31.6.0*"
    
    if ($isIntellijCore) {
        Write-Host "intellij-core-31.6.0.jar tespit edildi!" -ForegroundColor Green
        & "$PSScriptRoot\add-missing-jars.ps1" -IntellijCorePath $file
    }
    elseif ($isKotlinCompiler) {
        Write-Host "kotlin-compiler-31.6.0.jar tespit edildi!" -ForegroundColor Green
        & "$PSScriptRoot\add-missing-jars.ps1" -KotlinCompilerPath $file
    }
    else {
        # Generic JAR file - just copy to libs
        $destination = Join-Path $libsDir $fileName
        Copy-Item -Path $file -Destination $destination -Force
        Write-Host "JAR dosyası libs klasörüne kopyalandı: $destination" -ForegroundColor Green
    }
}

Write-Host "`n✓ İşlem tamamlandı!" -ForegroundColor Green
Write-Host "Gradle'ı yenilemek için: cd android && .\gradlew.bat --refresh-dependencies" -ForegroundColor Yellow

