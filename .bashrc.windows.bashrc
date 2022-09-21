#!/bin/sh

# aliases
alias s=o
alias msbuild="'/c/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe'"
alias jira=jiraq
alias python='winpty python.exe'
alias c=clip
alias v=vlip
alias wp=winpath
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
guidgen() { "guidgen.exe" "$@"; }
export -f guidgen

md5() { "md5sum.exe" "$@" | sed 's, .*,,'; }
export -f md5
sha1() { "sha1sum.exe" "$@" | sed 's, .*,,'; }
export -f sha1
sha256() { "sha256sum.exe" "$@" | sed 's, .*,,'; }
export -f sha256
xxh() { "xxhsum.exe" "$@" | sed 's, .*,,'; }
export -f xxh
xxh32() { "xxh32sum.exe" "$@" | sed 's, .*,,'; }
export -f xxh32
xxh64() { "xxh64sum.exe" "$@" | sed 's, .*,,'; }
export -f xxh64
xxh128() { "xxh128sum.exe" "$@" | sed 's, .*,,'; }
export -f xxh128

# WinMergeU is on path
difftool() { "WinMergeU" -e -u "$@"; }
export -f difftool
alias dt=difftool

# scite is on path
export EDITOR=scite # '/d/setups/wscite/SciTE.exe'

# use unicode (utf8)
#	see https://stackoverflow.com/questions/29279304/git-bash-chcp-windows7-encoding-issue
chcp.com 65001 1>/dev/null

# jq colors
export FIELD_COLOR="34;1"
#export JQ_COLORS="1;30:0;37:0;37:0;37:0;32:1;37:1;37"
#                  null fals true numb stri arra obje
#                  b bl ? ?? ? ?? ? ?? ? gr b ?? b ??
 export JQ_COLORS="1;30:5;36:1;36:0;35:0;32:1;37:1;37"
