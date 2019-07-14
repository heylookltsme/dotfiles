# Diffs all the local dotfiles with the dotfiles from the repo so you can see
# what will change when you run ./bootstrap.sh
#
# You can diff everything with `./diff.sh` or a single file with
# `./diff [filenname]

function diff_file() {
    file=$1
    local_file="$HOME/$1"
    if [ -f "$local_file" ]; then
        git --no-pager diff --no-index $local_file $file
        diff=$(git --no-pager diff --no-index $local_file $file)
        if [ ! -z "$diff" ]; then
            echo "\n---\n"
        fi
    fi
}

if [ ! -z "$1" ]; then
    diff_file $1
else
    dotfiles=$(\ls -d .?*)
    for file in $dotfiles; do
        diff_file $file
    done;
fi
