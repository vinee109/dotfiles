# System-wide .bashrc file for interactive bash(1) shells.

# ================================================================================
#
# APPEARANCE
#
# Everything revolved to the Shell Prompt
#
# ================================================================================

if [ -z "$PS1" ]; then
   return
fi

# ---------------------
# Colors
# ---------------------

green="\[\033[0;32m\]"
cyan="\[\033[0;36m\]"
blue="\[\033[0;94m\]"
purple="\[\033[0;35m\]"
white="\[\033[00m\]"
bgreen="\[\033[1;32m\]"
bred="\[\033[1;31m\]"

export PS1="$cyan\t $blue(\u@\H) $purple\w $white"'$(git rev-parse &>/dev/null; \
if [ $? -eq 0 ]; then \
    echo -n "$(git diff --quiet ; \
    if [ $? -eq 0 ]; then \
        echo "'$bgreen'($(git rev-parse --abbrev-ref HEAD))'$white'"; \
    else \
        echo "'$bred'{$(git rev-parse --abbrev-ref HEAD)}'$white'" ;\
    fi) " ; \
fi ; \
echo "'$purple'\n\$ '$white'")'

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

# Color scheme used by the output of 'ls'
export LSCOLORS=GxFxCxDxBxegedabagaced


# **************************************
#
# Sets the title of the current tab
#
# Usage:
#    title <whatever title you want>
#
# **************************************
function title {
    echo -ne "\033]0;"$*"\007"
}


# ================================================================================
#
# SYSTEM ALIASES
#
# Aliases for system commands like 'cd', 'ls', etc.
#
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
alias v="vim -O"
alias python="python2"

alias cdown="mv ~/Downloads/* ~/.Trash"
alias check="ping -o www.google.com"
alias diskspace="du | sort -n -r | more"
alias ipaddress="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | tail -n 1 | sed 's/.*inet \([^ ]*\) .*/\1/'"
alias sublime="open -a \"Sublime Text\""
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias preview="open -a \"Preview\""


# ================================================================================
#
# UTILITIES
#
# Functions meant to simplify repetitive commands
#
# ================================================================================

set -o vi
set -o allexport

export EDITOR=vim

# **************************************************************
#
# Compiles any latex file and opens the resulting pdf in Preview
#
# Example Usages:
#    latex foo.tex
#    latex foo
#
# **************************************************************

function latex(){
	pdflatex --file-line-error --synctex=1 $1
	preview ${1%.tex}.pdf
}


# automatically compiles and runs the java file
function run()
{
    [[ -z "$1" ]] && echo "$0: missing argument"
    echo "******* compiling *********"
    #compiles all the files if there are multiple files associated in the same directory
    javac -g "$1"
    echo "******* running $1 *********"
    #runs the specified file
    java ${1%.*}
    if [ "$2" == "-cleanup" ]; then
        echo "******* cleaning up **********"
        move_bin
    fi
}

# moves java class files into a directory called bin
# if dir does not exists, it is created
function move_bin(){
    if [ ! -d "bin" ]; then
        mkdir bin
    fi
    mv -f *.class bin
}

# Acts just like cd but if env/bin/activate exists (python virtual environment)
# then it will automatically be activated
function cdenv(){
    'cd' $1
    if [ -e "env/bin/activate" ]
    then
        source env/bin/activate
    fi
}


# ================================================================================
#
# GIT
#
# Aliases and functions specific to git commands
#
# ================================================================================

alias ga="git add"
alias gai="git add -i"
alias gap="git add -p"
alias gb="git branch"
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
alias gg="git graph"
alias gl="git log --pretty=format:'%C(yellow)%h%Creset %Cgreen(%cr) %C(bold blue)%d%Creset %C(bold magenta)(%an)%Creset %s %Creset' --abbrev-commit"
alias gm="git merge"
alias gps="git push"
alias gpu="git pull"
alias gr="git rm --cached"
alias gs="git status"
alias gsp="git stash pop"
alias gst="git stash"
alias pull="git submodule update && git pull"
alias undo="git reset HEAD~"

function br()
{
    [[ -z "$1" ]] && echo "$0: missing argument" && exit 1
    gb --track "$1" master
    gch "$1"
}

function land()
{
	[[ -z "$1" ]] && BRANCH=$(git rev-parse --abbrev-ref HEAD) || BRANCH="$1"
	[[ "$BRANCH" == "master" ]] && echo "Can't land master" && return 1
	echo "Landing branch $BRANCH"
	echo "Switching to branch master..."
	git checkout master 2>/dev/null || { git checkout master; return 1; }
	echo "Pulling remote changes..."
	git pull || return 2
	echo "Merging $BRANCH into master..."
	git merge "$BRANCH" || return 3
	echo "Pushing changes..."
	git push || return 4
	echo "Cleaning up branch $BRANCH..."
	git branch -d "$BRANCH"
}

function amend()
{
    git add $@
    git commit --amend
}

function rebase()
{
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo "Switching to branch master..."
    git checkout master 2>/dev/null || { git checkout master; return 1; }
    echo "Pulling remote changes to master..."
    git pull || return 2
    echo "Rebasing branch $BRANCH"
    git checkout $BRANCH
    git rebase master
    fab test
}

function revert()
{
    HASH=$(git rev-parse --short $1)
    echo "Creating branch revert-$HASH"
    git checkout master
    git pull
    git checkout -b revert-$HASH
    git revert $HASH
    fab test
}

function pushbranch()
{
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git push origin $BRANCH
}

function pullbranch()
{
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $BRANCH
}

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
    __git_complete gch _git_checkout
    __git_complete gc _git_commit
    __git_complete ga _git_add
fi

if [ -f ~/.uber_bashrc ]; then
    source ~/.uber_bashrc
fi
