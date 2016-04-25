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
export CLASSPATH=.:$HOME/Developer/Java/jars/*:$HOME/Developer/Java/gjdb/bin:$HOME/Desktop/Projects/DataStructs/*
export LSCOLORS=GxFxCxDxBxegedabagaced

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
alias python="python2"

alias cleandesk="osascript $ASCRIPT/cleandesk.scpt"
alias cdown="mv ~/Downloads/* ~/.Trash"
alias check="ping -o www.google.com"
alias diskspace="du | sort -n -r | more"
alias hiddenoff="defaults write com.apple.Finder AppleShowAllFiles FALSE; killall Finder"
alias hiddenon="defaults write com.apple.Finder AppleShowAllFiles TRUE; killall Finder"
alias ipaddress="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | tail -n 1 | sed 's/.*inet \([^ ]*\) .*/\1/'"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias thachi="osascript -e 'tell app \"System Events\" to sleep'"
alias sublime="open -a \"Sublime Text\""
alias subl="sublime"
alias preview="open -a \"Preview\""
alias atom="open -a \"Atom\""

set -o vi
set -o allexport

export EDITOR=vim
SERVER_CS61B="cs61b-acx@torus.cs.berkeley.edu"
SERVER_CS70="cs70-jd@torus.cs.berkeley.edu"
SERVER_CS188="cs188-fy@torus.cs.berkeley.edu"
SERVER_CS170="cs170-wj@torus.cs.berkeley.edu"

function update_bash(){
    cp -r ~/.vim ~/desktop/projects/Bash-setup
    cp .vimrc ~/desktop/projects/Bash-setup
    cp .viminfo ~/desktop/projects/Bash-setup
    cp .bashrc ~/desktop/projects/Bash-setup
}

function latex(){
	pdflatex --file-line-error --synctex=1 $1
	preview ${1%.tex}.pdf
}

#### BERKELEY CS CLASSES #####

# shortcut for automatically navigating to various directories
function goto(){
    [[ -z "$1" ]] && echo "$0: missing argument"
    if [ "$1" == "interview" ]; then
        cd ~/desktop/interview
    fi
    if [ "$1" == "cs61b" ]; then
        cd ~/desktop/school/Spring-2014/CS61B
    fi
    if [ "$1" == "cs70" ]; then
        cd ~/desktop/school/Spring-2014/CS70
    fi
    if [ "$1" == "bash" ]; then
        cd ~/desktop/projects/Bash-setup
    fi
    if [ "$1" == "projects" ]; then
        cd ~/desktop/projects
    fi
    if [ "$1" == "footprintz" ]; then
        cd ~/desktop/projects/footprintz
    fi
    if [ "$1" == "scheduler" ]; then
        cd ~/Desktop/projects/Scheduler
    fi
    if [ "$1" == "school" ]; then
        cd ~/Desktop/school/Spring-2016
    fi
    if [ "$1" == "mcb" ]; then
        cd ~/Desktop/school/Fall-2014/Mcb100A
    fi
    if [ "$1" == "170" ]; then
        cd ~/Desktop/school/Fall-2014/CS170
    fi
    if [ "$1" == "188" ]; then
        cd ~/Desktop/school/Fall-2014/CS188
    fi
    if [ "$1" == "174" ]; then
        cd ~/Desktop/school/Spring-2015/CS174
    fi
    if [ "$1" == "189" ]; then
        cd ~/Desktop/school/Spring-2015/CS189
    fi
    if [ "$1" == "102" ]; then
        cd ~/Desktop/school/Spring-2015/MCB102
    fi
    if [ "$1" == "104" ]; then
        cd ~/Desktop/school/Spring-2015/MCB104
    fi
    if [ "$1" == "168" ]; then
        cd ~/Desktop/school/Fall-2015/CS168
    fi
    if [ "$1" == "176" ]; then
        cd ~/Desktop/school/Fall-2015/CS176
    fi
    if [ "$1" == "160" ]; then
        cd ~/Desktop/school/Fall-2015/MCB160
    fi
    if [ "$1" == "186" ]; then
        cd ~/Desktop/School/Spring-2016/CS186
    fi
    if [ "$1" == "16a" ]; then
        cd ~/Desktop/School/Spring-2016/EE16A
    fi
    if [ "$1" == "161" ]; then
        cd ~/Desktop/School/Spring-2016/MCB161
    fi
    if [ "$1" == "160l" ]; then
        cd ~/Desktop/School/Spring-2016/MCB160L
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
    if [ "$1" == "cs170" ]; then
        echo "logging into cs170-wj"
        ssh $SERVER_CS170
    fi
    if [ "$1" == "cs188" ]; then
        echo "logging into cs188-fy"
        ssh $SERVER_CS188
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

function test_pj2(){
    javac */*.java
    java player/Tester
}

### GIT ###
alias gps="git push"
alias gpu="git pull"
alias gs="git status"
alias gl="git log"
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gcamend="git commit --amend"
alias gch="git checkout"
alias gcl="git clone"
alias ga="git add"
alias gai="git add -i"
alias gr="git rm --cached"
alias gb="git branch"
alias gd="git diff"
alias gh="git help"
alias gm="git merge"
alias gstash="git stash"
alias pull="git submodule update && git pull"

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

### Google App Engine ###
function deploy()
{
    appcfg.py --oauth2 -A $1 update $2
}

## CS 168 ##
function create()
{
    dd if=/dev/zero of=$1 bs=$2 count=1
}
alias syncvm="scp *.py *.conf cs168@172.16.122.2:~/public/"


### GradeTracker ###
alias gt="javac GradeTracker.java; java GradeTracker"


### CS 186 ###
alias update="git pull course master"

function grade()
{
    [[ -z "$1" ]] && echo "$0: missing argument" && exit 1
    git push origin "master:ag/$1"
}

function submit()
{
    [[ -z "$1" ]] && echo "$0: missing argument" && exit 1
    git push origin "master:release/$1"
}

function testhw5()
{
    scp part2test.py cs186:~/acz/hw5/
    scp hw5_sol.py cs186:~/acz/hw5/
    ssh cs186 "cd hw5; python part2test.py"
}

JUPYTERPORT=16078
alias 186ipy="ssh -L $JUPYTERPORT:localhost:$JUPYTERPORT cs186"

### EE16A ###
function copyhw()
{
    ssh ee16a "mkdir ~/hw//hw$1"
    scp hw$1.ipynb hw$1.pdf hw$1_grades.txt ee16a:~/hw/hw$1/
    ssh ee16a
}

