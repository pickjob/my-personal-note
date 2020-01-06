" GVIM配置
if has("gui_running")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/mswin.vim
    set guioptions-=m
    set guioptions-=T
    set guioptions+=a
    if has("gui_win32")
        set guifont=Fira_Code_Medium:h16
        call plug#begin('$HOME/vimfiles/plugged')
    elseif has("gui_gtk2")
        set guifont=Fira\ Code\ Medium\ 16
        call plug#begin('~/.vim/plugged')
    elseif has("gui_macvim")
        set guifont=Fira\ Code\ Medium:h16
    endif
endif

Plug 'hzchirs/vim-material' " color scheme
Plug 'luochen1990/rainbow' " rainbow
Plug 'vim-airline/vim-airline' " status line
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim' " rust
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc
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
" coc
"   CocInstall coc-explorer coc-highlight coc-snippets coc-markdownlint coc-css coc-html coc-xml coc-json coc-yaml coc-markdownlint coc-vimlsp coc-git coc-python coc-rls
"   use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
"
" vim-gitgutter
"   <Leader>hp : hunk preview
let g:gitgutter_highlight_lines=1
"
" nerdcommenter
"   <leader>cc : 加注释
"   <leader>cu : 去注释
"
" asyncrun.vim
"   :AsyncRun options cmd
" %:p     - File name of current buffer with full path
" %:t     - File name of current buffer without path
" %:p:h   - File path of current buffer without file name
" %:e     - File extension of current buffer
" %:t:r   - File name of current buffer without path and extension
" %       - File name relativize to current directory
" %:h:.   - File path relativize to current directory
" <cwd>   - Current directory
" <cword> - Current word under cursor
" <cfile> - Current file name under cursor
" <root>  - Project root directory
"
" rust
"   :RustFmt
let g:rustfmt_autosave = 1

" autocmd
" 定义: autocmd [group] {event} {pat} {cmd}
" 去除: autocmd!
" 展示: autocmd [group] {event} / :verbose autocmd BufEnter
" 事件:
"   Read: BufNewFile  BufReadPre  BufRead  BufReadPost  BufReadCmd
"   Write: BufWrite  BufWritePre  BufWritePost  BufWriteCmd
"   Buffers: BufAdd  BufCreate  BufDelete  BufWipeout
" augroup  | exe "au! BufRead *" | augroup END

augroup MY_AUTOCMD
    autocmd!
    autocmd BufRead * call <SID>covertFileFormat()
augroup END

function s:covertFileFormat()
    set fileformat=unix
    write
endfunction




" vim命令
" change:
"   r(替换字符)  x(删除字符)  J(删除换行符)  d[N]d(删除行)
"   :[range]s[ubstitute]/{pattern}/{string}/[flags]