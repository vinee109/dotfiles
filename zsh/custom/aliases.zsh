# ================================================================================
# SYSTEM ALIASES
#
# Aliases for system commands like 'cd', 'ls', etc.
# ================================================================================
alias ..="cd .."
alias cd="cdenv"
alias cp="cp -i"
alias df="df -H"
alias gcc="gcc -Wall"
alias ll="ls -l"
alias ls="ls -AFG"
alias mv="mv -i"
alias rm="rm -i"
alias vim="nvim"
alias python="python2"

# automating manual things
alias cdown="mv ~/Downloads/* ~/.Trash"
alias check="ping -o www.google.com"
alias diskspace="du | sort -n -r | more"
alias ipaddress="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | tail -n 1 | sed 's/.*inet \([^ ]*\) .*/\1/'"
alias sublime="open -a \"Sublime Text\""
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias preview="open -a \"Preview\""
alias rmsc="find ~/Desktop -name \"Screen Shot*.png\" -delete"

# ================================================================================
# ARCANIST ALIIASES
#
# Aliases for common usages of arc
# ================================================================================
alias ad="arc diff HEAD^"
alias ado="arc diff --only"
alias alt="arc lint"
alias al="arc land"

# ================================================================================
# GIT
#
# Aliases and functions specific to git commands
# ================================================================================

alias ga="git add"
alias gai="git add -i"
alias gap="git add -p"
alias gb="git branch"
alias gbm="git branch -m"
alias gc="git commit"
alias gcam="git commit -a -m"
alias gcamend="git commit --amend"
alias gch="git checkout"
alias gchb="git checkout -b"
alias gchm="git checkout master"
alias gcl="git clone"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --staged"
alias gh="git help"
alias ghash="git rev-parse"
alias gg="git graph"
alias gl="git log --pretty=format:'%C(yellow)%<(10)%h %Cgreen%<(14)%cr %C(bold magenta)%<(24)%aE %C(bold blue)%d %Creset %s' --abbrev-commit"
alias gm="git merge"
alias gps="git push"
alias gpu="git pull"
alias gr="git rm --cached"
alias gri="git rebase -i"
alias grim="git rebase -i master"
alias grc="git rebase --continue"
alias gs="git status"
alias GS="gs"  # common typo
alias gsp="git stash pop"
alias gst="git stash"
alias pull="git submodule update && git pull"
alias undo="git reset HEAD~"
alias rebase="git checkout master && git pull && git checkout - && git rebase -i master"
alias rebasemaine="git checkout main && git pull && git checkout - && git rebase -i main"

