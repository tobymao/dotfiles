alias vim="rvm system do /Applications/MacVim.app/Contents/MacOS/Vim"

export GOPATH=$HOME/dev/go

rtags() {
  ctags --languages=ruby . `bundle show --paths`
}

fgr() {
  local file
  file=$(grep --line-buffered --color=never -r "" * | fzf | sed 's/:.*$//')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

fbr() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | fzf +s +m) &&
    git checkout $(echo "$branch" | sed "s/.* //")
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
