# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

green="\[\033[0;32m\]"
cyan="\[\033[0;36m\]"
purple="\[\033[0;35m\]"
white="\[\033[00m\]"
bgreen="\[\033[1;32m\]"
bred="\[\033[1;31m\]"

#PS1="$cyan\t: $green\w \$ $white"

export PS1="$cyan\t: $purple\w $white"'$(git rev-parse &>/dev/null; \
if [ $? -eq 0 ]; then \
    echo -n "$(git diff --quiet ; \
    if [ $? -eq 0 ]; then \
        echo "'$bgreen'($(git symbolic-ref --short -q HEAD))'$white'"; \
    else \
        echo "'$bred'{$(git symbolic-ref --short -q HEAD)}'$white'" ;\
    fi) " ; \
fi ; \
echo "'$purple'\$ '$white'")'

export LSCOLORS=GxFxCxDxBxegedabagaced

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


ASCRIPT=$HOME/Developer/Scripts
export DOCPATH=$HOME/Developer/Java/docs
export CLASSPATH=.:$HOME/Developer/Java/jars/*:$HOME/Developer/Java/gjdb/bin

###########
# Aliases #
###########

alias ..="cd .."
alias cp="cp -i"
alias df="df -H"
alias gcc="gcc -Wall"
alias ll="ls -l"
alias ls="ls -AFG"
alias mv="mv -i"
alias mv_noconfirm="yes | mv"
alias p="python3"
alias rm="rm -i"
alias v="vim -O"

alias cleandesk="osascript $ASCRIPT/cleandesk.scpt"
alias cdown="mv ~/Downloads/* ~/.Trash"
alias check="ping -o www.google.com"
alias diskspace="du | sort -n -r | more"
alias hiddenoff="defaults write com.apple.Finder AppleShowAllFiles FALSE; killall Finder"
alias hiddenon="defaults write com.apple.Finder AppleShowAllFiles TRUE; killall Finder"
alias ipaddress="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | tail -n 1 | sed 's/.*inet \([^ ]*\) .*/\1/'"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias thachi="osascript -e 'tell app \"System Events\" to sleep'"
alias sublime="open -a \"Sublime Text 2\""

set -o vi
set -o allexport

export EDITOR=vim
SERVER_CS61B="cs61b-acx@star.cs.berkeley.edu"
SERVER_CS70="cs70-jd@star.cs.berkeley.edu"

function lx()
{
    file=$(basename "${1}")
    pdflat "${file}" && open ${file%.tex}.pdf
}

#### BERKELEY CS CLASSES #####

# shortcut for automatically navigating to various directories
function goto(){
    [[ -z "$1" ]] && echo "$0: missing argument"
    if [ "$1" == "cs61b" ]; then
        cd ~/desktop/school/Spring_2014/CS61B
    fi
    if [ "$1" == "cs70" ]; then
        cd ~/desktop/school/Spring_2014/CS70
    fi
    if [ "$1" == "uconnect" ]; then
        cd ~/desktop/projects/uconnect
    fi
    if [ "$1" == "projects" ]; then
        cd ~/desktop/projects
    fi
    if [ "$1" == "footprintz" ]; then
        cd ~/desktop/projects/footprintz
    fi
}

#checking grades
function grades(){
    echo -e "Grades for CS61B"
    ssh ${SERVER_CS61B} "glookup"
    echo -e "\nGrades for CS70"
    ssh ${SERVER_CS70} "glookup"
}

# check grade ranks in cs61b and cs70
function grade_stats(){
    echo -e "Stats for CS61B"
    ssh ${SERVER_CS61B} "glookup -s \"Total\""
    echo -e "Stats for CS70"
    ssh ${SERVER_CS70} "glookup -s \"Total\""

}

#login to either cs61b or cs70 account based on argument
function login()
{
    [[ -z "$1" ]] && echo "$0: missing argument"
    if [ "$1" == "cs61b" ]; then
        echo "logging into cs61b-acx"
        ssh $SERVER_CS61B
    fi
    if [ "$1" == "cs70" ]; then
        echo "logging into cs70-jd"
        ssh $SERVER_CS70
    fi
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
    if ["$2 == -cleanup"]; then
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

#### CS 61B PROJECT 1 ####

function blur()
{
    javac -cp "jai_core.jar:jai_codec.jar" *.java
    java -cp ".:jai_core.jar:jai_codec.jar" Blur $1 $2
    move_bin
}

function sobel()
{
    javac -cp "jai_core.jar:jai_codec.jar" *.java
    java -cp ".:jai_core.jar:jai_codec.jar" Sobel $1 $2
    move_bin 
}

#### CS 61B PROJECT 2 ####

function network(){
    javac -g */*.java
    java Network $1 $2
}

### GIT ###

function br()
{
    [[ -z "$1" ]] && echo "$0: missing argument" && exit 1
    git branch --track "$1" master
    git checkout "$1"
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
