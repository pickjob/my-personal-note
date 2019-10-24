# V2Ray配置
- 安装
    ```bash
    wget https://install.direct/go.sh
    su -
    bash go.sh
    v2ctl uuid
    ```
- 配置
    ```json
    {
        "inbounds": [
            {
                "port": 1080,
                "listen": "127.0.0.1",
                "protocol": "协议名称",  //  freedom  vmess  http blackhole
                "settings": {
                    <!-- http
                    {
                        "timeout": 0,
                        "accounts": [
                            {
                            "user": "my-username",
                            "pass": "my-password"
                            }
                        ],
                        "allowTransparent": false,
                        "userLevel": 0
                    }
                        vmess
                    {
                        "clients": [
                            {
                            "id": "27848739-7e62-4138-9fd3-098a63964b6b",
                            "level": 0,
                            "alterId": 4,
                            "email": "love@v2ray.com"
                            }
                        ],
                        "default": {
                            "level": 0,
                            "alterId": 4
                        },
                        "detour": {
                            "to": "tag_to_detour"
                        },
                        "disableInsecureEncryption": false
                    }
                    -->
                },
                "streamSettings": {},
                "tag": "标识",
                "sniffing": {
                    "enabled": false,
                    "destOverride": ["http", "tls"]
                },
                "allocate": {
                "strategy": "always",
                "refresh": 5,
                "concurrency": 3
                }
            }
        ],
        "outbounds": [
            {
                "sendThrough": "0.0.0.0",
                "protocol": "协议名称", 
                "settings": {
                    <!-- freefom
                    {
                        "domainStrategy": "AsIs",
                        "redirect": "127.0.0.1:3366",
                        "userLevel": 0
                    }
                        vmess
                    {
                        "vnext": [
                            {
                                "address": "127.0.0.1",
                                "port": 37192,
                                "users": [
                                    {
                                        "id": "27848739-7e62-4138-9fd3-098a63964b6b",
                                        "alterId": 4,
                                        "security": "auto",
                                        "level": 0
                                    }
                                ]
                            }
                        ]
                    }
                        blackhole
                    {
                        "response": {
                            "type": "none"
                        }
                    }
                    -->
                },
                "tag": "标识",
                "streamSettings": {},
                "proxySettings": {
                    "tag": "another-outbound-tag"
                },
                "mux": {
                    "enabled": true
                }
            }
        ],
        "log": {
            "access": "文件地址",
            "error": "文件地址",
            "loglevel": "warning"
        },
        "routing": {
            "domainStrategy": "AsIs",
            "rules": [
                {
                    "type": "field",
                    "domain": [
                        "baidu.com",
                        "qq.com",
                        "geosite:cn"
                    ],
                    "outboundTag": "direct",
                }
            ]
        },
        "dns": {
            "hosts": {
                "geosite:category-ads": "127.0.0.1"
            },
            "servers": [
                    {
                        "address": "1.2.3.4",
                        "port": 5353,
                        "domains": [
                            "domain:v2ray.com"
                        ]
                    },
                    "8.8.8.8",
                    "8.8.4.4",
                    "localhost"
            ],
        }
    }
    ```