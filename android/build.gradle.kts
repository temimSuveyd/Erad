allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    
    repositories {
        // Local Maven repository first (highest priority)
        val localMavenRepo = file("${project.projectDir}/../local-maven-repo")
        if (localMavenRepo.exists()) {
            maven {
                url = localMavenRepo.toURI()
                name = "Local Maven Repository"
                // Give priority to local repository
                content {
                    includeGroup("com.android.tools.external.com-intellij")
                }
            }
        }
        // Local JAR files repository
        flatDir {
            dirs("${project.projectDir}/libs")
        }
        // Then remote repositories
        google()
        mavenCentral()
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
