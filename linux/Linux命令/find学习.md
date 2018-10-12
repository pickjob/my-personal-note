# find命令学习
- find
    - path
    - expression
        - -fllow 不检索链接符号
        - -maxdepth levles
        - -mindepth levels
        - -type
            - d 目录
            - f 普通文件
            - l 符号链接
        - -name
    - -exec command( {} \; 绝对路径)
- Example
    ```bash
    find . -name '*.txt' -ok ls {} \;
    ```