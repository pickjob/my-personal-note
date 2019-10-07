# jar命令学习
```bash
# 基本格式
jar [OPTION ...] [ [--release VERSION] [-C dir] files] ...
options:
    # mode
        --create(-c)
        --generate-index=FILE(-i=FILE)
        --list(-t) 
        --update(-u) 
        --extract(-x) 
        --describe-module(-d)
    # any mdoe
        -C DIR
    # create / update
        --main-class=CLASSNAME(-e)
        --module-path(-p)
        --module-version=VERSION
```