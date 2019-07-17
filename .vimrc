" Plug ins, managed by vim-plug
call plug#begin()

" File management
Plug 'scrooloose/nerdtree'                           " File browser
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'       " File browser highlighting
Plug 'Xuyuanp/nerdtree-git-plugin'                   " Git indicators in nerdtree
Plug 'ctrlpvim/ctrlp.vim'                            " Fuzzy file finder
Plug 'yegappan/mru'                                  " Most-recently-user files
Plug 'tpope/vim-eunuch'                              " Sugar for common commands
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'                              " Project search

" Syntax stuff
Plug 'luochen1990/rainbow'
Plug 'ap/vim-css-color'                              " Highlight colors in style files
Plug 'pangloss/vim-javascript'                       " Better JS syntax highlighting
Plug 'maxmellon/vim-jsx-pretty'                      " JSX syntax highlighting
Plug 'leafgarland/typescript-vim'                    " TS syntax highlighting
Plug 'hail2u/vim-css3-syntax'                        " Better css syntax highlighting
Plug 'cakebaker/scss-syntax.vim'                     " Sass syntax highlighing
Plug 'styled-components/vim-styled-components', {
    \'branch': 'main'
\}                                                   " Styled components syntax highlighting

" Linting / Formatting
Plug 'w0rp/ale'                                      " Linting

" Autocompletion
Plug 'Valloric/YouCompleteMe', {
    \'do': './install.py --all'
\}                                                   " Semantic completion
Plug 'lvht/phpcd.vim', {
    \'for': 'php', 'do': 'composer install'
\}                                                   " Semantic completion for php

" Editor configuration
Plug 'vim-airline/vim-airline'                       " Status bar
Plug 'vim-airline/vim-airline-themes'                " Status bar themes
Plug 'ryanoasis/vim-devicons'                        " Nerd icons for various plugins
Plug 'airblade/vim-gitgutter'                        " Git status in the gutter
Plug 'nathanaelkane/vim-indent-guides'               " Indentation indicators
Plug 'jszakmeister/vim-togglecursor'                 " Different cursors in different modes
Plug 'tpope/vim-sleuth'                              " Detect spacing

" Editing Tools
Plug 'scrooloose/nerdcommenter'                      " Commenting tools
Plug 'tpope/vim-fugitive'                            " Git commands
Plug 'heavenshell/vim-jsdoc'                         " JSDoc helpers
Plug 'alvan/vim-closetag'                            " HTML auto close tag

" Debugging tools
Plug 'vim-vdebug/vdebug'                             " php xdebug client

call plug#end()

set nocompatible

" Disable visualbell
set visualbell t_vb=

" Handy dandy aliases for common typos.
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Colorz
set background=dark
colorscheme peachpuff

" Clear previous search highlighting by hitting enter
noremap <CR> :noh<CR><CR>

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Increase command line history.
set history=5000

" Change mapleader
let mapleader=","

" Fuck .swps
set nobackup
set noswapfile
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Fix syntax highlighting in massive files -
" https://github.com/vim/vim/issues/2790#issuecomment-400547834
set redrawtime=10000

" Highlight current line
set cursorline

" Highlight a certain column
set colorcolumn=80

" Indents, Tabs/Spaces
set autoindent    " If you're indented, new lines will also be indented
"set smartindent   " Automatically indents lines after opening a bracket in programming languages
set expandtab     " Inserts spaces when tab is hit
set tabstop=4     " How much space Vim gives to a tab
set smarttab      " Improves tabbing
set shiftwidth=4  " Number of spaces when indenting
set softtabstop=4 " Don't think I need this in combo with the other options

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Override `ignorecase` option  if the search pattern contains
" uppercase characters.
set smartcase

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" Enable mouse in all modes
set mouse=a

" Enable extended regexp.
set magic

" Hide mouse pointer while typing.
set mousehide

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Report the number of lines changed.
set report=0

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling five lines before the horizontal window border
set scrolloff=5

" Set the spellchecking language.
set spelllang=en_us

" Allow cursor to be anywhere.
set virtualedit=all

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Strip whitespace on write for certain files
autocmd BufWritePre *.php,*.js,*.scss,*.css,*.tpl,*.html,*.jsx,*.ts,.*tsx :%s/\s\+$//e

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype plugin indent on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

set omnifunc=syntaxcomplete#Complete

" Better comment color
highlight Comment ctermfg=Gray cterm=italic

" Better search and selection highlighting
highlight Search cterm=NONE ctermfg=black ctermbg=yellow
highlight Visual cterm=NONE ctermfg=black ctermbg=yellow

"
" Buffer management
"
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <S-n> :enew<cr>

" Move to the next buffer
noremap <S-Right> :bnext<CR>

" Move to the previous buffer
noremap <S-Left> :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <S-q> :bp <BAR> bd #<CR>

" Split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" MRU
map <S-f> :MRU<CR>

" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------

function! GetGitBranchName()
    let branchName = ""
    if exists("g:loaded_fugitive")
        let branchName = "[" . fugitive#head() . "]"
    endif
    return branchName
endfunction


" ----------------------------------------------------------------------
" | Status Line                                                        |
" ----------------------------------------------------------------------

" Terminal types:
"
"   1) term  (normal terminals, e.g.: vt100, xterm)
"   2) cterm (color terminals, e.g.: MS-DOS console, color-xterm)
"   3) gui   (GUIs)

