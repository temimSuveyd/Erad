buildscript {
    // Kotlin version'ı doğrudan extra extension'a set et
    val kotlinVersion by extra { "1.8.0" }
    
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:7.4.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.0") // Doğrudan version yaz
        classpath("com.google.gms:google-services:4.4.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
    
    configurations.all {
        resolutionStrategy {
            // Tüm projelerde annotations çakışmasını çöz
            force("org.jetbrains:annotations:24.0.0")
        }
    }
}

rootProject.buildDir = "../build"
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}