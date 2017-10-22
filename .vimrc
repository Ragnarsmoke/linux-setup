set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""" VUNDLE PLUGINS
" Vundle
Plugin 'VundleVim/Vundle.vim'

"" Basic plugins

" NERDTree
Plugin 'scrooloose/nerdtree'
" Surround
Plugin 'tpope/vim-surround'
" Commentary
Plugin 'tpope/vim-commentary'
" Vim twig
Plugin 'lumiliet/vim-twig'
" Closetag
Plugin 'alvan/vim-closetag'
" YouCompleteMe
Plugin 'Valloric/YouCompleteMe' 
" UltiSnips
Plugin 'SirVer/ultisnips'
" Snippets
Plugin 'honza/vim-snippets'
" Supertab
Plugin 'ervandew/supertab'
" Auto pairs
Plugin 'jiangmiao/auto-pairs'
" Syntastic
Plugin 'vim-syntastic/syntastic'
" Scratch.vim
Plugin 'mtth/scratch.vim'
" CtrlP
Plugin 'kien/ctrlp.vim'
" Hardmode
Plugin 'wikitopian/hardmode'
" Expand region
Plugin 'terryma/vim-expand-region'
" PHP Completion
Plugin 'shawncplus/phpcomplete.vim'
" Emacs-like command line movement
Plugin 'houtsnip/vim-emacscommandline'
" Fugitive git wrapper
Plugin 'tpope/vim-fugitive'
" Tagbar outline
Plugin 'majutsushi/tagbar'

"" Theme plugins

" Minimalist theme
Plugin 'dikiaap/minimalist'

"" Language plugins

" JavaScript
Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on

set tags+=tags;

""" THEME

" Theme in 256 color mode
if has("gui_running") || &term == "xterm-256color" || &term == "screen-256-color"
    " Enable solarized color scheme
    colorscheme minimalist

    " Highlight current line
    set cursorline
else
    " Use default color scheme
    colorscheme default
endif

if has("gui_running")
    " Font
    set guifont=Hack\ 9

    " Disable graphical scrollbar
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
endif

""" CONFIGURATION

" Enable syntax highlighting
syntax enable

" Search functions
set ignorecase
set smartcase
set path=$PWD/**
set laststatus=2

" Relative line numbering
set relativenumber

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" %% = working directory of current buffer
cabbr <expr> %% expand('%:p:h')

" Command bar
set showcmd

function! SelectIndent ()
    let temp_var=indent(line("."))

    while indent(line(".")-1) >= temp_var
        exe "normal k"
    endwhile

    exe "normal V"

    while indent(line(".")+1) >= temp_var
        exe "normal j"
    endwhile
endfun

" Tags file
set tags=./tags,tags

" Automatical searching
set incsearch
set hlsearch

" Move vertically visually
nnoremap j gj
nnoremap k gk

" Persistent undo
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"" KEYBINDINGS

" Select indentation block
nmap <Space> :call SelectIndent()<CR>

" Split vertically in a new buffer
nnoremap <Leader>h :new<CR>
nnoremap <Leader>v :vnew<CR>

" File indentation
map <F7> mzgg=G`z
nnoremap <F5> :!./reloadprod<CR><CR>

" NERD Tree
map <silent> <C-n> :NERDTreeFocus<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>
" Visual search
vnoremap // y/<C-R>"<CR>

" Newlines without entering insert mode
nmap <CR> o<Esc>
nmap <BS> O<Esc>

" Reset search
nnoremap <F3> :set hlsearch!<CR>

""" PLUGIN CONFIGURATION

"" Closetag
let g:closetag_filenames = "*.htm,*.html,*.xhtml,*.phtml,*.twig,*.md,*.xml,*.php"

"" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:UltiSnipsEditSplit="vertical"

"" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|var|web|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

"" Office theme
let g:office_dark_CursorLineNr = 'off'
let g:office_light_CursorLineNr = 'off'
let g:office_dark_LineNr = 'off'
let g:office_light_LineNr = 'off'

"" JavaScript
let g:javascript_plugin_jsdoc = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
