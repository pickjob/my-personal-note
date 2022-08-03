"
" material.vim
"
colorscheme embark
" colorscheme night-owl
" let g:material_theme_style = 'ocean'
" let g:material_terminal_italics = 1
" colorscheme material
" 
" indentLine
" 
let g:indentLine_enabled = 1
let g:indentLine_color_gui = '#FF5F00'
let g:vim_json_conceal = 0
let g:markdown_syntax_conceal = 0
"
" rainbow
"
let g:rainbow_active = 1
" 
" beacon.nvim
" 
" 
" vim-xtabline
"       XTabNextBuffer
"       XTabPrevBuffer 
" 
let g:xtabline_settings = {}
let g:xtabline_settings.enabled = 1
let g:xtabline_settings.theme = 'codedark'
let g:xtabline_settings.tabline_modes = ['buffers']
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.buffers_paths = 0
let g:xtabline_settings.current_tab_paths = 0
let g:xtabline_settings.other_tabs_paths = 0
"
" vim-airline
"       自定义part:
"           airline#parts#define_function(part_name, func)
"           airline#parts#define_text(part_name, content)
"       section_x:
"           airline#section#create([part_name]) " 引用part
"
let g:airline_theme = 'embark'
" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.readonly = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.branch = 'שׂ'
let g:airline_symbols.dirty = ''
let g:airline_symbols.linenr = 'ﲐ '
let g:airline_symbols.colnr = 'ﲒ '
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''
" tabline
let g:airline#extensions#tabline#enabled  = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 1
" coc
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ''
let g:airline#extensions#coc#warning_symbol = ''
