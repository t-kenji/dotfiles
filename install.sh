#!/bin/bash
set -eu

ENTDIR=$(cd $(dirname $0); pwd)

replace() {
    case "$1" in
    file) if [ -f "$2" ]; then rm -rf $2; fi ;;
    dir) if [ -d "$2" ]; then rm -rf $2; fi ;;
    esac
    ln -sf $ENTDIR/$3 $2
}

ALL=$(find . -type f -maxdepth 1 | sed -e 's/.\///' | grep -v 'install')
TARGETS=${@-all}
if [[ $TARGETS == all ]]; then
    TARGETS=$ALL
fi

for target in $TARGETS; do
    case $target in
    gitconfig)
        replace file ~/.gitconfig gitconfig
        ;;
    vimrc)
        replace file ~/.vimrc vimrc
        ;;
    tmux.conf)
        replace file ~/.tmux.conf tmux.conf
        ;;
    *)
        echo "unknown target: $target"
        ;;
    esac
done
