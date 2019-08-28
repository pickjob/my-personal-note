# vim普通模式操作
- 基本命令
  - :r(ead)
  - :new
  - :e(dit)
  - :w(rite)
  - :q(uit)
  - :saveas(另存为)
  - :first / :previouce / :next / :last
- 移动
  - h(左) j(下) k(上) l(右)
  - ^(行首) b/ge(上一个单词词首/词末) w/e(下一个单词词首/词末) $(行尾)
  - %(括号匹配)
  - nG(n行) gg(文件首) GG(尾)
  - 50%(百分比)
  - 滚动
    - 整屏滚动
      - CTRL-F(Forward) / CTRL-B(Backward)
    - 半屏滚动
      - CTRL-U(Upper) / CTRL-D(Down)
    - 当前光标行更改
      - zt(改为顶层)
      - zz(改为中间行)
      - zb(改为底层)
    - 跳转
      - CTRL-O(old) / CTRL-I(new)
      - ''
      - ma / 'a
- 新建一行
  - o(下面) / O(上面)
- d(delete)
  - x(删除一个字符)
  - dw(删除一个单词)
  - d$(删除到当行结尾)
  - dd(删除一行)
  - J(删除换行字符)
- c(change)
  - c^ / c$ / cc
- f(find)
  - f?(正向) F?(反向)
  - /(正向) ?(反向)
  - \> 开始  \< 结束
- yank(抽取)
  - y(抽取一个字符)
  - yw(抽取一个单词)
  - y$(抽取到行尾)
  - yy(抽取一行)
- .(重复命令)
- put(放置)
  - P(前面) / p(后面)
- 替换
  - :[range]substitute/from/to/[flags]
  - :%substitute/four/4/g(所有行中替换)
- U(撤销) 
- CTRL-R(重做)
- 选择模式
  - V(行选择)
  - CTRL-V(列选择)
    - I(左边插入)
    - A(右边插入)
    - ~(大小写转换) U(小写转大写) u(大写转小写)
    - >(平移)
    - o(斜对角) O(横向对角)
- 窗口管理
  - :split :vsplit (分割窗口)
  - CTRL-W + / -(调整大小)
  - CTRL-W h / j / k / l / t / b (窗口跳转)
  - CTRL-W H / J / K / L (移动窗口)
- 缓冲区
  - :buffers
    - u 列表外缓冲区
    - % 当前缓冲区
    - # 轮换缓冲区
    - a 激活缓冲区
    - h 隐藏缓冲区
    - = 制度缓冲区
    - - 不可该缓冲区
    - + 已修改缓冲区
  - :buffer idx
  - :bdelete
  - :bfist :bprevious :bnext :blast 
- 折叠
  - zf(Fold create)
  - zo(Open a fold)
  - zc(Close a fold)
  - zr(Reduce fold)
  - zR(Reduce all fold)
  - zm(More fold)
  - zM(More all fold)
- 剪贴板
  - "+y
  - "+p
- 执行外部命令
  - :!sort
- 二进制文件
  - vim -b datafile
  - set display=uhex
  - :%!xxd
  - :%!xxd -r
  - (ga)显示当前光标字符十六进制
- # 编写vim脚本
- 基本语法
    ```vim
    " 分支循环
    if {condition}
        {expr}
    elseif {condition}
    else
        {expr}
    endif
    for i in range(1, 4)
        ${expr}
    endfor
    while {condition}
        {expr}
    endwhile
    " 函数
    function! {name}({var1},{var2},...)
        {body}
    endfunction
    " 列表、字典
    let alist = ['a','b','c']
    let adict = {'a':'a','b':'b'}
    ```
- 变量范围
    - a:name 函数参数变量
    - l:name 函数内局部变量
    - s:name 脚本局部变量
    - b:name 缓冲区局部变量
    - w:name 窗口的局部变量
    - t:name 标签局部变量
    - g:name 全局变量
    - v:name vim预定义变量
- 表达式
    - $NAME 环境变量
    - &name vim选项
    - @r    寄存器
- 禁止加载
    ```vim
    if exists("g:loaded_typecorr")
        finish
    endif
    let g:loaded_typecorr = 1
    ```
- 键映射(map)
    - :map <F2> GoDate: <Esc>:read !date<CR>kJ (普通,可视模式及操作符等待模式)
    - :imap <F2> <CR>Date: <Esc>:read !date<CR>kJ (插入模式)
    - :nmap(普通模式)
    - :vmap(可视模式)
    - :cmap(命令行模式)
    - :omap(操作符等待模式)
    - :map!(插入和命令行模式)
    - nore(不再映射) un(不映射)
    - 建表
      - <k0> - <k9>: 数字0-9
      - <S-...>: Shift + ...
      - <C-...>: Control + ...
      - <Alt-...>: Alt + ...
      - <Esc>: Esc键
      - <Up>:
      - <Space>:
      - <Tab>:
      - <CR>: 回车
      - <BS>: backspace退格键
      - <F1> - <F12>
    - 特殊参数
      - <buffer>: 当前buffer
      - <silent>: 不回显
      - <special>: 有副作用
      - <expr>: 参数
      - <unique>: 唯一
      - <Leader>: 
    - <SID>
    - <Plug>
- 自动命令
    - :autocmd [group] {events} {file_pattern} [nested] {command}
    - events
        - BufReadPost
    - file_pattern
        - * ? [abc] . a{b,c}
- :redir! > a.txt
- verbose map
- redir END