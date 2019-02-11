" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/plugins/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/plugins')

"
" plugins on GitHub repo
"
Plugin 'rust-lang/rust.vim'
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'joshdick/onedark.vim' " onedark things
Plugin 'scrooloose/nerdtree' " nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " nerdtree-syntax-highlight
Plugin 'ryanoasis/vim-devicons' " devicons
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'tpope/vim-surround'
Plugin 'mhinz/vim-signify'
Plugin 'drmingdrmer/xptemplate'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"

"
" onedark
"
colorscheme onedark
"
" nerdtree
"
let NERDTreeWinPos='right' " 窗口右边
let NERDTreeChDirMode=2 " 自动切换NERDTree目录位置
let NERDTreeBookmarksFile='~/.vim/NERDTreeBookmarks' " 标签地址
let NERDTreeShowBookmarks=1 " 展示标签
let NERDTreeShowHidden=1 " 展示隐藏文件
let NERDTreeShowLineNumbers=1 " 显示行号
let NERDTreeSortOrder=[] " 文件排序
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeDirArrowExpandable = '+' " 指标使用图标
let g:NERDTreeDirArrowCollapsible = '-'
autocmd VimEnter * NERDTree " 启动开启NERDTree
autocmd VimEnter * wincmd h " 光标切换到左边窗口
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if the only window left open is a NERDTree
"
" vim-airline
"
let g:airline_theme='wombat'
let g:airline_detect_iminsert=1
"
" vim-devicons
"
let g:airline_powerline_fonts = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " enable folder/directory glyph flag
let g:DevIconsEnableFoldersOpenClose = 1 " enable open and close folder/directory glyph flags
"
" vim-ctrlspace
"   h - buffer list
"   o - file list
"   l - tab list
"   b - bookmark list
"   w - workspace list
"
set hidden
let g:CtrlSpaceCacheDir = expand('~/.vim')
" let g:CtrlSpaceDefaultMappingKey = "<C-P>"
let g:CtrlSpaceHeight = 5 " the minimal height of the plugin window
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1 " the plugin use mouse
" Automatically Saving Workspace
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
"
" vim-surround
"    cs"'  - "hello" -> 'hello'
"    cst"  - <p>Hello</p> -> "Hello"
"    ds"   - "hello" -> hello
"    ysiw" - hello -> "hello"
"
" xptemplate
"   for<C-\>
"
let g:xptemplate_minimal_prefix = 0
"
" tmux影响
"
" if exists('$TMUX')
"   set term=screen-256color
" endif