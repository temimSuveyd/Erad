# JAR Dosyalarını Ekleme Kılavuzu

## Eksik JAR Dosyaları
Projeniz şu JAR dosyalarını arıyor:
- `intellij-core-31.6.0.jar`
- `kotlin-compiler-31.6.0.jar`

## Otomatik Ekleme (Önerilen)

### Yöntem 1: Tek Komutla Her İkisini Birden
```powershell
cd android
.\add-missing-jars.ps1 -IntellijCorePath "C:\path\to\intellij-core-31.6.0.jar" -KotlinCompilerPath "C:\path\to\kotlin-compiler-31.6.0.jar" -SyncGradle
```

### Yöntem 2: Tek Tek Ekleme
```powershell
cd android

# intellij-core ekle
.\add-missing-jars.ps1 -IntellijCorePath "C:\path\to\intellij-core-31.6.0.jar" -SyncGradle

# kotlin-compiler ekle
.\add-missing-jars.ps1 -KotlinCompilerPath "C:\path\to\kotlin-compiler-31.6.0.jar" -SyncGradle
```

## Manuel Ekleme

1. JAR dosyalarını `android/app/libs` klasörüne kopyalayın
2. Gradle'ı yenileyin:
   ```powershell
   cd android
   .\gradlew.bat --refresh-dependencies
   ```

## Dosya Konumları

- **libs klasörü**: `android/app/libs/` - Basit JAR dosyaları için
- **Maven repository**: `android/local-maven-repo/` - Maven koordinatları ile

Script otomatik olarak her iki yere de kopyalar.

