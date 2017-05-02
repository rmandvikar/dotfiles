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
diff-gc() {
	difftool="WinMergeU"
	"$difftool" -e -u "$HOME/.gitconfig" "$HOME/.gitconfig.gist" &
}

alias g=git
alias gti=git
alias gt=git
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"

tabs 4
