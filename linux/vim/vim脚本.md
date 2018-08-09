# 编写vim脚本
- 变量
    - let
    - unlet
- 分支
    ```vim
    while {condition}
        {expr}
    endwhile
    if {condition}
        {expr}
    elseif {condition}
    else
        {expr}
    endif
    ```
- 函数
    ```vim
    function! {name}({var1},{var2},...)
        {body}
    endfunction
    ```
- 列表、字典
    ```vim
    let alist = ['a','b','c']
    let adict = {'a':'a','b':'b'}
    ```
- 禁止加载
    ```vim
    if exists("g:loaded_typecorr")
    finish
    endif
    let g:loaded_typecorr = 1
    ```
- Example
    ```
    if exists("g:loaded_typecorr")
        finish
    endif
    let g:loaded_typecorr = 1
    let s:save_cpo = &cpo
    set cpo&vim
    iabbrev teh the
    iabbrev otehr other
    iabbrev wnat want
    iabbrev synchronisation
        \ synchronization
    if !hasmapto(’<Plug>TypecorrAdd’)
    map <unique> <Leader>a <Plug>TypecorrAdd
    endif
    noremap <unique> <script> <Plug>TypecorrAdd <SID>Add
    noremenu <script> Plugin.Add\ Correction <SID>Add
    noremap <SID>Add :call <SID>Add(expand("<cword>"), 1)<CR>
    function s:Add(from, correct)
        let to = input("type the correction for " . a:from . ": ")
        exe ":iabbrev " . a:from . " " . to
        if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
        let s:count = s:count + 1
        echo s:count . " corrections now"
    endfunction
    if !exists(":Correct")
        command -nargs=1 Correct
    endif
    let &cpo = s:save_cpo
    unlet s:save_cpo
    ```
    ```vim
    " 演示快速载入的 Vim 全局插件
    " Last Change: 2005 Feb 25
    " Maintainer: Bram Moolenaar <Bram@vim.org>
    " License: This file is placed in the public domain.
    if !exists("s:did_load")
        command -nargs=* BNRead call BufNetRead(<f-args>)
        map <F19> :call BufNetWrite(’something’)<CR>
        let s:did_load = 1
        exe ’au FuncUndefined BufNet* source ’ . expand(’<sfile>’)
        finish
    endif
    function BufNetRead(...)
        echo ’BufNetRead(’ . string(a:000) . ’)’
        " 读入功能在此
    endfunction
    function BufNetWrite(...)
        echo ’BufNetWrite(’ . string(a:000) . ’)’
        " 写回功能在此
    endfunction
    ```