# jfr命令学习
```bash
# 基本格式
jfr print [options] file
    --xml
    --json
    --categories <filters>
    --events <filters>
    --stack-depth <depth>
jfr metadata file
jfr assemble repository file
jfr disassmble [options] file
    --output <directory>
    --max-chunks <chunks>
    --max-size <size>
jfr summary file
```