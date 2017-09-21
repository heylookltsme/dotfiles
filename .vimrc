" Plug ins, managed by vim-plug
call plug#begin()
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'luochen1990/rainbow'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'editorconfig/editorconfig-vim'
Plug 'jszakmeister/vim-togglecursor'
Plug '1995eaton/vim-better-javascript-completion'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
call plug#end()

" Colorz
set background=dark
colorscheme peachpuff

" Make Vim more useful
set nocompatible

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamed

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

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

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
hi CursorLine cterm=NONE ctermbg=YELLOW

" Highlight a certain column
set colorcolumn=80

" Indents, Tabs/Spaces
set autoindent    " If you're indented, new lines will also be indented
" set smartindent   " Automatically indents l`ines after opening a bracket in programming languages
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

" Highlight dynamically as pattern is typed
set incsearch

" Clear previous search highlighting by hitting enter
nnoremap <CR> :noh<CR><CR>

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

" Use relative line numbers
" if exists("&relativenumber")
"     set relativenumber
"     au BufReadPost * set relativenumber
" endif

" Start scrolling three lines before the horizontal window border
set scrolloff=5

" Set the spellchecking language.
set spelllang=en_us

" Override `ignorecase` option  if the search pattern contains
" uppercase characters.
set smartcase

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
autocmd BufWritePre *.php,*.js,*.scss,*.css,*.tpl,*.html :%s/\s\+$//e

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype plugin indent on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Better comment color
highlight Comment ctermfg=Gray

" Better search and selection highlighting
hi Search cterm=NONE ctermfg=black ctermbg=yellow
hi Visual cterm=NONE ctermfg=black ctermbg=yellow

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
autocmd VimEnter * wincmd p    " Have cursor start in file window
map <C-n> :NERDTreeToggle<CR>  " Map toggle to crtl-n
let NERDTreeShowHidden=1       " Show hidden files
" Better color for directories
autocmd VimEnter,ColorScheme * :hi Directory guifg=#FF0000 ctermfg=red
" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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


"
" Syntastic
"
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']
"
" let g:syntastic_error_symbol = '❌'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩'
"
" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn
"
" hi SpellBad ctermfg=black ctermbg=yellow
" hi SpellCap ctermfg=black ctermbg=yellow

"
" Airline
"
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#hunks#enabled=0

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
" Rainbow
"
let g:rainbow_active = 1

"
" vim-javascript
"
let g:javascript_plugin_jsdoc = 1

"
" CtrlP
"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'

"
" Tern
"
"enable keyboard shortcuts
let g:tern_map_keys=1
"show argument hints
let g:tern_show_argument_hints='on_hold'

"
" YouCompleteMe
"
let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_min_num_of_chars_for_completion = 1
