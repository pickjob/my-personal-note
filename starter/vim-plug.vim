"
" vim-plug
"
" :PlugUpgrade      - Upgrade vim-plug itself
" :PlugInstall      - Install plugins
" :PlugUpdate       - Install or update plugins
" :PlugClean        - Remove unused directories (bang version will clean without prompt)
"
call plug#begin('~/.vim/plugged')
"
" plugins on GitHub repo
"
Plug 'hzchirs/vim-material' " color scheme
Plug 'vim-airline/vim-airline' " status line
Plug 'scrooloose/nerdtree' " nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " nerdtree-syntax-highlight
Plug 'ryanoasis/vim-devicons' " devicons
Plug 'rust-lang/rust.vim' " rust
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " coc


" Initialize plugin system
call plug#end()

"
" vim-material
"
" Palenight
let g:material_style='palenight'
set background=dark
colorscheme vim-material
"
" airline
"
let g:airline_theme='material'
" airline's tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter='unique_tail'
" symbols
let g:airline_symbols={}
" let g:airline_left_sep='>'
" let g:airline_right_sep='<'
let g:airline_symbols.crypt='🔒'
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr='㏑'
let g:airline_symbols.branch='⎇'
let g:airline_symbols.paste='ρ'
let g:airline_symbols.spell='Ꞩ'
let g:airline_symbols.notexists='Ɇ'
let g:airline_symbols.whitespace='Ξ'
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
let g:NERDTreePatternMatchHighlightFullName=1
let g:NERDTreeHighlightFolders=1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible=''
autocmd VimEnter * NERDTree " 启动开启NERDTree
autocmd VimEnter * wincmd h " 光标切换到左边窗口
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if the only window left open is a NERDTree
"
" vim-devicons
"
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " enable folder/directory glyph flag
let g:DevIconsEnableFoldersOpenClose = 1 " enable open and close folder/directory glyph flags
" "
" " vim-ctrlspace
" "   h - buffer list
" "   o - file list
" "   l - tab list
" "   b - bookmark list
" "   w - workspace list
" "
" set hidden
" let g:CtrlSpaceCacheDir = expand('~/.vim')
" " let g:CtrlSpaceDefaultMappingKey = "<C-P>"
" let g:CtrlSpaceHeight = 5 " the minimal height of the plugin window
" let g:CtrlSpaceUseMouseAndArrowsInTerm = 1 " the plugin use mouse
" " Automatically Saving Workspace
" let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
" let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
" let g:CtrlSpaceSaveWorkspaceOnExit = 1
" "
" " vim-surround
" "    cs"'  - "hello" -> 'hello'
" "    cst"  - <p>Hello</p> -> "Hello"
" "    ds"   - "hello" -> hello
" "    ysiw" - hello -> "hello"
" "
" " xptemplate
" "   for<C-\>
" "
" let g:xptemplate_minimal_prefix = 0
" "
" " tmux影响
" "
" " if exists('$TMUX')
" "   set term=screen-256color
" " endif