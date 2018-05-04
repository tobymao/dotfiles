vim:
	rm -rf ~/.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	brew update && brew reinstall the_silver_searcher && brew reinstall ctags && brew install fzf && $(brew --prefix)/opt/fzf/install
	vim -c PlugInstall -c quitall
	~/.vim/plugged/YouCompleteMe/install.py

tmux:
		brew update && brew install reattach-to-user-namespace
