- Java
    - jar
    - clean
    ```build.gradle.kts
    plugins {
        java
    }
    // 配置源代码路径
    sourceSets {
        main {
            java {
                setSrcDirs(listOf("src/java"))
            }
            resources {
                setSrcDirs(listOf("src/resources"))
            }
        }
    }
    // 配置其他
    java {
        toolchain {
            languageVersion.set(JavaLanguageVersion.of(11))
        }
    }
    // 依赖配置
    dependencies {
        // api依赖会传递
        api("org.apache.httpcomponents:httpclient:4.5.7")
        // api依赖不传递
        implementation("org.apache.commons:commons-lang3:3.5")
    }
    ```
- Java Library
    ```build.gradle.kts
    plugins {
        java-library
    }
    tasks.jar {
        manifest {
            attributes(mapOf("Implementation-Title" to project.name,
                            "Implementation-Version" to project.version))
        }
    }
    ```
- JVM Application
    - run
    - disZip
    - disTar
    ```build.gradle.kts
    plugins {
        application
    }
    // 配置入口类
    application {
        // 配置Java Module System
        // mainModule.set("org.gradle.sample.app")
        mainClass.set("org.gradle.sample.Main")
        applicationDefaultJvmArgs = listOf("-Dgreeting.language=en")
    }
    ```
- Kotlin
    ```
    plugins {
        id("org.jetbrains.kotlin.jvm") 
    }
    ```
