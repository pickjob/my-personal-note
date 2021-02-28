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

if has("unix")
    call plug#begin('~/.vim/plugged')
elseif has("win32")
    call plug#begin('$HOME/vimfiles/plugged')
endif

Plug 'hzchirs/vim-material' " color scheme
Plug 'luochen1990/rainbow' " rainbow
Plug 'vim-airline/vim-airline' " status line
Plug 'preservim/nerdtree' " nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter' " commenter
Plug 'honza/vim-snippets'

" fzf:  general fuzzy finder written by go
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" skim:  general fuzzy finder written by rust
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" Plug 'lotabout/skim.vim'
Plug 'jiangmiao/auto-pairs' " auto-pairs
Plug 'tpope/vim-surround' " surround
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  } " markdown
Plug 'rust-lang/rust.vim' " rust
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
Plug 'skywind3000/asyncrun.vim'
" Plug 'sjl/gundo.vim'

call plug#end()

" Leader设置
let mapleader=";"
"
" vim-material
"
let g:material_style='palenight'
set background=dark
colorscheme vim-material
"
" rainbow
"
let g:rainbow_active=1
"
" airline
"
let g:airline_theme='material'
let g:airline#extensions#coc#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_section_c = '%t'
"
" nerdtree
"
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
" fzf.vim
"   :Files [PATH]
"   :Rg [PATTERN]
"   :Snippets
"
" auto-pairs
"
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
"
" surround
"
" cs"'    "Hello" ==> 'Hello'
" cs'<q>  'Hello' ==> <q>Hello</q>
" ds"     "Hello world!" ==> Hello world!
" cs[{    [Hello] ==> { Hello }
" ysiw[   Hello ==> [ Hello ]
" yss)    Hello world ==> (Hello world)
" ysiw<em> Hello wrold ==> <em>Hello</em> world
"
" vim-gitgutter
"   <Leader>hp : hunk preview
"
" vim-rust
"
let g:rust_fold=2
let g:rustfmt_autosave=1
"
" coc
"   :CocInstall coc-marketplace (CocList marketplace)
"   :CocInstall coc-bookmark coc-tasks(CocList tasks) coc-yank(CocList yank) coc-todolist coc-template(CocList template) coc-snippets
"   :CocInstall coc-html coc-css coc-format-json coc-sh coc-sql coc-vimlsp coc-yaml coc-docker coc-rls coc-python
"   :CocInstall coc-spell-checker coc-git
" coc-bookmark
nmap <Leader>bb <Plug>(coc-bookmark-toggle)
nmap <Leader>bj <Plug>(coc-bookmark-next)
nmap <Leader>bk <Plug>(coc-bookmark-prev)
" coc-snippets
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" coc-template
inoremap <silent><expr> <Lead>tt <Plug>(coc-template-top)
" format
" :CocCommand formatJson --indent=4
" :CocCommand sql.Format
"
" asyncrun.vim
"   :AsyncRun [-cwd=<root>] cmd %:p
let g:asyncrun_open=5
"
" markdown
let g:mkdp_page_title = '「${name}」'
" options for markdown render
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }


augroup MY_AUTOCMD
    autocmd!
    autocmd BufRead,BufNewFile *.rs,*.toml nmap <F9> :AsyncRun -cwd=<root> cargo run<CR>
    imap     <C-V>		<Esc>"+gpi
    cmap     <C-V>		<C-R>+
    nmap     <C-T>      :bnext<CR>
    autocmd VimEnter * NERDTree
    autocmd VimEnter * wincmd h
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

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