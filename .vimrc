" Plug ins, managed by vim-plug
call plug#begin()
" File management
Plug 'scrooloose/nerdtree'                           " File browser
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'       " File browser highlighting
Plug 'Xuyuanp/nerdtree-git-plugin'                   " Git indicators in nerdtree
Plug 'ctrlpvim/ctrlp.vim'                            " Fuzzy file finder
Plug 'yegappan/mru'                                  " Most-recently-user files

" Syntax stuff
Plug 'luochen1990/rainbow'
Plug 'ap/vim-css-color'                              " Highlight colors in style files
Plug 'pangloss/vim-javascript'                       " Better JS syntax highlighting
Plug 'mxw/vim-jsx'                                   " JSX syntax highlighting
Plug 'leafgarland/typescript-vim'                    " TS syntax highlighting
Plug 'peitalin/vim-jsx-typescript'                   " JSX syntax highlighting in TS
Plug 'hail2u/vim-css3-syntax'                        " Better css syntax highlighting
Plug 'cakebaker/scss-syntax.vim'                     " Sass syntax highlighing
Plug 'styled-components/vim-styled-components', {
    \'branch': 'main'
\}                                                   " Styled components syntax highlighting

" Linting / Formatting
Plug 'w0rp/ale'                                      " Linting
Plug 'prettier/vim-prettier', {
    \'do': 'yarn install'
\}                                                   " Auto formatting

" Autocompletion
Plug 'Valloric/YouCompleteMe', {
    \'do': './install.py --all'
\}                                                   " Semantic completion
Plug 'lvht/phpcd.vim', {
    \'for': 'php', 'do': 'composer install'
\}                                                   " Semantic completion for php
Plug '1995eaton/vim-better-javascript-completion'    " I don't think I need this

" Editor configuration
Plug 'vim-airline/vim-airline'                       " Status bar
Plug 'vim-airline/vim-airline-themes'                " Status bar themes
Plug 'ryanoasis/vim-devicons'                        " Nerd icons for various plugins
Plug 'airblade/vim-gitgutter'                        " Git status in the gutter
Plug 'nathanaelkane/vim-indent-guides'               " Indentation indicators
Plug 'editorconfig/editorconfig-vim'                 " Editor config
Plug 'jszakmeister/vim-togglecursor'                 " Different cursors in different modes

" Editing Tools
Plug 'scrooloose/nerdcommenter'                      " Commenting tools
Plug 'tpope/vim-fugitive'                            " Git commands
Plug 'heavenshell/vim-jsdoc'                         " JSDoc helpers
Plug 'alvan/vim-closetag'                            " HTML auto close tag
Plug 'jiangmiao/auto-pairs'                          " Auto close parens, brackets

" Vim Themes
Plug 'morhetz/gruvbox'
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
" gruvbox settings need to come before colorscheme line
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
colorscheme gruvbox

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
nmap <S-Right> :bnext<CR>

" Move to the previous buffer
nmap <S-Left> :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <S-q> :bp <BAR> bd #<CR>

" Split
noremap <C-h> :<C-u>split<CR>
noremap <C-v> :<C-u>vsplit<CR>

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
" | Plugins                                                             |
" ----------------------------------------------------------------------

"
" NERDTree
"
" Have cursor start in file window
autocmd VimEnter * wincmd p

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

" Better color for directories
autocmd VimEnter,ColorScheme * :hi Directory ctermfg=gray

"
" Ale - linting
"
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
highlight clear ALEWarningSign
highlight clear ALEErrorSign
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-l> <Plug>(ale_next_wrap)

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['tslint'],
\   'php': ['psalm'],
\}

let b:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'jsx': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\}

let g:ale_fix_on_save = 1

"
" Airline
"
let g:airline_theme = 'gruvbox'
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
nmap <silent> <C-j> ?function<cr>:noh<cr><Plug>(jsdoc)

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
set splitbelow
