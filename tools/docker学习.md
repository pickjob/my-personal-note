# Docker学习
- docker
    - image pull/push : Manage images
    - tag source destion : Rename image
    - container : Manage containers
    - network : Manage networks
    - volume : Manage volumes
    - system : Manage Docker
- Dockerfile
    - FROM
        - FROM <image>
        - FROM <image>:<tag>
    - MAINTAINER
        - MAINTAINER <name>
    - RUN
        - RUN apt-get update && apt-get install -y \
                package-bar \
                package-baz 
    - CMD
        - 一个Dockerfile只能最有一条生效
        - CMD [“executable”, “param1”, “param2”…]- 
    - LABEL
        - LABEL <key>=<value> <key>=<value>
        - 一条指令就会生成一个镜像层,最多127
    - EXPOSE
        - EXPOSE 80
    - ENV
        - ENV PATH /usr/local/nginx/bin:$PATH
        - ENV PG_MAJOR 9- 3
    - ADD
        - ADD <src> ... <dest>
    - COPY
        - COPY <src> ... <dest>
        - COPY requirements- txt /tmp/
    - ENTRYPOINT
        - ENTRYPOINT ["executable", "param1", "param2"]
    - VOLUME
        - VOLUME ["/data"]
    - USER
    - WORKDIR
        - WORKDIR /path/to/workdir
    - ARG
        - ARG <name>[=<default value>]
    - ONBUILD
    - STOPSIGNAL
```dockerfile
FROM openjdk:jdk-stretch
ARG JAR_FILE
COPY ${JAR_FILE} /java/app.jar
WORKDIR /java
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/java/app.jar"]
```