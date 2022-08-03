# 
# fzf: 模糊搜索
#       interactive: read from STDIN, selected to STDOUT
#           keymap:
#               <Ctrl-J> <Ctrl-K>: move cursor
#               <Enter>: select
#       arguments:
#           --bind='ctrl-r:reload(commmand)'
#               fzf --bind "change:reload:$RG_PREFIX {q} || true" \
#           search:
#               --tac: reverse the input order
#               --cycle
#           layout:
#               --height=40%
#               --layout=[default|reverse|reverse-list]
#               --border=[rounded|sharp|horizontal|vertical|top|bottom|left|right|none]
#               --prompt='> '
#               --pointer='>'
#               --header='Fzf Finder'
#               --header-line=N
#               --info=[default|inline|hidden]
#               --margin --padding
#           display:
#               --color=[dark|light|16|bw]
#           preview:
#               --preview=Command to preview highlighted line ({})
#               --preview-window='right:50%'
#                           [up|down|left|right]
#                           [,SIZE[%]]
#                           [,[no]wrap]
#                           [,[no]cycle][,[no]follow][,[no]hidden]
#                           [,border-BORDER_OPT]
#                           [,+SCROLL[OFFSETS][/DENOM]]
#                           [,~HEADER_LINES]
#                           [,default]
#                       environment:
#           FZF_DEFAULT_COMMAND: 无输入流用这个命令获取数据
#           FZF_DEFAULT_OPTS: 默认启动参数
#           FZF_COMPLETION_TRIGGER='**': SHELL补全触发
#           FZF_COMPLETION_OPTS: SHELL补全参数
#       search syntax:
#           'word: exact match
#           ^word: prefix exact match
#           word$: suffix exact match
#           !word: inverse exact match
#           !^word: inverse prefix exact match
#           !word$: inverse suffix eact match
#           other: fuzzy match
