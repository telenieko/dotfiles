#!/bin/sh
# vim: foldmethod=marker 

help() {
    cat << EOF
usage: $0 options

This script installs (links) the specified dotfiles into
PREFIX (\$HOME by default).

OPTIONS:
  -h            Show this message
  -p PREFIX     PREFIX for install paths (\$HOME by default)
  -V            Install .vim files.
  -Z            Install zsh stuff.
EOF
}

# Default Values.
BASEPATH=`pwd`
PREFIX=$HOME
DOVIM=0
DOZSH=0

while getopts "hp:VZ" OPTION
do
    case $OPTION in
        h)
            help
            exit 1
            ;;
        p)
            PREFIX=$OPTARG
            ;;
        V)
            DOVIM=1
            ;;
        Z)
            DOZSH=1
            ;;
        ?)
            help
            exit 1
            ;;
    esac
done

echo "Installing dotfiles: BASEPATH=$BASEPATH PREFIX=$PREFIX"
echo -e "\tDOVIM=$DOVIM\tDOZSH=$DOZSH"

if [ $DOVIM -eq 1 ]; then
    echo "Installing VIM files."
    if [ -d $PREFIX/.vim ] && [ ! -h $PREFIX/.vim ]; then
        echo "$PREFIX/.vim is a directory, aborting!!"
        exit 1
    fi
    ln -nsf $BASEPATH/vim/ $PREFIX/.vim
fi
if [ $DOZSH -eq 1 ]; then
    echo "Installing ZSH files."
    if [ -d $PREFIX/.zsh ] && [ ! -h $PREFIX/.zsh ]; then
        echo "$PREFIX/.zsh is a directory, aborting!!"
        exit 1
    fi
    if [ -f $PREFIX/.zshrc ] && [ ! -h $PREFIX/.zshrc ]; then
        echo "$PREFIX/.zshrc is a file, aborting!!"
        exit 1
    fi
    ln -nsf $BASEPATH/zsh/ $PREFIX/.zsh
    ln -nsf $BASEPATH/zshrc $PREFIX/.zshrc
fi

