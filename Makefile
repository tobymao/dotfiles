vim:
	rm -rf ~/.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	brew update && brew reinstall the_silver_searcher && brew reinstall ctags && brew install fzf && $(brew --prefix)/opt/fzf/install
	vim -c PlugInstall -c quitall
	~/.vim/plugged/YouCompleteMe/install.py

tmux:
		brew update && brew install reattach-to-user-namespace

dot: 
	ln -sf ~/dotfiles/.ctags ~/.ctags &&             \
 	ln -sf ~/dotfiles/.git ~/.git &&                 \
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig &&     \
	ln -sf ~/dotfiles/.gitignore ~/.gitignore &&     \
	ln -sf ~/dotfiles/.profile ~/.profile &&         \
	ln -sf ~/dotfiles/.tern-config ~/.tern-config && \
	ln -sf ~/dotfiles/.tmux ~/.tmux &&               \
	ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf &&     \
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
