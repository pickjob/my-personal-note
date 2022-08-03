function s:hover_before_check()
    try
        if coc#rpc#ready()
            if len(CocAction("getHover")) > 0 
                call CocActionAsync("doHover")
            endif
            call CocActionAsync("highlight")
        endif
    catch
    endtry
endfunction

function s:delay_funs(timer)
    call plug#begin(JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], 'plugged'))
    for plugin in g:GOBAL_INFO['PLUGINS']
        if len(keys(plugin)) == 1
            execute "Plug " .. plugin["name"]
        else
            execute "Plug " .. plugin["name"] .. ", " .. plugin["options"]
        endif
    endfor
    call plug#end()
    " vim-interestingwords: 高亮当前词
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nnoremap    <silent>    <leader>hh    :call InterestingWords("n")<cr>',
        \ 'vnoremap    <silent>    <leader>hh    :call InterestingWords("v")<cr>',
        \ 'nnoremap    <silent>    <leader>hc    :call UncolorAllWords()<cr>',
        \ 'vnoremap    <silent>    <leader>hc    :call UncolorAllWords()<cr>',
        \ ])
    " vim-easy-align: 排版
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nmap    <leader>a    <Plug>(EasyAlign)',
        \ 'vmap    <leader>a    <Plug>(EasyAlign)',
        \ ])
    " nerdtree
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nmap    <silent>    <leader>n    :NERDTreeToggleVCS<CR>'
        \ ])
    " incsearch
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'map    <silent>    /    <Plug>(incsearch-forward)',
        \ 'map    <silent>    ?    <Plug>(incsearch-backward)',
        \ ])
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'map    <silent>    <leader>/    <Plug>(incsearch-fuzzy-/)',
        \ ])
    " match-up
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nmap    %    <Plug>(matchup-%)',
        \ ])
    " vim-commentary
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nmap    <silent>    <leader>cc    <Plug>Commentary$',
        \ ])
    " splitjoin.vim
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'nmap    <Leader>j    :SplitjoinJoin<CR>',
        \ 'nmap    <Leader>s    :SplitjoinSplit<CR>',
        \ ])
    " asynctasks.vim
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
        \ 'autocmd    BufRead, BufNewFile    *.tasks    setfiletype    async_task',
        \ 'nmap    <silent><F2>    :AsyncTask file-run<CR>',
        \ 'nmap    <silent><F9>    :AsyncTask file-build<CR>',
        \ ])
    " coc
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
            \ 'CocStart',
            \ 'nmap    <silent>    <F12>    :call <plug>(coc-definition)<CR>',
            \ ])
    " Copy & Paste
    call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
            \ 'nmap    <C-C>    "+y',
            \ 'vmap    <C-C>    "+y',
            \ 'nmap    <C-X>    "+x',
            \ 'nmap    <C-V>    "+gP',
            \ 'imap    <C-V>    <Esc>"+gPi',
            \ 'cmap    <C-V>    <C-R>+',
            \ ])
    for cmd in g:GOBAL_INFO['DELAY_COMMADS']
        execute cmd
    endfor
    autocmd    CursorHold    *    silent    call s:hover_before_check()
    " vim-plug自动下载插件
    if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        PlugInstall
    endif
endfunction

" 进入执行一次设置
augroup RUN_ONCE
    autocmd!
    call timer_start(3000, 's:delay_funs')
augroup END
