# FROM
#     FROM <image>
#     FROM <image>:<tag>
FROM openjdk:jdk-stretch
# MAINTAINER
#     MAINTAINER <name>
# ARG
#     ARG <name>[=<default value>]
ARG JAR_FILE
# RUN
#     RUN apt-get update && apt-get install -y \
#             package-bar \
#             package-baz 
# CMD
#     一个Dockerfile只能最有一条生效
#     CMD [“executable”, “param1”, “param2”…]
# LABEL
#     LABEL <key>=<value> <key>=<value>
#     一条指令就会生成一个镜像层,最多127
# ENV
#     ENV PATH /usr/local/nginx/bin:$PATH
#     ENV PG_MAJOR 93
# ADD
#     ADD <src> ... <dest>
# COPY
#     COPY <src> ... <dest>
#     COPY requirementstxt /tmp/
COPY ${JAR_FILE} /java/app.jar
# VOLUME
#     VOLUME ["/data"]
# USER
# WORKDIR
#     WORKDIR /path/to/workdir
WORKDIR /java
# EXPOSE
#     EXPOSE 80
EXPOSE 8080
# ENTRYPOINT
#     ENTRYPOINT ["executable", "param1", "param2"]
ENTRYPOINT ["java", "-jar", "/java/app.jar"]
# ONBUILD
# STOPSIGNAL