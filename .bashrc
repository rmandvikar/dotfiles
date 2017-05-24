#!/bin/sh

function @b() {
	git rev-parse --abbrev-ref HEAD;
}
function @u() {
	git rev-parse --abbrev-ref HEAD@{u};
}
function @() {
	echo $1@{u};
}
function up() {
	@ $*;
}

gc() {
	git config --gl -e &
}
c() {
	git config --lo -e &
}

remote() {
	git config --get-regex remote\..*\.url \
		| cut -d' ' -f2 \
		| sed 's/\.git$//g' | sed 's/^git@//' \
		| sed 's/^https\?:\/\///' | sed 's/:/\//' \
		| xargs start chrome --new-window
}

alias s=o

alias g=git
alias gti=git
alias gt=git
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"

alias jira=jq

tabs 4

export GIT_MERGE_AUTOEDIT=no
