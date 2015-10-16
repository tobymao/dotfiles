alias vim="rvm system do /Applications/MacVim.app/Contents/MacOS/Vim"

export GOPATH=$HOME/dev/go

rtags() {
  ctags --languages=ruby . `bundle show --paths`
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
