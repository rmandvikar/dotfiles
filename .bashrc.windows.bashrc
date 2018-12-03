#!/bin/sh

# aliases
alias s=o
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"
alias jira=jiraq
alias python='winpty python.exe'
alias c=clip
alias v=vlip
# jq-win64 is on path
jq() { "jq-win64.exe" "$@"; } # '/d/setups/PATH/jq-win64.exe'
export -f jq
jp() { "jq-win64.exe" "$@"; }
export -f jp
# vlip is on path # '/d/setups/PATH/vlip.exe'
#   note:
#   paste.exe renamed to vlip.exe as gnu paste conflicts
#   see http://www.c3scripts.com/tutorials/msdos/paste.html
vlip() { echo "$(vlip.exe)"; }
export -f vlip
guidgen() { echo "$(guidgen.exe)"; }
export -f guidgen

# WinMergeU is on path
difftool() { "WinMergeU" -e -u "$@"; }
export -f difftool
alias dt=difftool

# scite is on path
export EDITOR=scite # '/d/setups/wscite/SciTE.exe'

# use unicode (utf8)
#	see https://stackoverflow.com/questions/29279304/git-bash-chcp-windows7-encoding-issue
chcp.com 65001 1>/dev/null
