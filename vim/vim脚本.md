# 编写vim脚本
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