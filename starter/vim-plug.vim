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
" Plug 'edkolev/tmuxline.vim' " tmux status
Plug 'rust-lang/rust.vim' " rust
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " coc


" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""
" 插件配置(最懒)
"
" vim-material
"
" let g:material_style='oceanic'
let g:material_style='palenight'
colorscheme vim-material
"
" airline
"
let g:airline_theme='material'
let g:airline#extensions#tabline#enabled=1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
"
" nerdtree
"
let NERDTreeWinPos='right'
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible=''
"
" nerdtree-syntax-highlight
"
"
" vim-devicons
"
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
"
" coc
"
