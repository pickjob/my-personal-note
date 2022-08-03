"
" coc
"   command:
"       :CocUpdate
"       :CocOpenLog
"       :CocList [options]
"           lists: list options
"           location
"           extensions
"           diagnostics
"           outline
"           symbols
"           services
"           commands
"           links
"           links
"           sources
let g:coc_start_at_startup = 0
let g:coc_config_home = g:GOBAL_INFO['VIM_FILES_HOME']
let g:coc_data_home = JoinPaths(g:GOBAL_INFO['VIM_FILES_HOME'], 'coc')
let g:coc_global_extensions = [
                        \ 'coc-marketplace',
                        \ 'coc-lists',
                        \ 'coc-json',
                        \ 'coc-yaml',
                        \ 'coc-html',
                        \ 'coc-css',
                        \ 'coc-markdownlint',
                        \ 'coc-highlight',
                        \ 'coc-pairs',
                        \ 'coc-ecdict',
                        \ 'coc-spell-checker',
                        \ 'coc-snippets',
                        \ 'coc-clangd',
                        \ 'coc-pyright',
                        \ 'coc-rust-analyzer',
                        \ 'coc-vimlsp',
                        \ 'coc-toml',
                        \ ]
"   一些文件格式:
"       coc-json
"       coc-yaml
"       coc-html
"       coc-css
"       coc-markdownlint
"   工具:
"       coc-highlight: 高亮光标当前单词
"       coc-pairs: 自动输入一对标点
"       coc-ecdict: 字典
"           :call CocActionAsync('doHover')<CR>: 展示翻译
"       coc-spell-checker: 拼写检查
"       coc-snippets: 代码片段
"   language server:
"       coc-clangd: C Language Server
"       coc-pyright: Python Language Server
"       coc-rust-analyzer: Rust Language Server
"       coc-vimlsp: Vim Language Server
"       coc-toml: Toml Language Server
"   其他:
"       coc-marketplace: 插件集市
"           :CocList marketplace
"       coc-lists: CocList扩展
"           :CocList
"               buffers: current buffer list
"               windows: windows of vim
"               files: search files from current cwd
"               filetypes: file types
"               maps: key mappings
"               vimcommands: available vim commands
"               mru: most recent used files
"               quickfix: items from vim's quickfix list
"               cmdhistory: history of commands
"               searchhistory: history of search
"               words: search word in current buffer