highlight ColorColumn
    \ term=NONE
    \ cterm=NONE  ctermbg=237    ctermfg=NONE
    \ gui=NONE    guibg=#073642  guifg=NONE

highlight CursorLine
    \ term=NONE
    \ cterm=NONE  ctermbg=235  ctermfg=NONE
    \ gui=NONE    guibg=#073642  guifg=NONE

highlight CursorLineNr
    \ term=bold
    \ cterm=bold  ctermbg=NONE   ctermfg=178
    \ gui=bold    guibg=#073642  guifg=Orange

highlight LineNr
    \ term=NONE
    \ cterm=NONE  ctermfg=241    ctermbg=NONE
    \ gui=NONE    guifg=#839497  guibg=#073642

highlight User1
    \ term=NONE
    \ cterm=NONE  ctermbg=237    ctermfg=Grey
    \ gui=NONE    guibg=#073642  guifg=#839496


" ----------------------------------------------------------------------
" | Plugins                                                             |
" ----------------------------------------------------------------------

"
" NERDTree
"
" Have cursor start in file window
autocmd VimEnter * wincmd p

" Open if starting vim with no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |  endif

" Map toggle to ctrl-n
noremap <silent> <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=1

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Put it on the right
let g:NERDTreeWinPos = "right"

" Some highlight stuff
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" No help message
let g:NERDTreeMinimalUI = 1

" Needed to show folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" More fun arrows
let NERDTreeNodeDelimiter = "\x07"
let NERDTreeDirArrowExpandable = "\uf061"
let NERDTreeDirArrowCollapsible = "\uf063"

"
" NERDTree Syntax Highlight
"
" Better color for directories
highlight Directory ctermfg=66
highlight NERDTreeOpenable ctermfg=130

" Fix folder icon colors - https://github.com/ryanoasis/vim-devicons/issues/250
highlight! link NERDTreeFlags NERDTreeDir

" Some color variables
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:salmon
let g:NERDTreeExtensionHighlightColor['scss'] = s:salmon
let g:NERDTreeExtensionHighlightColor['json'] = s:pink
let g:NERDTreeExtensionHighlightColor['js'] = s:green
let g:NERDTreeExtensionHighlightColor['jsx'] = s:green
let g:NERDTreeExtensionHighlightColor['ts'] = s:green
let g:NERDTreeExtensionHighlightColor['tsx'] = s:green
let g:NERDTreeExtensionHighlightColor['svg'] = s:aqua
let g:NERDTreeExtensionHighlightColor['md'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['yml'] = s:yellow
let g:NERDTreeExtensionHighlightColor['yaml'] = s:yellow

"
" Ale - linting
"
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
highlight clear ALEWarningSign
highlight clear ALEErrorSign
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>l <Plug>(ale_next_wrap)

" javascript files are being mistaken for typescript for some reason
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    au BufNewFile,BufRead *.js set filetype=javascript.js
augroup END

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': [],
\   'typescript': ['tsserver', 'eslint'],
\   'php': ['psalm', 'php'],
\}

let b:ale_fixers = {
\   'typescript': ['prettier', 'eslint'],
\   'tsx': ['prettier', 'eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_lint_delay = 500

"
" Airline
"
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Ale errors
let g:airline#extensions#ale#enabled = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_left_sep = "\uE0B0"
let g:airline_right_sep = " \uE0B2"

" Straight tabs, no arrows.
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" It's always utf-8! Who cares!!
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Better ale symbols
let g:airline#extensions#ale#error_symbol = ':'
let g:airline#extensions#ale#warning_symbol = ' :'

" Remove filetype name (just symbol)
let g:airline_section_x = ''

" Fix delay after leaving insert mode
set ttimeoutlen=50

"
" NERDCommenter
"
" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"
" JSDoc
"
let g:javascript_plugin_jsdoc = 1
let g:jsdoc_param_description_separator = ' - '
let g:jsdoc_underscore_private = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_tags = {} | let g:jsdoc_tags['object'] = 'Object'
nmap <silent> <Leader>j ?function<cr>:noh<cr><Plug>(jsdoc)

"
" Indent Guides
"
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=233 " #121212
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

"
" CtrlP
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|vendor|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_clear_cache_on_exit = 0

"
" YouCompleteMe
"
let g:ycm_autoclose_preview_window_after_completion = 1
highlight YcmErrorSection ctermbg=None ctermfg=None
map <C-\> :YcmCompleter GoTo<CR>

"
" Git gutter colors
"
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
"
" Vdebug Options
"
let g:vdebug_options = {
\    'port' : 9000,
\    'timeout' : 20,
\    'server' : '127.0.0.1',
\    'on_close' : 'stop',
\    'break_on_open' : 0,
\    'ide_key' : '',
\    'debug_window_level' : 0,
\    'debug_file_level' : 0,
\    'debug_file' : '',
\    'path_maps' : {
\       '/home/vimeo/phpsrc/' : '/Users/hoenerc/projects/vimeo/',
\    },
\    'watch_window_style' : 'expanded',
\    'marker_default' : '⬦',
\    'marker_closed_tree' : '▸',
\    'marker_open_tree' : '▾',
\    'sign_breakpoint' : '▷',
\    'sign_current' : '▶',
\    'continuous_mode'  : 1
\}

"
" Folding
"
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
" let g:php_folding=1

"
" Toggle cursor
"
let g:togglecursor_leave = 'line'
