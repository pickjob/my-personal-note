- 寄存器
    - 段寄存器
        - ?S(16bit)
            - CS
            - DS
            - SS
            - ES
            - FS
            - GS
    - 通用寄存器
        - R?X(64bit) E?X(32bit) ?X(16bit) ?H(high 8bit) ?L(low 8bit)
            - 16bit
                - AX: AH + AL
                - BX: BH + BL
                - CX: CH + CL 循环指令计数器
                - DX: DH + CL
            - 32bit
                - EAX
                - EBX
                - ECX
                - EDX
            - 64bit
                - RAX
                - RDX
                - RCX
                - RDX
        - R?(64bit) R?D(32bit) R?W(16bit) R?B(8bit)
            - R8 ~ R15
    - 指针寄存器
        - R?P(64bit) E?P(32bit) ?P(16bit) ?PL(8bit)
            - RSP
            - RBP
    - 索引寄存器
        - R?I(64bit) E?I(32bit) ?I(16bit) ?IL(8bit)
            - RSI
            - RDI
    - 指令寄存器
        - RIP EIP IP
- 寻址模式
    - 16bit
        - CS DS SS ES
        - BX BP
    - 32bit
        - CS DS SS ES FS GS

- LEA: 取地址, 相当于&

- LEAVE: 恢复现场
    ```assemble
    MOV  ESP, EBP
    POP  EBP
    ```