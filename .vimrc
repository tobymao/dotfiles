set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'derekwyatt/vim-scala'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
" You need to create a diversion sudo dpkg-divert --local --divert /usr/bin/node --rename --add /usr/bin/nodejs
Plugin 'marijnh/tern_for_vim'
Plugin 'tomasr/molokai'

call vundle#end()            " required
filetype plugin indent on    " required

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
autocmd BufRead,BufNewFile *.rb,*.erb let g:rubycomplete_rails = 1
autocmd BufRead,BufNewFile *.html.erb set filetype=eruby.html
autocmd BufRead,BufNewFile *.js.erb set filetype=eruby.javascript
autocmd BufRead,BufNewFile *.css.erb set filetype=eruby.css
autocmd BufRead,BufNewFile *.scss.erb set filetype=eruby.scss

""Show commands in command line
set showcmd
"" Show path
set statusline+=%F
set laststatus=2
"" ctags path
set tags=./.tags;

""Set Nerd Tree Toggle Mapping
noremap <F1> :NERDTreeToggle<CR>
""Set YcmCompleter Mapping
nnoremap <F7> :YcmCompleter GoTo<CR>

noremap <F2> :CtrlPTag<CR>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ackprg = 'ag --vimgrep'
endif

"" Set copy and paste
set clipboard=unnamed

colorscheme molokai

"" allows do/end % for ruby
runtime macros/matchit.vim

"" tab numbers
set tabline=%!MyTabLine()

function MyTabLine()
	let s = '' " complete tabline goes here
	" loop through each tab page
	for t in range(tabpagenr('$'))
		" select the highlighting for the buffer names
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		let s .= ' ['
		" set the tab page number (for mouse clicks)
		let s .= '%' . (t + 1) . 'T'
		" set page number string
		let s .=  t + 1 . ']'
		" get buffer names and statuses
		let n = ''  "temp string for buffer names while we loop and check buftype
		let m = 0	" &modified counter
		let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ','
		" loop through each buffer in a tab
		for b in tabpagebuflist(t + 1)
			" buffer types: quickfix gets a [Q], help gets [H]{base fname}
			if getbufvar( b, "&buftype" ) == 'help'
				let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
			elseif getbufvar( b, "&buftype" ) == 'quickfix'
				let n .= '[Q]'
			elseif bufname(b) == ''
				let n .= '[No Name]'
			else
				"let n .= pathshorten(bufname(b))
				"let n .= bufname(b)
				let n .= fnamemodify( bufname(b), ':t' )
			endif
			" check and ++ tab's &modified count
			if getbufvar( b, "&modified" )
				let m += 1
			endif
			" no final ' ' added...formatting looks better done later
			if bc > 1
				let n .= ','
			endif
			let bc -= 1
		endfor
		" add modified label [+] where n pages in tab are modified
		if m > 0
			"let s .= '[' . m . '+]'
			let s.= '[+]'
		endif
		let s .= ' '
		" add buffer names
		let s .= n
		" switch to no underlining and add final space to buffer list
		"let s .= '%#TabLineSel#' . ' '
		let s .= ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	return s
endfunction
