# maven学习
- 基本命令
    - mvn
        - clean
        - compile package -DskipTests
        - install
        - dependency:tree
- 常用配置
    ```xml
    <!-- jetty:run run-war -->
    <plugin>
        <groupId>org.eclipse.jetty</groupId>
        <artifactId>jetty-maven-plugin</artifactId>
        <version>9.4.27.v20200227</version>
        <configuration>
            <httpConnector>
                <port>8090</port>
                <host>localhost</host>
            </httpConnector>
            <webApp>
                <contextPath>/</contextPath>
            </webApp>
            <scanIntervalSeconds>10</scanIntervalSeconds>
            <!-- <war>${project.basedir}/target/some.war</war> -->
        </configuration>
    </plugin>
    ```