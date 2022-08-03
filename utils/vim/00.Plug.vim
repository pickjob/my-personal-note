" 
" vim-plug
"       PlugInstall PlugUpdate
"       PlugUpgrade
"       PlugStatus
"       PlugClean
"       Plug 'username/repository', {option: value}
"           option:
"               branch / tag / commit
"               rtp: subdirector contains vim plugin
"               dir: set plugin directory
"               do: post-update hook
"               on: on-demand loading, command
"               for: on-demand loading, filetype
" 
call plug#begin(JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], 'plugged'))
" 
" UI
" 
" color scheme
Plug 'embark-theme/vim'
" Plug 'kaicataldo/material.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'embark-theme/vim'" })
Plug 'ryanoasis/vim-devicons'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'ryanoasis/vim-devicons'" })
" indent
Plug  'Yggdroot/indentLine'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'Yggdroot/indentLine'" })
" rainbow
Plug 'luochen1990/rainbow'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'luochen1990/rainbow'" })
" cursor animate 
" Plug 'danilamihailov/beacon.nvim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'danilamihailov/beacon.nvim'" })
" window animate
" Plug 'camspiers/animate.vim'
" status line
Plug 'vim-airline/vim-airline'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'vim-airline/vim-airline'" })
" 
" Editor
" 
" strip trailing whitespace
" Plug 'ntpeters/vim-better-whitespace'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'ntpeters/vim-better-whitespace'" })
" hiligh words
" Plug 'lfv89/vim-interestingwords'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'lfv89/vim-interestingwords'" })
" align
" Plug 'junegunn/vim-easy-align'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'lfv89/vim-interestingwords'" })
" surround
" Plug 'tpope/vim-surround'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'tpope/vim-surround'" })
" tag change along
" Plug 'AndrewRadev/tagalong.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'AndrewRadev/tagalong.vim'" })
" format
" Plug 'sbdchd/neoformat'
" nerdtree
" Plug 'preservim/nerdtree', {'on': 'NERDTreeToggleVCS'}
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggleVCS'}
" Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggleVCS'}
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'preservim/nerdtree'" })
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'tiagofumo/vim-nerdtree-syntax-highlight'" })
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'Xuyuanp/nerdtree-git-plugin'" })
" auto save
" Plug '907th/vim-auto-save'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'907th/vim-auto-save'" })
" 
" Search & substitute
" 
" preview search
" Plug 'haya14busa/incsearch.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'haya14busa/incsearch.vim'" })
" fuzzy search
" Plug 'haya14busa/incsearch-fuzzy.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'haya14busa/incsearch-fuzzy.vim'" })
" preview substitute 
" Plug 'markonm/traces.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'markonm/traces.vim'" })
" 
" Motion
" 
" textobj define
" Plug 'kana/vim-textobj-user'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'kana/vim-textobj-user'" })
" synctax match
Plug 'andymass/vim-matchup'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'andymass/vim-matchup'" })
" quick jump
" Plug 'justinmk/vim-sneak'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'justinmk/vim-sneak'" })
" line quick jump
" Plug 'unblevable/quick-scope'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'unblevable/quick-scope'" })
" move part text up/down
" Plug 'matze/vim-move'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'matze/vim-move'" })
" 
" Fuzzy
" 
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'junegunn/fzf'" })
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'junegunn/fzf.vim'" })
" 
" IDE
" 
" git
" Plug 'APZelos/blamer.nvim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'APZelos/blamer.nvim'" })
" Plug 'mhinz/vim-signify'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'mhinz/vim-signify'" })
" Plug 'tpope/vim-fugitive'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'tpope/vim-fugitive'" })
" commenter
" Plug 'tpope/vim-commentary'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'tpope/vim-commentary'" })
" bookmarks
Plug 'MattesGroeger/vim-bookmarks'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'MattesGroeger/vim-bookmarks'" })
" Jump
Plug 'pechorin/any-jump.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'pechorin/any-jump.vim'" })
" Split & Join lines
" Plug 'AndrewRadev/splitjoin.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'AndrewRadev/splitjoin.vim'" })
" asyncrun
" Plug 'skywind3000/asyncrun.vim'
" Plug 'skywind3000/asynctasks.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'skywind3000/asyncrun.vim'" })
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'skywind3000/asynctasks.vim'" })
" start page
" Plug 'mhinz/vim-startify'
" 
" Programming
" 
" snippets
" Plug 'honza/vim-snippets'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'honza/vim-snippets'" })
" template
" Plug 'aperezdc/vim-template'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'aperezdc/vim-template'" })
" " rust
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'rust-lang/rust.vim'", 'options': "{ 'for': 'rust' }" })
" 
" coc
" 
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call add(g:GOBAL_INFO['PLUGINS'],
    \ { 'name': "'neoclide/coc.nvim'", 'options': "{ 'branch': 'release'}" }
    \ )
" 
" Others
" 
" profile
" Plug 'tweekmonster/startuptime.vim'
call add(g:GOBAL_INFO['PLUGINS'], { 'name': "'tweekmonster/startuptime.vim'"})
call plug#end()
let $NVIM_COC_LOG_LEVEL='all'