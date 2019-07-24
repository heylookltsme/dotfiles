" Plug ins, managed by vim-plug
call plug#begin()

" File management
Plug 'yegappan/mru'                                  " Most-recently-user files
Plug 'tpope/vim-eunuch'                              " Sugar for common commands
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'                              " Project search
Plug 'tpope/vim-vinegar'                             " Some niceties for netrw

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

" Enable syntax highlighting
syntax on

" Colorz
set background=dark
colorscheme peachpuff

" Clear previous search highlighting by hitting enter
noremap <CR> :noh<CR><CR>

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Enable :find to search recursively
set path+=**

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
"set number
set relativenumber

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

" Command to generate tags file
command! MakeTags !ctags -R .

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

" Enable file type detection
filetype plugin indent on

" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

set omnifunc=syntaxcomplete#Complete

" Better comment color
highlight Comment ctermfg=Gray cterm=italic

" Better search and selection highlighting
highlight Search cterm=NONE ctermfg=black ctermbg=yellow
highlight Visual cterm=NONE ctermfg=black ctermbg=yellow

"
" File browsing - netrw
"
let g:netrw_altv=1           " open splits to the right
let g:netrw_liststyle=3      " tree view
let g:netrw_special_syntax=1 " syntax highlighting for more filetypes
let g:netrw_sizestyle="h"    " human-readable filesize
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Custom colors for filetypes. The syntax groups are defined in the
" setup_netrw function below.
highlight netrwDir   ctermfg=033
highlight netrwDir   ctermfg=033
highlight netrwCss   ctermfg=013
highlight netrwScss  ctermfg=013
highlight netrwJs    ctermfg=011
highlight netrwJsx   ctermfg=011
highlight netrwTs    ctermfg=014
highlight netrwTsx   ctermfg=014
highlight netrwJson  ctermfg=015
highlight netrwSvg   ctermfg=015
highlight netrwMd    ctermfg=009
highlight netrwYml   ctermfg=209
highlight netrwYaml  ctermfg=209
highlight netrwPhp   ctermfg=005

" Automatically deletes hidden netrw buffers ❤️
autocmd FileType netrw setl bufhidden=delete
autocmd FileType netrw setl bufhidden=wipe

" Custom syntax highlighting. Must execute _after_ a netrw buffer is opened.
autocmd FileType netrw call s:setup_netrw()

" Custom filetype regexes for custom syntax highlighting.
function! s:setup_netrw() abort
    syntax match netrwJs    "\S\+\.js$"
    syntax match netrwJsx   "\S\+\.jsx$"
    syntax match netrwTs    "\S\+\.ts$"
    syntax match netrwTsx   "\S\+\.tsx$"
    syntax match netrwCss   "\S\+\.css$"
    syntax match netrwScss  "\S\+\.scss$"
    syntax match netrwJson  "\S\+\.json$"
    syntax match netrwSvg   "\S\+\.svg$"
    syntax match netrwMd    "\S\+\.md$"
    syntax match netrwYml   "\S\+\.yml$"
    syntax match netrwYaml  "\S\+\.yaml$"
    syntax match netrwPhp   "\S\+\.php$"
endfunction


" Snippets
" nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a


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

" Fuzzy file finder
nmap <Leader>f :GFiles<CR>

"
" Handy keymappings
"
" Move current line down
map - ddp

" Move current line up
map + ddkP

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
let g:indent_guides_exclude_filetypes = ['help']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=233 " #121212
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

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

" Enable syntax highlighting
" syntax on
