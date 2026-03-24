# source control

alias gac="git add . && git commit -am"
alias gc="git checkout"
alias g="git status"

# misc

alias ls='ls -G'
alias c="clear"
alias h="history"
alias hgrep="history | grep"

alias flushdns="dscacheutil -flushcache"

alias ll="ls -al"
alias ..="cd .."

projects(){
 cd $HOME/work/$1
}

alias p=projects

# docker

alias dk='docker'
alias dcup='docker compose up'
alias dcdown='docker compose down'
