#!/bin/sh

# aliases
alias g=git
alias gti=git
alias gt=git

tabs 4

# git env
export GIT_MERGE_AUTOEDIT=no

# colors
export     White='\033[1;37m'
export    Yellow='\033[1;33m'
export       Red='\033[0;31m'
export    Prompt='\033[38;2;255;136;255m'
export      None='\033[0m' 		# No Color

case "$OSTYPE" in
	linux*)
		if [ -f ~/linux.bashrc ]; then
			source ~/linux.bashrc
		fi ;;
	msys*)
		if [ -f ~/windows.bashrc ]; then
			source ~/windows.bashrc
		fi ;;
	darwin*)
		if [ -f ~/mac.bashrc ]; then
			source ~/mac.bashrc
		fi ;;
esac

if [ -f ~/work.bashrc ]; then
	source ~/work.bashrc
fi

if [ -f ~/local.bashrc ]; then
	source ~/local.bashrc
fi
