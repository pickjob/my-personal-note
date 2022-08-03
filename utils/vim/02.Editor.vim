" 
" vim-better-whitespace
" 
let g:better_whitespace_enabled = 1
let g:better_whitespace_operator = ''
let g:strip_whitelines_at_eof = 0
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 1
let g:strip_max_file_size = 100000
call extend(g:GOBAL_INFO['DELAY_COMMADS'], [
            \ 'EnableStripWhitespaceOnSave',
            \ ])
" 
" vim-interestingwords: 高亮当前词
"       <leader>hh: highligh
"       <leader>hc: clear highligh
"       :call WordNavigation(1)
"       :call WordNavigation(0)
" 
let g:interestingWordsDefaultMappings = 0
let g:interestingWordsRandomiseColors = 1
" 
" vim-easy-align
"       <leader>a[opt1][delimeter]
"           opt1:
"               两边数据 左 右 中 对齐方式切换
"                   <enter>
"               对齐delimeter出现位置: 
"                   2, 3, ... *, **
"           delimeter:
"               <Space>  =  :  .  ,  &  #  ,
" 
let g:easy_align_ignore_groups = ['Comment', 'String']
"
" vim-surround
"       ys / cs / ds + motion + surrounds
"           ys: yank surround(添加)
"               ysiw[   Hello ==> [ Hello ]
"               ysiw<em> Hello wrold ==> <em>Hello</em> world
"               yss)    Hello world ==> (Hello world)
"               ysWfprint    "hello" ==>     print("hello")
"               ysWFprint    "hello"  ==>    print( "hello" )
"           cs: change surround(替换)
"               cs"'    "Hello" ==> 'Hello'
"               cs'<q>  'Hello' ==> <q>Hello</q>
"           ds: delete surround(删除)
"               ds"     "Hello world!" ==> Hello world!
"           surrounds:
"               orgin-surrounds + new-surrounds:
" 
" 
" tagalong.vim
" 
" 
" neoformat
"
" let g:neoformat_verbose = 1
" let g:neoformat_enabled_c = ['clangformat']
" let g:neoformat_c_clangformat = {
"             \ 'exe': $CLANG .. '/bin/clang-format',
"             \ }
" let g:neoformat_enabled_css = ['prettier']
" let g:neoformat_enabled_html = ['prettier']
" let g:neoformat_enabled_xml = ['prettier']
" let g:neoformat_enabled_json = ['prettier']
" let g:neoformat_enabled_yaml = ['prettier']
" let g:neoformat_enabled_rust = ['rustfmt']
"
" nerdtree
"       :NERDTreeToggleVCS
"       :Bookmark
"       o: Open files, directories and bookmarks in current Tab
"       t: Open files, directories and bookmarks in new Tab
"       O: Recursively open the selected directory
"       x: Close the current nodes parent
"       X: Recursively close all children of the current node
"       D: Delete the current bookmark
"
let g:NERDTreeWinPos = 'right'
let g:NERDTreeQuitOnOpen = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let NERDTreeShowLineNumbers = 1
let g:NERDTreeDirArrowExpandable = '👉'
let g:NERDTreeDirArrowCollapsible = '👇'
let g:NERDTreeBookmarksFile = JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], '.NERDTreeBookmarks')
" 
" vim-nerdtree-syntax-highlight
" 
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
" 
" nerdtree-git-plugin
" 
let g:NERDTreeGitStatusUseNerdFonts = 1
" 
" vim-auto-save
" 
let g:auto_save = 1

