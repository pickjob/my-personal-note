# nftables学习
- Tables
    - nft list table [<family>] <name> [-n] [-a]
    - nft (add | delete | flush) table [<family>] <name>
        - family
            - ip
            - arp
            - ip6
            - bridge
            - inet : ip + ip6
                - hook
                    - prerouting
                    - input
                    - forwar
                    - output
                    - postrouting
            - netdev
- Chains
    - nft (add | create) chain [<family>] <table> <name> [ { type <type> hook <hook> [device <device>] priority <priority> \; [policy <policy> \;] } ]
    - nft (delete | list | flush) chain [<family>] <table> <name>
    - nft rename chain [<family>] <table> <name> <newname>
        - type
            - filter
            - route
            - nat
        - hook
        - priority
        - policy
            - accept
            - drop
            - queue
            - continue
            - return
            - jump <chain>
- Rules
    - nft add rule [<family>] <table> <chain> <matches> <statements>
    - nft insert rule [<family>] <table> <chain> [position <position>] <matches> <statements>
    - nft replace rule [<family>] <table> <chain> [handle <handle>] <matches> <statements>
    - nft delete rule [<family>] <table> <chain> [handle <handle>]
        - matches
            - ip / ip6
                - length
                - protocol
                - saddr
                - daddr
            - tcp / udp
                - dport
                - sport
        - meta
            - iifname <input interface name>
            - oifname <output interface name>
            - iif <input interface index>
            - oif <output interface index>
            - iiftpe <input interface type>
            - oiftype <output interface type>
            - protocol
        - statement
- example
    ```bash
    flush ruleset
    table firewall {
        chain incoming {
            type filter hook input priority 0; policy drop;
            # established/related connections
            ct state established,related accept
            # loopback interface
            iifname lo accept
            # icmp
            icmp type echo-request accept
            # open tcp ports: sshd (22), httpd (80)
            tcp dport {ssh, http} accept
        }
    }
    table ip6 firewall {
        chain incoming {
            type filter hook input priority 0; policy drop;
            # established/related connections
            ct state established,related accept
            # invalid connections
            ct state invalid drop
            # loopback interface
            iifname lo accept
            # icmp
            # routers may also want: mld-listener-query, nd-router-solicit
            icmpv6 type {echo-request,nd-neighbor-solicit} accept
            # open tcp ports: sshd (22), httpd (80)
            tcp dport {ssh, http} accept
        }
    }
    ```