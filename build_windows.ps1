# Build script for Windows that fixes Firebase SDK version issue
# Run this instead of 'flutter build windows' directly

Write-Host "Preparing Windows build..."

# Clean previous build
Write-Host "Cleaning previous build..."
flutter clean

# Get dependencies
Write-Host "Getting dependencies..."
flutter pub get

# Run flutter build which will generate the ephemeral files
Write-Host "Generating build files..."
flutter build windows --no-tree-shake-icons 2>&1 | Tee-Object -Variable buildOutput

# Check if CMakeLists.txt exists and patch it
$cmakeFile = "windows\flutter\ephemeral\.plugin_symlinks\firebase_core\windows\CMakeLists.txt"
if (Test-Path $cmakeFile) {
    Write-Host "Patching Firebase SDK version..."
    $content = Get-Content $cmakeFile -Raw
    if ($content -match 'set\(FIREBASE_SDK_VERSION "12\.7\.0"\)') {
        $content = $content -replace 'set\(FIREBASE_SDK_VERSION "12\.7\.0"\)', 'set(FIREBASE_SDK_VERSION "12.6.0")'
        Set-Content $cmakeFile -Value $content -NoNewline
        Write-Host "Patched Firebase SDK version from 12.7.0 to 12.6.0"
        
        # Now run the actual build
        Write-Host "Building Windows application..."
        flutter build windows
    } else {
        Write-Host "Firebase SDK version already patched or using different version"
        # Check if there are any errors in the build output
        if ($buildOutput -match "404|Download failed") {
            Write-Host "Build failed with download error. Trying alternative SDK version..."
            # Try version 12.5.0
            $content = Get-Content $cmakeFile -Raw
            $content = $content -replace 'set\(FIREBASE_SDK_VERSION "[^"]*"\)', 'set(FIREBASE_SDK_VERSION "12.5.0")'
            Set-Content $cmakeFile -Value $content -NoNewline
            Write-Host "Trying Firebase SDK version 12.5.0..."
            flutter build windows
        }
    }
} else {
    Write-Host "CMakeLists.txt not found. Build may have failed earlier."
    Write-Host "Build output:"
    $buildOutput | Select-Object -Last 30
}

