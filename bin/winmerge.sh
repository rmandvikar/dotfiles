#!/bin/sh

# $LOCAL $REMOTE seem to be swapped
# $1 is $LOCAL
# $2 is $REMOTE
# echo "1: $1"
# echo "2: $2"
# echo "3: $3"

difftool="WinMergeU"
NULL="/dev/null"
empty="$HOME/winmerge.empty"

if [ "$1" == "$NULL" ]; then
	# echo "added"
	"$difftool" -e -u -wl "$empty" "$2"
elif [ "$2" == "$NULL" ]; then
	# echo 'removed'
	"$difftool" -e -u -wr "$1" "$empty"
else
	# echo 'modified'
	"$difftool" -e -u "$1" "$2"
fi

# switches:
# -e	Esc to exit
# -u	Don't add any path to MRU
# -wl	left side readonly
# -wr	right side readonly
