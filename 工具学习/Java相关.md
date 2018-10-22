# Java编译
- Gradle
    - gradle init --type java-library / java-application
        ```groovy
        plugins {
            id 'java'
            id 'application'
            id 'idea'
            id "com.palantir.docker" version "0.20.1"
        }
        mainClassName = 'main.App'
        project.archivesBaseName = rootProject.name
        project.version = 'v1'
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8

        // docker
        ext.dockerUser = 'pickjob'
        ext.dockerName = project.archivesBaseName
        ext.dockerVersion = 'v1'
        // other dependent version
        ext.log4jVersion = '2.11.1'
        ext.junitVersion = '4.12'

        dependencies {
            compile "org.apache.logging.log4j:log4j-api:${log4jVersion}"
            compile "org.apache.logging.log4j:log4j-core:${log4jVersion}"

            testCompile "junit:junit:${junitVersion}"
        }

        repositories {
            jcenter()
            mavenCentral()
        }


        jar {
            manifest {
                attributes 'Main-Class': "${mainClassName}"
                attributes 'Class-Path': configurations.compile.files.collect { it.name }.join(' ')
            }
            from {
                configurations.compile.collect { it.isDirectory() ? it : zipTree(it) }
            }
        }

        idea{
            module{
                downloadJavadoc = true
                downloadSources = true
            }
        }

        docker{
            dependsOn build
            name "${dockerUser}/${dockerName}:${dockerVersion}"
            dockerfile file("src/main/resources/Dockerfile")
            files jar.archivePath
            buildArgs([JAR_FILE: jar.archiveName])
            pull true
            noCache true
        }
        ```
    - gradle build
- maven
    ```bash
    # build
    mvn package
    # clean
    mvn clean
    # in one
    mvn clean package install deploy
    ```
    - setting.xml(设置mirror)
    ```xml
    <mirrors>
        <mirror>
            <id>ali-central</id>
            <name>aliyun central</name>
            <url>https://maven.aliyun.com/repository/central</url>
            <mirrorOf>central</mirrorOf>        
        </mirror>
        <mirror>
            <id>ali-jcenter</id>
            <name>aliyun jcenter</name>
            <url>https://maven.aliyun.com/repository/jcenter</url>
            <mirrorOf>central</mirrorOf>        
        </mirror>
    </mirrors>
    ```
    - pom.xml(指定repository)
    ```xml
    <repositories>  
        <repository>  
            <id>ali-central</id>  
            <name>aliyun central</name>  
            <url>https://maven.aliyun.com/repository/central</url>  
            <releases>  
                <enabled>true</enabled>  
            </releases>  
            <snapshots>  
                <enabled>false</enabled>  
            </snapshots>  
        </repository>  
    </repositories>  
    ```