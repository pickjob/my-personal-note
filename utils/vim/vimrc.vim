"
" @author pickjob@126.com
"
syntax on
set nocompatible
set hidden
set autochdir
set browsedir=current
set history=100
set backspace=indent,eol,start
set sidescroll=10
set whichwrap=b,s,<,>,[,]
set spell
set modeline
" 基本界面信息
set number
set signcolumn=yes
set ruler
set list
set listchars=tab:>-,precedes:<,extends:>,trail:-
set showcmd
set showmode
set shortmess+=a
set shortmess+=c
set shortmess-=S
" 突出当前行、列
set cursorline
set cursorcolumn
" 括号匹配
set showmatch
set matchpairs="(:),{:},[:],<:>"
" 查找
set smartcase
set ignorecase
set hlsearch
set incsearch
" 文件自动检测外部更改
set autoread
set autowrite
set autowriteall
set updatetime=800
" tab、缩进相关
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" wrap相关配置
set nowrap
" 代码折叠
set foldenable
set foldopen=all
set foldclose=all
set foldlevel=4
set foldcolumn=1
set foldminlines=5
set foldmethod=indent
" 分割配置
set splitbelow
set splitright
" 设置内部编码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
" 备份相关
set nobackup
set noswapfile
set nowritebackup
" 鼠标支持
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 开启类型插件
filetype on
filetype plugin on
filetype indent on
" GVIM配置
if has("gui_running")
    aunmenu *
    tlunmenu *
    unlet! g:did_install_default_menus
    set guioptions-=m
    set guioptions-=T
    set guioptions+=a
    if has("unix")
        set guifont=FuraCode\ NF\ 16
    elseif has("win32")
        set guifont=FuraCode_NF:h16
    endif
endif
" 调试详情文件输出开关
" let g:debug_flag = 1
" 
" 跳过内置脚本、映射
" 
" skip file type maps
let g:no_plugin_maps = 1
" skip getscript
let g:loaded_getscriptPlugin = 1
" skip netrwPlugin.vim
let g:loaded_netrwPlugin = 1
" skip rrhelper.vim
let g:loaded_rrhelper = 1
" skip tohtml.vim
let g:loaded_2html_plugin = 1
" skip viimballPlugin.vim
let g:loaded_vimballPlugin = 1
" 
" 自定义配置
"
" Leader Key
let mapleader = ";"
" 
" 全局信息
"       g:GOBAL_INFO['DIRECTORY_SPLITOR']: 文件路径分隔符
"       g:GOBAL_INFO['VIM_FILES_HOME']: Vimfiles目录(~/repository/vimfiles)
"       g:GOBAL_INFO['DELAY_COMMADS']: 延迟命令
let g:GOBAL_INFO = {}
" 全局信息初始化
function! s:initEnvironment()
    let g:GOBAL_INFO['VIM_FILES_HOME'] = expand('$VIM_FILES_HOME')
    if has("unix")
        let g:GOBAL_INFO['DIRECTORY_SPLITOR'] = '/'
    elseif has("win32")
        let g:GOBAL_INFO['DIRECTORY_SPLITOR'] = '\'
    endif
    let g:GOBAL_INFO['PLUGINS'] = []
    let g:GOBAL_INFO['DELAY_COMMADS'] = []
endfunction
" 拼接路径
function! JoinPaths(...)
    if a:0 == 0
        return ''
    else
        return reduce(a:000, { acc, val ->  acc .. g:GOBAL_INFO['DIRECTORY_SPLITOR'] .. val})
    endif
endfunction
call s:initEnvironment()
execute 'set runtimepath+=' .. g:GOBAL_INFO['VIM_FILES_HOME']
" viminfo格式
"   !: 如果包含，保存和恢复大写字母开头，并且不包含小写字母的全局变量
"   %: 如果包含，保存和恢复缓冲区列表
"   ": 寄存器最大保存行数, < 项目旧名
"   <: 每个寄存器保存最大行数
"   ': 编辑过文件最大项目数
"   /: 搜索历史最大项目数
"   :: 保存命令最大项目数
"   h: 载入文件时是否搞来那个
set viminfo=%,\"500,<500,'100,:100,h
execute 'set viminfofile=' .. JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], '_viminfo')
let s:my_vim_scripts_home = expand('<sfile>:h')
let s:my_vim_scripts = readdir(s:my_vim_scripts_home, {n -> n =~ '.vim$' && n != 'vimrc.vim' && n != 'vim-start.vim'})
for s:vim_script in s:my_vim_scripts
    execute 'source ' .. JoinPaths(s:my_vim_scripts_home, s:vim_script)
endfor
