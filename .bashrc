# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# green="\[\033[0;32m\]"
# cyan="\[\033[0;36m\]"
# purple="\[\e[1;38;5;57m\]"
# white="\[\033[00m\]"
# bgreen="\[\033[1;32m\]"
# bred="\[\033[1;31m\]"

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
RoyalBlue='\[\e[1;38;5;57m\]'

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

#PS1="$cyan\t: $green\w \$ $white"

export PS1="$Cyan\t: $RoyalBlue\w $White"'$(git rev-parse &>/dev/null; \
if [ $? -eq 0 ]; then \
    echo -n "$(git diff --quiet ; \
    if [ $? -eq 0 ]; then \
        echo "'$BGreen'($(git symbolic-ref --short -q HEAD))'$White'"; \
    else \
        echo "'$BRed'{$(git symbolic-ref --short -q HEAD)}'$White'" ;\
    fi) " ; \
fi ; \
echo "'$RoyalBlue'\$ '$White'")'



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

set -o vi
set -o allexport

export EDITOR=vim
SERVER_CS61B="cs61b-acx@torus.cs.berkeley.edu"
SERVER_CS70="cs70-jd@torus.cs.berkeley.edu"
SERVER_CS188="cs188-fy@torus.cs.berkeley.edu"
SERVER_CS170="cs170-wj@torus.cs.berkeley.edu"

function update_bash(){
    'cp' -rf ~/.vim ~/desktop/projects/Bash-setup
    'cp' -f .vimrc ~/desktop/projects/Bash-setup
    'cp' -f .viminfo ~/desktop/projects/Bash-setup
    'cp' -f .bashrc ~/desktop/projects/Bash-setup
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
        cd ~/Desktop/school
    fi
    if [ "$1" == "mcb" ]; then
        cd ~/Desktop/school/Fall_2014/Mcb100A
    fi
    if [ "$1" == "170" ]; then
        cd ~/Desktop/school/Fall_2014/CS170
    fi
    if [ "$1" == "188" ]; then
        cd ~/Desktop/school/Fall_2014/CS188
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
