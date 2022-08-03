" vim-textobj-use
"   自定义motion(动作对象)
"       pattern:
"           call textobj#user#plugin('datetime', {
"           \   'date': {
"           \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
"           \     'select': ['ad', 'id'],
"           \   },
"           \   'time': {
"           \     'pattern': '\<\d\d:\d\d:\d\d\>',
"           \     'select': ['at', 'it'],
"           \   },
"           \ })
"           call textobj#user#plugin('braces', {
"           \   'angle': {
"           \     'pattern': ['<<', '>>'],
"           \     'select-a': 'aA',
"           \     'select-i': 'iA',
"           \   },
"           \ })
"       function:
"           call textobj#user#plugin('line', {
"           \   '-': {
"           \     'select-a-function': 'CurrentLineA',
"           \     'select-a': 'al',
"           \     'select-i-function': 'CurrentLineI',
"           \     'select-i': 'il',
"           \   },
"           \ })
"           function! CurrentLineA()
"             normal! 0
"             let head_pos = getpos('.')
"             normal! $
"             let tail_pos = getpos('.')
"             return ['v', head_pos, tail_pos]
"           endfunction
"           function! CurrentLineI()
"             normal! ^
"             let head_pos = getpos('.')
"             normal! g_
"             let tail_pos = getpos('.')
"             let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
"             return
"             \ non_blank_char_exists_p
"             \ ? ['v', head_pos, tail_pos]
"             \ : 0
"           endfunction
" 
" 
" vim-matchup
"       %: 匹配块
" 
let g:matchup_enabled = 1
let g:matchup_mappings_enabled = 0
let g:matchup_surround_enabled = 1
let g:matchup_matchparen_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1
" 
" vim-sneak
"       s{char}{char}
"       S{char}{char}
"       s: next
" 
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
" 
" quick-scope
" 
let g:qs_highlight_on_keys = ['f']
let g:qs_lazy_highlight = 1
" 
" vim-move: 选中文本移动
"       <C-h>: Move current character/selection left
"       <C-j>: Move current line/selection down
"       <C-k>: Move current line/selection up
"       <C-l>: Move current character/selection right
" 
let g:move_key_modifier = 'C'
