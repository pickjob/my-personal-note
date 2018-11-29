# Java编译
- Gradle
    - gradle init --type java-library / java-application
        ```groovy
        plugins {
            id 'java'
            id 'idea'
            id 'application'
            id 'org.gradle.java.experimental-jigsaw' version '0.1.1'
        }

        group 'pickjob'
        version '0.0.1'
        mainClassName = 'app.Application'
        sourceCompatibility = 11
        targetCompatibility = 11
        javaModule.name = 'pickjob.java.starter'

        dependencies {
            implementation 'org.apache.logging.log4j:log4j-api:2.11.1'
            implementation 'org.apache.logging.log4j:log4j-core:2.11.1'
            runtimeOnly 'com.lmax:disruptor:3.4.2'
            testImplementation 'junit:junit:4.12'
        }

        repositories {
            maven {
                url "https://maven.aliyun.com/repository/central"
            }
        }

        idea {
            module {
                downloadJavadoc = true
                downloadSources = true
                inheritOutputDirs = false
                outputDir = file("$buildDir/classes/java/main/")
                testOutputDir = file("$buildDir/classes/java/test/")
            }
        }

        sourceSets {
            main {
                output.resourcesDir = file("$buildDir/classes/java/main")
            }
            test {
                output.resourcesDir = file("$buildDir/classes/java/test/")
            }
        }
        ```