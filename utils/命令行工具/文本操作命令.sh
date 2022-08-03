#   sed: 处理文件流
#       sed OPTIONS... [SCRIPT] [INPUTFILE...]
#           OPTIONS:
#               --version
#               --in-place[=SUFFIX]
#               --regexp-extended
#               --expression=script
#               --file=script-file
#           SCRIPT:
#               [addr]X[options]
#               addr:
#                   number: a line number will match only that line in the input
#                   $: last line
#                   first~step
#                   addr1,+N: Matches addr1 and the N lines following addr1
#               X(command):
#                   a text: Append text after a line
#                   i text: insert text before a line
#                   c text: Replace (change) lines with text
#                   s/regexp/replacement/[flags]: (substitute) Match the regular-expression against the content of the pattern space
#                       flags:
#                           g: Apply the replacement to all matches to the regexp, not just the first
#                           number: Only replace the numberth match of the regexp
#                           i / I: case-insensitive
#   替换文本
    sed 's/hello/world/' input.txt > output.txt
    sed -i 's/hello/world/' file.txt
#   展示文件内容:
#       cat:
#       bat:
#           --color=always
#           --style=full
#           --line-range
#               --line-range :40
#       more / less
#       head / tail
#           --lines=<N> / --bytes=<N>
#       xxd files: 十六进制展示内容
#       wc [--bytes / --chars / --lines] file: 统计文件内容信息
#   查找:
#       grep:
#           --ignore-case
#           --after-context=<N> / --before-context=<N> / --context=<N>
#           --binary-files=text/binary
#           --text
