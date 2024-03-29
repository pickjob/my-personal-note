# iproute2:
#   ip [ OPTIONS ] OBJECT [ COMMAND [ ARGUMENTS ]]
#       OPTIONS:
#           -family {inet, inet6, link}
#           -statistics
#       OBJECT:
#           link: 物理或者逻辑网络设备
#               set:
#                   dev NAME (default)
#                   up / down
#                   arp / multicast / dynamic   on / off
#                   name NAME
#                   txqueuelen / mtu   NUMBER
#               show / list / ls:
#           address: 协议(IPv4, v6)地址
#               add / delete
#               show / list/ ls
    ip address list
#           neighbour: ARP缓存
#               add / delete
#               show / list / ls
#           route: 路由表
#               add:
#                   PREFIX / TYPE_PREFIX
#                   via address
#                   dev NAME
#               show / list / ls
    ip route add 10.0.0/24 via 193.233.7.65
#           rule: 路由表规则
#           maddress: 组播地址
#           mroute: 组播路由缓存
#           tunnel: IP隧道
#   IMCP:
    ping HOST
#   HTTP:
#       curl: 发送HTTP请求
#           --http1.0 --http1.1 --http2
#           --request GET|POST|PUT|DELETE
#           --header LINE
#           --data DATA
#           --data-urlencode
#           --create-dirs
#           --location
#           --output <file>
    curl --request POST --header 'Content-type: application/json' --data '{"key": "value"}' url
    curl --request POST --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'key=中国啊' url
#       wget file_url: 下载文件
#       aria2c: 文件下载, 支持http(s), ftp, bt
#           --dir=<DIR>
#           --continue=true: 继续下载
#           --header=<HEADER>
#           --load-cookies=<FILE>
#           --save-cookies=<FILE>
# fuser: 用文件或套接字识别进程
#       --list-signals: 显示信号列表
#       --ipv4: IPv4
#       --ipv6: IPv6
#       --all: 显示与指定文件、目录相关的进程
#       --kill: 杀死访问文件的进程
#       --verbose
#       --namespace
#           - file
#           - tcp
#           - udp
    fuser --verbose --namespace tcp 80
# lsof: list open files
#       lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
    lsof -i :80
# tcptrace
#   netcat(nc)
#         -C: send CRLF as line-ending
#         -l: listen mode
#         -o file: hex dump of traffic
#         -u: udp mode
#         -v: verbose
#         -z: scan for listening daemons, without sending any data to them
# tcpdump: 抓包
    tcpdump  src ip or dst ip  -w ip.cap
