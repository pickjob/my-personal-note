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
Plug '~/.fzf' " fzf
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
" coc
"
" CocInstall coc-css coc-html coc-json coc-yaml coc-tsserver coc-angular coc-python coc-rls coc-snippets
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
