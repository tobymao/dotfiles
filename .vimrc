set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
" You need to create a diversion sudo dpkg-divert --local --divert /usr/bin/node --rename --add /usr/bin/nodejs
Plugin 'marijnh/tern_for_vim'
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""Line numbers
set number
""Syntax
syntax on
""Highlighting
set hlsearch
highlight Search ctermbg=red ctermfg=yellow
""Indenting
set smartindent
set expandtab

set shiftwidth=2
set tabstop=2

"" For golang, use tabs
autocmd BufRead,BufNewFile  *.go set noexpandtab
"" For python, use 4 spaces
""autocmd BufRead,BufNewFile  *.py set shiftwidth=4
""autocmd BufRead,BufNewFile  *.py set tabstop=4

"" Remove Trailing Whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"" For pangloss/vim-javascript
autocmd Bufread,BufNewFile *.js,*.jsx let javascript_enable_domhtmlcss=1

"" For vim-ruby
autocmd BufRead,BufNewFile *.rb,*.erb let g:rubycomplete_buffer_loading = 1
autocmd BufRead,BufNewFile *.rb,*.erb let g:rubycomplete_classes_in_global = 1
""autocmd BufRead,BufNewFile *.rb,*.erb let g:rubycomplete_rails = 1

""Show commands in command line
set showcmd

""Set Nerd Tree Toggle Mapping
noremap <F1> :NERDTreeToggle<CR>
""Set YcmCompleter Mapping
nnoremap <F7> :YcmCompleter GoTo<CR>

"" Set copy and paste
vmap <C-j> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-k> :call setreg("\"",system("pbpaste"))<CR>p

colorscheme molokai

"" allows do/end % for ruby
runtime macros/matchit.vim
