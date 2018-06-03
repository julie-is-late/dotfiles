" jshap's vimrc
" there are many like it, but this one is mine

" Load vim-plug
if !has('win32')
    let autoload_dir=$HOME."/.vim/autoload"
else
    let autoload_dir=$HOME."/vimfiles/autoload"
endif

if empty(glob(autoload_dir."/plug.vim"))
    if !isdirectory(autoload_dir)
        call mkdir(autoload_dir, "p")
    endif
    execute '!curl -fLo '.autoload_dir.'/plug.vim '
                \ .'https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

let color_match = matchstr(&term, '\c256')
if !empty(color_match)
    set t_Co=256
    " FIXME: figure out how to detect truecolor support instead of assuming it
    " with 256 support :)
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " version with literal escape characters
    " let &t_8f = "[38;2;%lu;%lu;%lum"
    " let &t_8b = "[48;2;%lu;%lu;%lum"
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
    set termguicolors
endif

" NOTE: to get 24-bit color in tmux, you must have the following in your
" tmux.conf, as well as ensuring $TERM is set to either `screen-256color' or
" `tmux-256color' based on your setup's support:
" set -ga terminal-overrides ",xterm-256color:Tc,tmux-256color:Tc"

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/seoul256.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'chriskempson/base16-vim'
Plug 'iCyMind/NeoSolarized'
"Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tikhomirov/vim-glsl'
Plug 'tmux-plugins/vim-tmux'
Plug 'pboettch/vim-cmake-syntax'

call plug#end()


""" looks

set background=dark

" set colo for 256-term
if !empty(color_match)
    "let g:seoul256_background=235
    "colo seoul256
    let g:neosolarized_bold = 1
    let g:neosolarized_underline = 1
    let g:neosolarized_italic = 1

    colo NeoSolarized
endif

" set colo & font for gvim
if has("gui_running")
    " fonts
    if has('macunix')
        set guifont=Menlo\ Regular:h14
    elseif has('unix')
        " fun fact: on mac, `has('unix')` returns true.
        " so we must check for mac first, then for *nix
        set guifont=Consolas\ 9
    elseif has('win32')
        set guifont=Consolas:h9:cANSI
    endif

    " window
    set lines=44
    set columns=120

    " colorz
    let g:neosolarized_bold = 1
    let g:neosolarized_underline = 1
    let g:neosolarized_italic = 1

    colo NeoSolarized
elseif &term =~ "^xterm\\|rxvt\\|tmux"
    " vertical bar for insert
    let &t_SI .= "\<Esc>[5 q"
    " normal blink when leaving
    let &t_EI .= "\<Esc>[1 q"
endif


""" misc settings

" completion keybinding
let g:SuperTabDefaultCompletionType = "<c-n>"

" Turn on line numbering. Turn it off with "set nonu"
set number
" set relativenumber
" set cuc
" hi CursorColumn guibg=#3a3a3a

" Turn on column coloring at 80 and 120
set colorcolumn=80,120

" Set syntax on
syntax on

" set case insensitive dir browsing
let g:netrw_sort_options = "i"


" Search
"
" Case insensitive search w/ smartcase matching
set ignorecase
set smartcase
"
" Higlhight search
set hlsearch
"
" Move cusor while matching
set incsearch

" 🍌 splits...
set splitbelow " Splits open below instead of above
set splitright " Vsplits open on the right instead of the left

" Wrap text instead of being on one line
set lbr

" Spellcheck, because I'm a horrible speller
" set spell spelllang=en_us

" Change colorscheme from default to delek
" colorscheme delek

" set indent rules
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Render some whitespace (note that there is some weirdness here because of
" window's default character encoding is used when it reads vimrc
if !has('win32')
    set listchars=tab:>·,trail:·
else
    set listchars=tab:>·,trail:·
endif
set list

" enable mouse
set mouse=a

" Optimize for fast terminal connections
set ttyfast

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamedplus

" Status tweaks
"turn on statusline
set laststatus=2
"custom statusline
set statusline=\ %F\      "filename
"misc info
set statusline+=%h      "help file flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=\ %m    "modified flag
set statusline+=%=      "left/right separator
"encoding info
set statusline+=[       "
set statusline+=%{strlen(&fenc)?&fenc:'none'} "file encoding
"set statusline+=,%{&ff} "file format
set statusline+=]       "
"cursor location info
set statusline+=%3l     "cursor line
set statusline+=:%c     "cursor column
set statusline+=/%L     "total lines
set statusline+=\ %P\   "percent through file


" fun easy way to make aliases for commands!
" (I don't remember where this came from, appologies original creator)
fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
                \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
                \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" make super easy 'diff buffer against saved' command
call SetupCommandAlias("diff","w !diff % -")

" Allow saving of files as sudo when I forgot to start vim using sudo.
call SetupCommandAlias("w!!", "w !sudo tee > /dev/null %")

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

augroup vimrc
    " Remove all vimrc autocommands so they're not duplicated
    au!
    au BufNewFile,BufRead *.glsl,*.vs,*.fs set ft=glsl
    " autocmd FilterWritePost *.glsl,*.vs,*.fs setf glsl
    au BufNewFile,BufRead *.cuh set ft=cuda
    au BufNewFile,BufRead make.inc set ft=make
augroup END

" screen/tmux hax for configuration missmatch on wsl lappy
if &term =~ '^tmux'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" fix ctrl+arrow keys in tmux
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
elseif &term =~ '^tmux'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    map <Esc>[B <Down>
endif

""" misc workarounds
" can't turn off the bell sound in mintty or native wsl ;_;
set noerrorbells visualbell t_vb=

" backspace wasn't working for some reason
if has('win32')
    set backspace=2
    set clipboard=unnamed
endif
