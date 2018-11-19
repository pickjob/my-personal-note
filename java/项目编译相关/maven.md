# maven
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