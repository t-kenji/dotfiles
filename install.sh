#!/bin/bash

ENTDIR=$(cd $(dirname $0); pwd)

replace() {
    if [ -e "$1" ]; then
        rm -rf $1
    fi
    ln -sf $ENTDIR/$2 $1
}

replace ~/.vimrc vimrc
