filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go'
Plug 'derekwyatt/vim-scala'
Plug 'pangloss/vim-javascript'
Plug 'cakebaker/scss-syntax.vim'
""You need to create a diversion sudo dpkg-divert --local --divert /usr/bin/node --rename --add /usr/bin/nodejs
""Plug 'marijnh/tern_for_vim'
Plug 'tomasr/molokai'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf.vim'

call plug#end()            " required
filetype plugin indent on  " required

""Line numbers
set number
""Syntax
syntax on
""Highlighting
set hlsearch
highlight Search ctermbg=red ctermfg=yellow
""Indenting
set expandtab
set shiftwidth=2
set tabstop=2

"" Remove Trailing Whitespace on save
augroup Whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup FileTypeSettings
  autocmd!
  "" For go, use tabs
  autocmd BufRead,BufNewFile  *.go set noexpandtab
  "" For python, use 4 spaces
  autocmd BufRead,BufNewFile  *.py set sw=4 cs=4
  "" For pangloss/vim-javascript
  autocmd Bufread,BufNewFile *.js,*.jsx let javascript_enable_domhtmlcss=1
  autocmd Bufread,BufNewFile *.q set filetype=sql
  "" For vim-ruby
  autocmd BufRead,BufNewFile *.html.erb set filetype=eruby.html
  autocmd BufRead,BufNewFile *.js.erb set filetype=eruby.javascript
  autocmd BufRead,BufNewFile *.css.erb set filetype=eruby.css
  autocmd BufRead,BufNewFile *.scss.erb set filetype=eruby.scss
augroup END

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let ruby_no_expensive = 1

""Shows current line, forces a redraw, causes .rb to be slow
""set cursorline
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

nnoremap <C-k> :Tags<CR>
nnoremap <C-p> :FZF -m<CR>

"" Set copy and paste
set clipboard=unnamed

silent! colorscheme molokai

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
