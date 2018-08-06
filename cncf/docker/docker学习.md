# Docker学习
- http_proxy配置
    - sudo mkdir -p /etc/systemd/system/docker.service.d
    - sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
        ```systemd
        [Service]
        Environment="HTTP_PROXY=http://localhost:1080/" "HTTPS_PROXY=https://localhost:1080/"
        ```
    - sudo systemctl daemon-reload
    - sudo systemctl restart docker
    - docker image pull k8s.gcr.io/pause-amd64:3.1
- docker
    - image : Manage images
    - container : Manage containers
    - network : Manage networks
    - volume : Manage volumes
    - system : Manage Docker
    ##  不常用选项
    - node : Manage Swarm nodes
    - config : Manage Docker configs
    - plugin : Manage plugins
    - secret : Manage Docker secrets
    - service : Manage services
    - stack : Manage Docker stacks
    - swarm : Manage Swarm