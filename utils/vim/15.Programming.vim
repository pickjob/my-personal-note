" 
" vim-snippets
" 
" 
" vim-template
"       :Template
"           %DATE%: date in `YYYY-mm-dd` format  %YEAR%-%MONTH%-%DAY%
"           %TIME%: time in `HH:MM` format
"           %FDATE%: full date (date and time) in `YYYY-mm-dd HH:MM` %DATE% %TIME%
"           %FILE%: File name, without extension
"           %EXT%: File extension (component after the last period).
"           %FFILE%: File name, with extension `%FILE%.%EXT%`
"           %MAIL%: E-mail address of the current user
"           %USER%: Current logged-in user name
"           %HOST%: Current host name
"           %HERE%: the cursor position
"       自定义变量:
"           let g:templates_user_variables = [
"           \    ['FULLPATH', 'GetFullPath'],
"           \ ]
"           function! GetFullPath()
"               return expand('%:p')
"           endfunction
let g:email = 'pickjob@126.com'
let g:templates_global_name_prefix = '=template='
let g:templates_directory = add([], JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], 'template'))
"
" rust.vim
"       :Cargo
let g:rust_fold = 2
let g:rustfmt_autosave = 1
let g:rust_bang_comment_leader = 1
let g:rust_cargo_check_all_targets = 1
let g:rust_cargo_check_all_features = 1
let g:rust_cargo_check_examples = 1
