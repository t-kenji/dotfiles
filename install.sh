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

replace file ~/.gitconfig gitconfig
replace file ~/.vimrc vimrc