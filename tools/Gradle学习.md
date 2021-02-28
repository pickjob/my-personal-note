# Gradle学习
## Gradle DSL
- Build script: Project
    - allprojects {}: Configures this project and each of its sub-projects
    - subprojects {}: Configures the sub-projects of this project
    - artifacts {}: Configures the published artifacts for this project
    - buildscript {}: Configures the build script classpath for this project
    - configurations {}: Configures the dependency configurations for this project
    - dependencies {}: Configures the dependencies for this project
    - repositories {}: Configures the repositories for this project
    - sourceSets {}: Configures the source sets of this project
    - publishing {}: Configures the PublishingExtension added by the publishing plugin
- Init script: Gradle
- Settings script: Settings
    ```kotlin
    plugins {
        id("java")
        id("idea")
        id("application")
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
        pathVariables GRADLE_HOME: file('~/cool-software/gradle')
        module {
            name = "some-better-name"
            jdkName = "15"
            downloadJavadoc = true
            downloadSources = true
        }
    }

    // Spring
    import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

    plugins {
        id("org.springframework.boot") version "2.4.2"
        id("io.spring.dependency-management") version "1.0.11.RELEASE"
        kotlin("jvm") version "1.4.21"
        kotlin("plugin.spring") version "1.4.21"
    }

    group = "com.example"
    version = "0.0.1-SNAPSHOT"
    java.sourceCompatibility = JavaVersion.VERSION_15

    repositories {
        mavenCentral()
    }

    dependencies {
        implementation("org.springframework.boot:spring-boot-starter-web")
        implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
        implementation("org.jetbrains.kotlin:kotlin-reflect")
        implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
        testImplementation("org.springframework.boot:spring-boot-starter-test")
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            freeCompilerArgs = listOf("-Xjsr305=strict")
            jvmTarget = "15"
        }
    }

    tasks.withType<Test> {
        useJUnitPlatform()
    }

    // kotlin
    import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

    plugins {
        kotlin("jvm") version "1.4.21"
        application
    }

    group = "picjob"
    version = "1.0-SNAPSHOT"

    repositories {
        mavenCentral()
    }



    tasks.withType<KotlinCompile>() {
        kotlinOptions.jvmTarget = "13"
    }

    application {
    //    mainClass = "MainKt"
        mainClass.set("com.foo.bar.FooBar")
    }

    idea {
        //    val m: Map<String, File> =
    //    pathVariables(["GRADLE_HOME", File("~/cool-software/gradle")])
        module {
            jdkName = "15"
            isDownloadJavadoc = true
        isDownloadSources = true
    }


	buildscript {
        repositories {
            jcenter()
        }
        dependencies {
            classpath("com.jfrog.bintray.gradle:gradle-bintray-plugin:0.4.1")
        }
    }
    }
    ```
