#!/bin/sh

gc() {
	git config --gl -e &
}
c() {
	git config --lo -e &
}

alias s=o

alias g=git
alias gti=git
alias gt=git
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"

alias jira=jq

tabs 4

# scite is on path
export EDITOR=scite # '/d/setups/wscite/SciTE.exe'

export GIT_MERGE_AUTOEDIT=no
