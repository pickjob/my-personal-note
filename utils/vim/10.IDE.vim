" 
" blamer.nvim
" 
let g:blamer_enabled = 1
" 
" vim-signify
" 
let g:signify_sign_add = ''
let g:signify_sign_delete = ''
let g:signify_sign_delete_first_line = ''
let g:signify_sign_change = ''
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line
" 
" vim-fugitive
"   command:
"       :Git
"           :Git add
"           :Git commit
"           :Git blame
" 
"
" vim-commentary
"   <leader>cc : 加、去注释
"   添加类型注释
"       autocmd FileType apache setlocal commentstring=#\ %s
" 
" 
" vim-bookmarks
"       :BookmarkToggle  :BookmarkNext  :BookmarkPrev
"       :BookmarkAnnotate
"       :BookmarkShowAll  :BookmarkClearAll  :BookmarkSave
" 
let g:bookmark_sign = ''
let g:bookmark_annotation_sign = ''
let g:bookmark_center = 1
let g:bookmark_location_list = 1
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 0
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_save_file = JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], '.vim-bookmarks')
" 
" any-jump.vim
"       :AnyJump / <Leader>j
" 
let g:any_jump_list_numbers = 1
let g:any_jump_references_enabled = 1
let g:any_jump_grouping_enabled = 1
let g:any_jump_preview_lines_count = 7
let g:any_jump_max_search_results = 10
let g:any_jump_search_prefered_engine = 'rg'
let g:any_jump_results_ui_style = 'filename_first'
let g:any_jump_remove_comments_from_results = 0
let g:any_jump_disable_vcs_ignore = 1
" 
" splitjoin.vim
" 
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
"
" asynctasks.vim
"       :AsyncTask task-name
"       :AsyncTaskList
"       :AsyncTaskEdit(.tasks)
"               [task-name]
"               # macros in the "$(...)" form will be substituted, 
"               # shell command, use quotation for filenames containing spaces
"               cwd=$(VIM_ROOT)
"                   
"               # working directory
"               cwd=$(VIM_FILEDIR)
"               output=terminal
"                   quickfix           # Default, simulate a terminal in quickfix window (output will not match the errorformat)
"                   vim	               # Use the old ! command to run your task, some people still like it
"                   external	       # use a new system terminal to run your task
" 
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.hg', '.root', '.project']
let g:asynctasks_term_rows = 10
let g:asynctasks_term_reuse = 1
let g:asynctasks_extra_config = add([], JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], '.tasks'))
"
" vim-startify
"       q: close startify
"       e: close startify and create a blank buffer
"       
"       :Startify
"       startify_lists:
"           type:
"               files: the most recently used files using viminfo
"               dir: the files from the current directory sorted by modification time
"               bookmarks: lists bookmarks
"           function:
"               line: the text to display for this entry
"               cmd: command to execute when the entry gets chosen
"               path: Points to a file
let g:startify_padding_left = 4
let g:startify_change_to_vcs_root = 1
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_dir = JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], '.session')
let g:startify_custom_header = [
                    \ '█████████████████████████████████████████████████████████████████████████████████',
                    \ '█▄─▄███▄─▄▄─██▀▄─██▄─▄▄▀█▄─▀█▄─▄████▀▄─██▄─▀█▄─▄█▄─▄▄▀███▄─▄███▄─▄█▄─█─▄█▄─▄▄─█░█',
                    \ '██─██▀██─▄█▀██─▀─███─▄─▄██─█▄▀─█████─▀─███─█▄▀─███─██─████─██▀██─███▄▀▄███─▄█▀█▄█',
                    \ '█▄▄▄▄▄█▄▄▄▄▄█▄▄█▄▄█▄▄█▄▄█▄▄▄██▄▄███▄▄█▄▄█▄▄▄██▄▄█▄▄▄▄████▄▄▄▄▄█▄▄▄███▄███▄▄▄▄▄█▄█',
                    \ ]
function s:listBookmarkFile()
    let bookmark_list = []
    let nerdtree_list = readfile(g:NERDTreeBookmarksFile, '', 11)
    for entry in nerdtree_list
        if strlen(entry) == 0
            continue
        endif
        let words = split(entry)
        let obj = {}
        let obj['line'] = words[0]
        let obj['path'] = words[1]
        call add(l:bookmark_list, obj)
    endfor
    return bookmark_list
endfunction
let g:startify_lists = [
    \ { 'header': ['    Most Recently Used Files'], 'type': 'files' },
    \ { 'header': ['    Bookmarks'], 'type': function('s:listBookmarkFile')},
    \ { 'header': ['    Sessionss'], 'type': 'sessions' },
    \ ]
