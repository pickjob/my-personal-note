" vim
"   模式(mode):
"       正常模式(Normal-mode): <Esc> 进入
"       插入模式(Insert-mode):
"           i: 当前位置[前]一个字符开始插入
"           a: 当前位置[后]一个字符开始插入
"           I: 当前位置[行首]开始插入
"           A: 当前位置[行尾]开始插入
"           o: 当前位置[下一行]开始插入
"           O: 当前位置[上一行]开始插入
"           c r s / C R S
"       命令模式(Command-mode):
"           :: 扩展命令, 进入命令模式
"           / ?: 查找, 进入命令模式
"       可视模式(Visual-mode):
"           v: 当前字符开始整行, 进入可视模式
"           V: 整行, 进入可视模式
"           CTRL-V: 列, 进入可视模式
"   操作: 操作符(operator) + 动作(motion)
"       操作符(operator): 对文本进行修改
"           d: 删除(delete)
"           c: 删除后进入插入模式(change)
"           y: 复制(yank)
"           p: 粘贴(paste)
"   动作(motion): 移动光标
"       移动:
"           h j k l(左下上右)
"           0(行首) ^(行首非空字符) $(行尾)
"           H(屏幕第一行) M(屏幕中间一行) L(屏幕最后一行)
"           %(跳转匹配)
"           nG(文件指定行)
"           gg(文件开头) G(文件末尾)
"       (N)文本对象(text-object):
"           w: Word (跳到下一个连续的非字符)
"           W: Word (跳到下一个连续的空白(\s)隔开的字符)
"           e: Word End (w 前一个字符)
"           E: Word End (W 前一个字符)
"           b: Word Back (w 反向)
"           B: Word Back (W 反向)
"           ): Sentence (w 扩展为句子)
"           }: Paragraph (w 扩展为段落)
"           (: Sentence Back (b 扩展为句子)
"           {: Paragraph Back (B 扩展为段落)
"           f{char}: 下一个出现char处
"           F{char}: 上一个出现char处
"   特殊操作:
"       字符:
"           ~: 字符大小写转换
"           r: 替换字符
"           x  X: 删除光标下、前字符
"           J: 删除换行符
"       行:
"           d[N]d: 删除N行
"           y[N]y: 复制N行
"           >>  <<: 向右、向左缩进当前行
"           C: 删除到行尾进入插入模式
"       屏幕滚动:
"           <Ctrl-f>: 向前滚动一页
"           <Ctrl-b>: 向后滚动一页
"           <Ctrl-u>: 向前滚动半页
"           <Ctrl-d>: 向后滚动半页
"           zt: 当前行移动到屏幕顶端
"           zz: 当前行移动到屏幕中间
"           zb: 当前行移动到屏幕底端
"           zH: 右滚半个屏
"           zL: 左滚半个屏
"       折叠(fold):
"           zo  zO: 打开折叠
"           zr  zR: 关闭折叠
"           zc  zC: 创建折叠
"       撤销、重做:
"           u: 撤销
"           <Ctrl-r>: 重做
"       其他:
"           =: 自动格式化
"           ZZ: 保存退出
"           ZQ: 不保存退出
"   查找:
"       /{pattern}[/offset]<CR>: 向下查找
"       ?{pattern}[?]<CR>: 向上查找
"           n  N(正向、反向重复)
"           offset:
"               +[num]: 相对于找到的匹配的[num]行向下,第一列
"               -[num]: 相对于找到的匹配的[num]行向上,第一列
"               e[+num]: 从匹配结束(end)处算起,[num]字符向右
"               e[-num]: 从匹配结束end)处算起,[num]字符向左
"               s[+num]: 从匹配开始start)处算起,[num]字符向右
"               s[-num]: 从匹配开始start)处算起,[num]字符向左
"               b[+num]: 等价于s[+num](b表示begin)
"               b[-num]: 等价于s[-num]
"   替换:
"       :[range]substitute/{pattern}/{string}/[flags](正则替换)
"           range:
"               %: whole file
"           flag:
"               i: 忽略大小写
"               g: 对行内所有的匹配进行替代
"               c: 确认每个替代
"   寄存器:
"       "": 默认无名寄存器
"       "小写字母: 覆盖原有内容
"       "大写字母: 追加原有内容
"       "_: 黑洞寄存器
"       "+: 系统剪贴板
"   buffers:  缓冲区是内存中的文件文本
"       :buffers: 列出所有Buffers
"       :bfirst  :bprevious  :bnext  :blast: Buffer跳转
"       :bdelete  :bunload: Buffer删除、卸载
"   windows: 窗口是缓冲区的视窗
"       :split :vsplit: 水平、垂直分割窗口
"       :new  :vnew: 水平、垂直分割窗口, 进入编辑
"       :only: 只显示当前窗口
"       :quit :close: 退出
"       窗口命令:
"           CTRL-W  hjkl: 跳转窗口 左下上右
"           CTRL-W  o: 只显示当前窗口
"           CTRL-W  s  v: 水平、垂直分割窗体
"           CTRL-W  -  +: 窗口高度减少、增加
"           CTRL-W  <  >: 窗口宽度减少、增加
"           CTRL-W  q  c: 退出
"   tabs: 标签页是窗口的集合
"       :tabs: 列出所有标签
"       :tabnew: 标签新建
"       :tabonly: 关闭其他标签
"       :tabprevious  :tabnext: 标签跳转
"       :tabclose: 标签新建、关闭
"   map:
"       :map
"       :nmap: Normal-Mode映射
"       :imap: Insert-Mode映射
"       :vmap: Visual-Mode映射
"       :cmap: Command-Mode映射
"       [options]  {lhs}  {rhs}
"           optons:
"               <buffer>: 当前缓冲区
"               <nowait>: 不再等待输入
"               <silent>: 不在命令行上回显 
"               <special>:
"               <script>:
"               <expr>: 参数会作为表达式来进行计算
"               <unique>: 已经存在, 则该命令会失败
"           lhs
"               <Plug>  在脚本外部是可见的
"               <SID>   是脚本的ID
"       :unmap  {lhs}
"   扩展命令:
"       文件交互:
"           :edit: 编辑
"           :read: 读取
"           :write: 写入
"           :saveas: 另存为
"       vim信息:
"           :scriptname: 已加载脚本
"           :verbose
"               :verbose map: 列出映射详情
"       其他:
"           :call func: 调用函数
"           :{range}: 跳转
"           :chdir dir: 改变当前目录
"           :redir: 重定向消息到文件
"               :redir! > vim_keys.txt
"               :silent verbose map
"               :redir END
"           :!{command}: 通过一个外壳执行命令
"   command:
"       command[!]    [{attr}...]    {cmd}    {repl}
"           attr:
"               参数(默认无参数):
"                   -nargs=0 : 无参数
"                   -nargs=1 : 一个参数
"                   -nargs=* :任意数目的参数
"                   -nargs=? : 没有或一个参数
"                   -nargs=+: 一个或更多参数
"               范围处理:
"                   -range: 允许使用范围，缺省为当前行
"                   -range=%: 允许使用范围，缺省是整个文件 (1,$)
"                   -range=N: 出现在行号位置的一个数量 (缺省是 N) (类似于  :split )
"                   -count=N: 出现在行号位置或者作为首个参数的一个数量 (缺省是 N) (类似于  :Next )
"                   -count: 同 -count=0
"               补全:
"                   -complete=file: 文件和目录名
"                   -complete=dir: 目录名
"                   -complete=custom,{func}: 用户定制的自动补全，通过 {func} 来定义
"                   -complete=customlist,{func}: 用户定制的自动补全，通过 {func} 来定义
"               其他:
"                   -bang: 这些命令可以使用一个 ! 修饰符 (和 :q 或 :w 类似)
"                   -bar: 这些命令可以跟随一个 "|" 和其它命令, 那么命令参数中就不允许有 "|" , 用一个 " 可以开始一个注释
"                   -register: 给这些命令的第一个参数可以是一个可选的寄存器名(和 :del，:put，:yank 类似)
"                   -buffer: 这些命令仅在当前缓冲区里有效
"           {repl}:
"               转移序列:
"                   <range>: 命令处理范围的项目数: 0、1 或 2
"                   <count>: 提供的数量 (在 '-range' 和 '-count' 属性中描述)
"                   <bang>: (参考 '-bang' 属性) 如果命令执行时带了 ! 修饰符，扩展为 !，否则什么也不扩展
"                   <args>：命令的参数，和实际提供的完全相同
"                   <q-args>: 引号括起, 把参数当做单个值
"                   <f-args>: 
"       delcommand   {cmd}
"   autocmd:
"       autocmd [group] {event} {pat} [++once] [++nested] {cmd}
"       event:
"           Buffers:
"               生命周期: BufAdd  BufNewFile  BufCreate  BufDelete
"               交互: BufEnter  BufLeave
"               读:  BufReadPre  BufRead  BufReadPost  BufReadCmd
"               写:  BufWritePre  BufWritePost  BufWriteCmd
"           Cursor:
"               CursorHold: 用户有一段时间没输入
"               CursorHoldI: 插入模式下, 用户有一段时间没输入
"               CursorMove: 移动光标
"               CursorMoveI: 插入模式下,  移动光标
"           CmdWin:
"               CmdlineEnter  CmdlineLeave  CmdwinEnter  CmdwinLeave
"           Vim:
"               VimEnter  VimLeave
"       pattern:
"           *: 匹配所有
"   Vim脚本:
"       syntax:
"           functions: function-name UpperCase开头
"               function {name}({var1}, {var2}, ...)
"                   {body}
"                   retur val
"               endfunction
"           conditions:
"               if a:num1 < a:num2
"                   let smaller = a:num1
"               else
"                   let smaller = a:num2
"               endif
"               for {varname} in {listexpression}
"                   {commands}
"               endfor
"           变量前缀:
"               a:nanme: 函数参数
"                   a:0(函数参数个数)
"                   a:000(参数列表)
"               b:name: buffer范围
"               s:name: script范围
"               w:name: window范围
"               g:name: golbal范围
"               v:name: vim范围
"           plugin:
"               autoload/**/*.vim: 库脚本
"               plugin/**/*.vim: 插件命令
"       常用函数
"           操作变量类型:
"               字符串: "
"               列表: []
"                   add(list, item): 添加选项
"                   len(list): 列表长度
"                   extend(): +
"                   取值: list[]
"               字典: {key: val}
"                   取值: dict["key"]
"               作业:
"               通道:
"           环境信息:
"               expand
"                   %(当前文件名)
"                   <sfile>(载入的脚本文件或函数名)
"                   :p(扩展为完整的路径)
"                   :h(头部)
"                   :t(尾部)
"                   :r(根部, 去掉一个扩展名)
"                   :e(只有扩展名)
"           定时器相关:
"               timer_start({time}, {callback} [, {options}]): 新建定时器
"               timer_pause({id}, {pause}): 暂停或继续定时器
"               timer_stop({timer}): 停止定时器
"               timer_stopall(): 停止所有定时器
"               timer_info([{id}]): 返回定时器信息列表
