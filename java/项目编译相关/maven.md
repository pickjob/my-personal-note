# maven学习
- lifecycles & phase
    - clean
        - pre-clean
        - clean (clean:clean)
        - post-clean
    - default
        - validate
        - initialize
        - generate-sources
        - process-sources
        - generate-resources
        - process-resources (resources:resources)
        - compile (compiler:compile)
        - process-classes
        - generate-test-sources
        - process-test-sources
        - generate-test-resources
        - process-test-resources
        - test-compile
        - process-test-classes
        - test
        - prepare-package
        - package (ejb:ejb / ejb3:ejb3 / jar:jar / par:par / rar:rar / war:war)
        - pre-integration-test
        - integration-test
        - post-integration-test
        - verify
        - install (install:install)
        - deploy (deploy:deploy)
    - sit
        - pre-site
        - site (site:site)
        - post-site
        - site-deploy (site:deploy)
- 长影命令及配置
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