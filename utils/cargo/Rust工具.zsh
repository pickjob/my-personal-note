# 
# system utils
# 
# ferris-fetch: 系统信息展示
cargo install ferris-fetch
# rg: 字符串查找
#   --color=always
#   --line-number
#   --ignore-case
#   --before-context / --after-context / --context
#   --glob <GLOB>
#   --text
#   --files：print each file that would be searched
cargo install ripgrep
# bat [OPTIONS] [FILE]...: 内容查看
#   --show-all: non-printable
#   --plain
#   --language: C++
#   --hilight-line <N:M>
#   --style: full(default), auto
#   --line-range <N:M>
cargo install bat
# fd [FLAGS/OPTIONS] [<pattern>] [<path>...]: 查找文件
#   --hiden
#   --no-ignore
#   --glob(default: regular)
#   --absolute-path(default: relative path)
#   --list-details
#   --full-path(default: filename)
#   --max-path <depth>
#   --type <filetype>: f: file d: directory l: symlink x: executable e: empty s: socket p: pipe
#   --extension <ext>
#   --exec <cmd>
#   --exclude <pattern>
#   --color <when>: never, auto, always
#   --size <size>
cargo install fd-find
# sd [OPTIONS] <find> <replace-with> [files] ... : 替换
#   --flag:
#       c: case-sensitive
#       i: case-insensitive
#       e: disable multi-line matching
#       m: multi-line matching
#       s: make '.' match newlines
#       w: match full words only
#   --preveiw
cargo install sd
# hexyl [OPTIONS] [FILE]: hex viewer
#   --length <N>
#   --skip <N>
cargo install hexyl
# btm: 性能监控
cargo install bottom
