# STOMP(Simple Text Oriented Messaging Protocol)学习
- STOMP Frames
    ```tcp
    COMMAND
    header1:value1
    header2:value2

    Body^@
    ```
    - Client
        - CONNECT or STOMP
            - REQUIRED: accept-version, host
            - OPTIONAL: login, passcode, heart-beat
        - SEND
            - REQUIRED: destination
            - OPTIONAL: transaction
        - SUBSCRIBE
            - REQUIRED: destination, id
            - OPTIONAL: ack
        - UNSUBSCRIBE
            - REQUIRED: id
            - OPTIONAL: none
        - BEGIN
            - REQUIRED: transaction
            - OPTIONAL: none
        - COMMIT
            - REQUIRED: transaction
            - OPTIONAL: none
        - ABORT
            - REQUIRED: transaction
            - OPTIONAL: none
        - ACK
            - REQUIRED: id
            - OPTIONAL: transaction
        - NACK
            - REQUIRED: id
            - OPTIONAL: transaction
        - DISCONNECT
            - REQUIRED: none
            - OPTIONAL: receipt
    - Server
        - CONNECTED
            - REQUIRED: version
            - OPTIONAL: session, server, heart-beat
        - MESSAGE
            - REQUIRED: destination, message-id, subscription
            - OPTIONAL: ack
        - RECEIPT
            - REQUIRED: receipt-id
            - OPTIONAL: none
        - ERROR
            - REQUIRED: none
            - OPTIONAL: message