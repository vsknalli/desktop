" joshrosso's vim config
" https://octetz.com

" -------------------------------------------------------------------------------------------------
" plugins
" -------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'roxma/nvim-yarp'
" comment/uncomment code
Plug 'scrooloose/nerdcommenter'
" git integration
Plug 'tpope/vim-fugitive'
" builds on fugitive to work with github
Plug 'tpope/vim-rhubarb'
" file browser
Plug 'scrooloose/nerdtree'
" vim color theme
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" tag browser
Plug 'majutsushi/tagbar' 
" status bar at the bottom of vim
Plug 'itchyny/lightline.vim'
" fuzzy search with several integrations
Plug 'junegunn/fzf.vim'
" LSP client, providing language features
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

" remove delay from vim escape
" https://www.reddit.com/r/vim/comments/2391u5/delay_while_using_esc_to_exit_insert_mode
" delay also must be removed from tmux (if using).
" https://www.johnhawthorn.com/2012/09/vi-escape-delays
augroup FastEscape
   "autocmd!
   "au InsertEnter * set timeoutlen=0
   "au InsertLeave * set timeoutlen=1000
augroup END

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" -------------------------------------------------------------------------------------------------
" colors
" -------------------------------------------------------------------------------------------------
set t_Co=256 "required for urxvt
"set background=dark "dark or light
colorscheme embark

hi Normal ctermbg=none
highlight clear LineNr

source /usr/share/vim/vimfiles/plugin/fzf.vim

" -------------------------------------------------------------------------------------------------
" settings
" -------------------------------------------------------------------------------------------------
filetype on "detect files based on type
filetype plugin on "when a file is edited its plugin file is loaded (if there is one for the 
                   "detected filetype) 
filetype indent on "maintain indentation
syntax on

set incsearch "persist search highlight
set hlsearch "highlight as search matches
set mouse=a "use the mouse; you're a terrible person
set noswapfile "the world is a better place without swap
set nobackup "backups never helped anyone
set nu "enable line numbers
set splitbelow "default open splits below (e.g. :GoDoc)
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< "sets chars representing "invisibles when
                                                       ""`set list!` is called
set expandtab "insert space when tab key is pressed
set tabstop=2 "number of spaces inserted when tab is pressed
set softtabstop=2 
set shiftwidth=2 "number of spaces to use for each auto indent
set cc=100 "draw bar down column 100

let g:ackprg = 'ag --vimgrep' "use ag instead of ack

" -------------------------------------------------------------------------------------------------
" mapping
" -------------------------------------------------------------------------------------------------
let mapleader = "," "leader key is ','

" fzf
noremap <Leader>f :Rg!<cr>
" nerd tree
noremap <Leader>n :NERDTreeToggle<cr>
"! ensures first result is not auto opened
nnoremap <Leader>t :Tagbar<cr>
" toggle show invisibles
nnoremap <leader>l :set list!<CR>
"ctl+space for assist
inoremap <C-@> <c-x><c-o>
nnoremap <Leader>m :set spell!<cr>

" for markdown files:
" auto wrap at 80 characters
" enable spell check
au BufRead,BufNewFile *.md setlocal spell textwidth=80

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'go': ['/usr/bin/gopls'],
    \ 'c': ['/usr/bin/clangd'],
    \ 'haskell': ['haskell-language-server-8.10.4'],
    \ 'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
