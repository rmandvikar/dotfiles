#!/bin/sh

# aliases
alias g=git
alias gti=git
alias gt=git

tabs 4

# colors
export     White='\033[1;37m'
export    Yellow='\033[1;33m'
export       Red='\033[0;31m'
export    Prompt='\033[38;2;255;136;255m'
export      None='\033[0m' 		# No Color

case "$OSTYPE" in
	linux*)
		if [ -f ~/.bashrc.linux.bashrc ]; then
			source ~/.bashrc.linux.bashrc
		fi ;;
	msys*)
		if [ -f ~/.bashrc.windows.bashrc ]; then
			source ~/.bashrc.windows.bashrc
		fi ;;
	darwin*)
		if [ -f ~/.bashrc.mac.bashrc ]; then
			source ~/.bashrc.mac.bashrc
		fi ;;
esac

if [ -f ~/.bashrc.work.bashrc ]; then
	source ~/.bashrc.work.bashrc
fi

if [ -f ~/.bashrc.local.bashrc ]; then
	source ~/.bashrc.local.bashrc
fi
