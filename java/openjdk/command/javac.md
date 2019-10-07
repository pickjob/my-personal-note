# javac命令学习
```bash
# 基本格式
javac [options] [sourcefiles-or-classnames]

options:
    # standard
        --add-modules module,module
        -d directory
        -encoding encoding
        --module(-m) module-name(,module-name)*
        --module-path(-p) path
        --module-version version
    # extra
        --add-exports module/package=other-module(,other-module)*
        --add-reads module=other-module(,other-module)*
        --patch-module module=path
```