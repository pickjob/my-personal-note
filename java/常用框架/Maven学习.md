# maven学习
- maven
    - clean
    - package (ejb:ejb / ejb3:ejb3 / jar:jar / par:par / rar:rar / war:war)
    - install
- 常用命令及配置
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
    <!-- jetty:run-war -->
    <plugin>
        <groupId>org.eclipse.jetty</groupId>
        <artifactId>jetty-maven-plugin</artifactId>
        <version>9.4.27.v20200227</version>
        <configuration>
            <!-- <scanIntervalSeconds>10</scanIntervalSeconds> -->
            <war>${project.basedir}/target/mycustom.war</war>
            <webApp>
                <contextPath>/mycustom</contextPath>
            </webApp>
        </configuration>
    </plugin>
    ```