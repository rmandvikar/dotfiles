#!/bin/sh

# aliases
alias gti=git
alias gt=git
alias a=app
alias g=grep
alias gi="grep -i"
alias eg=egrep
alias egi="egrep -i"
alias ge=egrep
alias gei="egrep -i"
alias ..="cd .."
alias ....="cd ../.."
alias ap=abspath
alias rp=relpath
# bfg.jar is at ~/dump/
alias bfg="java -jar ~/dump/bfg.jar"
alias  pr="remote --pr"
alias prs="remote --prs"
alias branch="git branch-name"
alias     _b="git branch-name"
alias npv=nuget-package-version
alias web=www

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
