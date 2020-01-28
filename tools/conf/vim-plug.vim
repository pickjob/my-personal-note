" GVIM配置
if has("gui_running")
    aunmenu *
    tlunmenu *
    unlet! g:did_install_default_menus
    set guioptions-=m
    set guioptions-=T
    set guioptions+=a
    if has("gui_win32")
        set guifont=FuraCode_Nerd_Font_Mono:h16
        " set guifont=Fira_Code_Medium:h16
        call plug#begin('$HOME/vimfiles/plugged')
    elseif has("gui_gtk2")
        set guifont=FuraCode\ Nerd\ Font\ Mono\ 16
        call plug#begin('~/.vim/plugged')
    elseif has("gui_macvim")
        set guifont=FuraCode\ Nerd\ Font\ Mono:h16
    endif
endif

Plug 'hzchirs/vim-material' " color scheme
Plug 'luochen1990/rainbow' " rainbow
Plug 'vim-airline/vim-airline' " status line
Plug 'preservim/nerdtree' " nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter' " commenter
Plug 'airblade/vim-gitgutter' " git
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
Plug 'rust-lang/rust.vim' " rust
Plug 'skywind3000/asyncrun.vim'
call plug#end()

" Leader设置
let mapleader=";"
"
" vim-material
"
let g:material_style='palenight'
colorscheme vim-material
"
" rainbow
"
let g:rainbow_active=1
"
" airline
"
let g:airline_theme='material'
let g:airline#extensions#tabline#enabled=1
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
"
" nerdtree
let g:NERDTreeWinPos="right"
let g:NERDTreeDirArrowExpandable='👉'
let g:NERDTreeDirArrowCollapsible='👇'
let g:NERDTreeFileExtensionHighlightFullName=1
let g:NERDTreeExactMatchHighlightFullName=1
let g:NERDTreePatternMatchHighlightFullName=1
let g:NERDTreeHighlightFolders=1
let g:NERDTreeHighlightFoldersFullName=1
"
" nerdcommenter
"   <leader>cc : 加注释
"   <leader>cu : 去注释
"
" vim-gitgutter
"   <Leader>hp : hunk preview
"
" coc
"   coc-marketplace
"
" asyncrun.vim
"   :AsyncRun [-cwd=<root>] cmd %:p
let g:asyncrun_open=3

augroup MY_AUTOCMD
    autocmd!
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd h
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" 自定义一些习惯快捷键
if has("clipboard")
    " Ctrl-C / Ctrl-V
    " vnoremap <C-C>      "+y    选中即复制
    imap     <C-V>		<Esc>"+gpi
    cmap     <C-V>		<C-R>+
endif


" vim
"   basic:
"       hjkl(左下上右)  ^$(行首尾)  gg G(页面首尾)  %(跳转匹配)
"       ia(追加插入)  IA(块模式插入追加)  r(替换字符)  x(删除字符)  J(删除换行符)  d[N]d(删除行) y[N]y(复制) p(粘贴) ~(大小写转换) oO(下上插入一行)
"       ><(左右缩进)
"       substitute/{pattern}/{string}/[flags](正则替换)
"       retab(替换tab)
"       u CTRL-R(撤销重做)
"       CTRL-D  CTRL-U(半屏Downwards/Upwards)  CTRL-F  CTRL-B(全屏Forwards/Backwards)
"       v  V  CTRL-V  CTRL-L
"   fold:
"       zo  zc  zr  zm  zO  zC  zR  zM
"       [z(跳转fold开始)  ]z(跳转fold结束)  zj(下一个fold)  zk(上一个fold)
"   buffers:
"       buffers  bfirst  bprevious  bnext  blast
"       % current buffer
"       # alternate buffer
"       a buffer is loaded and display
"       h buffer is loaded and hidden
"       = buffer is read only
"       + buffer has been modified
"   ex-cmd:
"       read  write  edit  saveas  quit
"       cd  pwd  browse  redir  scriptnames
"   map:
"       map  /  imap  /  vmap  /  cmap   <buffer>, <nowait>, <silent>, <special>, <script>, <expr>, <unique>  {lhs}  {rhs}
"   command:
"       -nargs=0  1  *  ?  +
"       -range=  %  {count}
"       -bar
"       <args>  <q-args>  <f-args>
"   script:
"       b:name(buffer)  w:name(window)  g:name(golbal)  v:name(vim)  s:name(script)
"   autocmd:
"       autocmd [group] {event} {pat} {cmd}
"       event
"           Read: BufNewFile  BufReadPre  BufRead  BufReadPost  BufReadCmd
"           Write: BufWrite  BufWritePre  BufWritePost  BufWriteCmd
"           Buffers: BufAdd  BufCreate  BufDelete  BufWipeout
"   channel、job、timer