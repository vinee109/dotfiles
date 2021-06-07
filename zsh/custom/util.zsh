# ================================================================================
# UTILITIES
#
# Functions meant to simplify repetitive commands
# ================================================================================

# **************************************************************
# Converts a Quicktime .mov file to a .gif with the same name
#
# Example Usages:
#    togif file.mov
# **************************************************************

togif() {
    [[ -z "$1" ]] && echo "$0: missing argument"
    SIZE=$(ffprobe -v quiet -print_format json -show_streams $1 | jq '.streams[0] | "\(.width)x\(.height)"')
    SIZE=$(sed -e 's/^"//' -e 's/"$//' <<< $SIZE)  # Remove leading and trailing quotes
    ffmpeg -i $1 -s $SIZE -pix_fmt rgb24 -r 5 -f gif - | gifsicle --optimize=3 --delay=40 > ${1%.*}.gif
}

# **************************************************************
# Converts a Quicktime .mov file to a .mp4 with the same name
#
# Example Usages:
#    tomp4 file.mov
# **************************************************************

tomp4() {
    [[ -z "$1" ]] && echo "$0: missing argument"
    ffmpeg -i $1 -vcodec h264 -acodec aac -strict -2 ${1%.*}.mp4
}

# Acts just like cd but if env/bin/activate exists (python virtual environment)
# then it will automatically be activated
cdenv(){
    'cd' $@
    if [ -e "env/bin/activate" ]
    then
        source env/bin/activate
    fi
}

# Print all the supported colors
colors() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
  done
}

# ================================================================================
# GIT
#
# Functions meant to simplify and combine common git operations
# ================================================================================

amend() {
    git add $@
    git commit --amend
}

revert() {
    HASH=$(git rev-parse --short $1)
    echo "Creating branch revert-$HASH"
    git checkout master
    git pull
    git checkout -b revert-$HASH
    git revert $HASH
    fab test
}

pushbranch() {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git push origin $BRANCH
}

pullbranch() {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $BRANCH
}


