"
" @author pickjob@126.com
"
syntax on
set nocompatible

set number
set ruler
set showcmd
set hidden
set hlsearch
set ignorecase
set signcolumn=yes
set termguicolors
set shortmess+=a
set shortmess+=c
set shortmess-=S
set autochdir
set browsedir=current

" 特殊支持
set mouse=a
set matchpairs="(:),{:},[:],<:>"
set backspace=indent,eol,start

" 备份相关
set nobackup
set noswapfile
set updatetime=3000

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
set list
set listchars=tab:>-,precedes:<,extends:>,trail:-

" wrap相关配置
set nowrap
set sidescroll=10
set whichwrap=b,s,<,>,[,]

" 代码折叠
set foldenable
set foldopen=all
set foldclose=all
set foldlevel=3
set foldcolumn=1
set foldminlines=5
set foldmethod=indent

" 设置内部编码
set encoding=utf-8
set fileencoding=utf-8
