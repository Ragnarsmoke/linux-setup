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

"" Theme plugins

" Minimalist theme
Plugin 'dikiaap/minimalist'

"" Language plugins

" JavaScript
Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on

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

" Tags file
set tags=./tags,tags

" Automatical searching
set incsearch
set hlsearch

" Move vertically visually
nnoremap j gj
nnoremap k gk

"" KEYBINDINGS

" File indentation
map <F7> mzgg=G`z
nnoremap <F5> :!./reloadprod<CR><CR>

" NERD Tree
map <silent> <C-n> :NERDTreeFocus<CR>

" Visual search
vnoremap // y/<C-R>"<CR>

" Newlines without entering insert mode
nmap <CR> o<Esc>
nmap <BS> O<Esc>

" Reset search
nnoremap <F3> :set hlsearch!<CR>

""" PLUGIN CONFIGURATION

"" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.twig,*.md"

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
