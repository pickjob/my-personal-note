# nc命令学习
- -C: Send CRLF as line-ending
- -k: Forces nc to stay listening for another connection after its current connection is completed
- -l: Used to specify that nc should listen for an incoming connection rather than initiate a connection to a remote host
- -u: Use UDP instead of the default option of TCP
- -z: Specifies that nc should just scan for listening daemons, without sending any data to them
- example
    ```bash
    <!-- CLIENT/SERVER -->
    # server
    rm -f /tmp/f; mkfifo /tmp/f
    cat /tmp/f | /bin/sh -i 2>&1 | nc -l 127.0.0.1 1234 > /tmp/f
    # client
    nc host.example.com 1234
    (shell prompt from host.example.com)
    <!-- PORT SCANNING -->
    nc -zv host.example.com 20-30
    ```