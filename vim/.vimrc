set nocompatible              " be iMproved, required
set noswapfile                " disable swap files
syntax enable                 " enable syntax hightlight and completion
filetype off                  " required

set backspace=2
set smarttab
set smartindent

set tabstop=2
set expandtab
set shiftwidth=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => search highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("extra_search")
    " Highlight searches [use :noh to clear]
    set hlsearch
    " Highlight dynamically as pattern is typed
    set incsearch
    " Ignore case of searches...
    set ignorecase
    " ...unless has mixed case
    set smartcase
endif
" doubly esc for clear search highlight
nnoremap <esc><esc> :noh<return>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" code complete plugin
Plugin 'Valloric/YouCompleteMe'
Plugin 'github/copilot.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" 4 space show a white line
Plugin 'Yggdroot/indentLine'
"Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'
Plugin 'raimondi/delimitmate'  " automatic closing of quotes, parenthesis, brackets
Plugin 'tpope/vim-commentary'  " comment stuff out
Plugin 'honza/vim-snippets'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plugin 'prettier/vim-prettier', {'do': 'yarn install'}


" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'leafgarland/typescript-vim'
Plugin 'tpope/vim-markdown'
Plugin 'chemzqm/wxapp.vim'

Plugin 'posva/vim-vue'      "vue highlighter
Plugin 'ap/vim-css-color'   "preview css color
Plugin 'mattn/emmet-vim'    "emmet for vim
Plugin 'pangloss/vim-javascript'  "javascript indentation and syntax
Plugin 'maxmellon/vim-jsx-pretty' "JSX and TSX syntax pretty highlighting
Plugin 'airblade/vim-gitgutter'   "git diff in the gutter

"Check syntax in Vim asynchronously and fix files
Plugin 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
set clipboard=unnamed

set relativenumber
set number
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

set colorcolumn=100

" theme 
set t_Co=256
let g:solarized_termcolors=256

" ycm GoTo shortcut
map <C-g> :YcmCompleter GoTo<cr>

" source vimr config filv
nnoremap <leader>sv :source $MYVIMRC<cr>

" map to shell shortcut
imap <c-a> <esc>0i
imap <c-e> <esc>$a

" auto add header
augroup insertheader
    autocmd!
    autocmd BufNewFile *.py 0put =\"# -*- coding: utf-8 -*-\<nl>\"|$
augroup END

" shortcut to invoke ack search
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    let word = substitute(@@, '^\s*\(.\{-}\)\s*$', '\1', '')
    if len(word) <= 1
        echo "Short word search omitted!"
        return
    endif

    execute "Ack " . shellescape(word)
endfunction

" shortcut to enclose the cursor word with input char
nnoremap <c-e> :silent call EncloseWord()<cr>

function! EncloseWord()
    let l:c = nr2char(getchar())
    if l:c ==# '(' || l:c ==# ')'
        let l:l = '('
        let l:r = ')'
    elseif l:c ==# '{' || l:c ==# '}'
        let l:l = '{'
        let l:r = '}'
    elseif l:c ==# '[' || l:c ==# ']'
        let l:l = '['
        let l:r = ']'
    elseif l:c ==# '<' || l:c ==# '>'
        let l:l = '<'
        let l:r = '>'
    elseif l:c ==# '“' || l:c ==# '”'
        let l:l = '“'
        let l:r = '”'
    else
        let l:l = l:c
        let l:r = l:c
    endif

    let cursor = expand("<cWORD>")
    let cursor = substitute(cursor, '^\s*\(.\{-}\)\s*$', '\1', '')
    if len(cursor) <= 1
        execute "normal! i" . l:l . l:r
        startinsert
    else
        execute "normal! viW\<esc>a" . l:r . "\<esc>Bi" . l:l . "\<esc>lEl"
    endif
endfunction

" fast open file mapping
map <leader>v :vsplit <c-r>=expand("%:p:h")<cr>/
map <leader>s :split <c-r>=expand("%:p:h")<cr>/
map <leader>e :edit <c-r>=expand("%:p:h")<cr>/

" git diff highlight
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

" emmet for vim
imap <C-e> <Space><BS><plug>(emmet-expand-abbr)
let g:user_emmet_install_global = 1
let g:user_emmet_settings = {
  \ 'wxss': {
  \   'extends': 'css',
  \ },
  \ 'wxml': {
  \   'extends': 'html',
  \   'aliases': {
  \     'div': 'view',
  \     'span': 'text',
  \   },
    \ 'javascript.jsx' : {
    \   'extends' : 'jsx',
    \  },
    \ 'javascript' : {
    \   'extends' : 'jsx',
    \  },
  \  'default_attributes': {
  \     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
  \     'navigator': [{'url': '', 'redirect': 'false'}],
  \     'scroll-view': [{'bindscroll': ''}],
  \     'swiper': [{'autoplay': 'false', 'current': '0'}],
  \     'icon': [{'type': 'success', 'size': '23'}],
  \     'progress': [{'precent': '0'}],
  \     'button': [{'size': 'default'}],
  \     'checkbox-group': [{'bindchange': ''}],
  \     'checkbox': [{'value': '', 'checked': ''}],
  \     'form': [{'bindsubmit': ''}],
  \     'input': [{'type': 'text'}],
  \     'label': [{'for': ''}],
  \     'picker': [{'bindchange': ''}],
  \     'radio-group': [{'bindchange': ''}],
  \     'radio': [{'checked': ''}],
  \     'switch': [{'checked': ''}],
  \     'slider': [{'value': ''}],
  \     'action-sheet': [{'bindchange': ''}],
  \     'modal': [{'title': ''}],
  \     'loading': [{'bindchange': ''}],
  \     'toast': [{'duration': '1500'}],
  \     'audio': [{'src': ''}],
  \     'video': [{'src': ''}],
  \     'image': [{'src': '', 'mode': 'scaleToFill'}],
  \   }
  \ },
  \}

" NERDTree
map <C-n> : NERDTreeToggle<CR>
let NERDTreeWinSize=25
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden= 1
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.DS_Store']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync


" ctrlp ignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Vim-commentary
map <C-_> : Commentary<cr>
autocmd FileType python,shell set commentstring=#\ %s
autocmd FileType mako set cms=##\ %s

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_enable_domhtmlcss = 1

" vim jsx pretty
let g:vim_jsx_pretty_enable_jsx_highlight = 1
let g:vim_jsx_pretty_colorful_config = 1
augroup JSX
  autocmd!
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" vue highlight
autocmd FileType vue syntax sync fromstart
 " 1 tab == 2 space in js, vue, html, css
autocmd FileType javascript,html,css,vue setlocal ts=2 sts=2 sw=2

" -----------------------------------------------------------------------------
" Airline (Powerline)
" -----------------------------------------------------------------------------
" powerline symbols
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"this line will break airline
"set ambiwidth=double
Plugin 'wakatime/vim-wakatime'
