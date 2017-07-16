#!/bin/sh

# aliases
alias s=o
alias g=git
alias gti=git
alias gt=git
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"
alias jira=jq

tabs 4
# scite is on path
export EDITOR=scite # '/d/setups/wscite/SciTE.exe'

# git env
export GIT_MERGE_AUTOEDIT=no

# colors
export     White='\033[1;37m'
export    Yellow='\033[1;33m'
export       Red='\033[0;31m'
export    Prompt='\033[38;2;255;136;255m'
export      None='\033[0m' 		# No Color
