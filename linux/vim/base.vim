set nocompatible " 取消vi兼容
filetype off " Vundle需要

syntax on " 语法高亮
set ignorecase " 搜索忽略大小写
set hlsearch " 高亮查找匹配
set number " 显示行号
set ruler " 显示标尺
set showcmd " 显示命令

" 文件自动检测外部更改
set autoread
set autowrite
set autowriteall

" tab、缩进相关
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" wrap相关配置
set nowrap " 关闭文字回绕
set sidescroll=10 " 水平滚动条
set whichwrap=b,s,<,>,[,]
set list " 制表符、空格显示
set listchars=tab:>-,precedes:<,extends:>,trail:-  

" 代码折叠
set foldenable
set foldmethod=indent
set foldclose=all " 当光标不在折叠上时关闭折叠
set foldopen=all " 命令移动光标到关闭的折叠
set foldminlines=2 " 要折叠最少行数
set foldcolumn=1
set foldtext=v:folddashes.substitute(getline(v:foldstart),’/\*\\|\\*/\\|{{{\d\=’,’’,’g’)

" 设置内部编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese
set fileformat=unix
set fileformats=unix,dos

set nobackup " 无备份
set mouse=a " 鼠标可用
set novisualbell " 使用可视响铃代替鸣叫

set autochdir

" GVIM配置
" 解决菜单乱码
set langmenu=zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8
" set guioptions-=m 隐藏菜单
set guioptions-=T " 隐藏工具栏
set guioptions+=b " 底部的 (水平) 滚动条总是存在
set guioptions+=h " 限制水平滚动条的大小为光标所在行的长度
set guifont=Courier\ 10\ Pitch\ Bold\ 16 " 设置字体