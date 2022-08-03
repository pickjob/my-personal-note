" fzf
"   functions:
"       fzf#wrap([spec dict][, fullscreen bool]) -> (dict): 合并vim配置生成fzf#run参数
"           fullscreen: 0(default), 1
"           dict:
"               source: data source
"               options: fzf options
"               dir: working directory
"               sink: do with selected
"               up / down / left / right: relative window position
"       fzf#run([spec dict]): vim中运行fzf
let g:fzf_action = { 'ctrl-t': 'tabedit' }
let g:fzf_layout = { 'down': '40%' }
let g:fzf_colors = { 
    \ 'fg':         ['fg', 'Normal'],
    \ 'bg':         ['bg', 'Normal'],
    \ 'preview-bg': ['bg', 'NormalFloat'],
    \ 'hl':         ['fg', 'Comment'],
    \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':        ['fg', 'Statement'],
    \ 'info':       ['fg', 'PreProc'],
    \ 'border':     ['fg', 'Ignore'],
    \ 'prompt':     ['fg', 'Conditional'],
    \ 'pointer':    ['fg', 'Exception'],
    \ 'marker':     ['fg', 'Keyword'],
    \ 'spinner':    ['fg', 'Label'],
    \ 'header':     ['fg', 'Comment'],
    \ }
" 
" fzf.vim
"   command:
"       :Rg [PATTERN]
"       :Files [PATH]
"       :Commands
"       :Snippets
"   functions:
"       fzf#vim#complete(command)
let g:fzf_buffers_jump = 1
" TODO: 添加 Project Dir 支持
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg :call <SID>ripgrepFzf(<q-args>, <bang>0)
