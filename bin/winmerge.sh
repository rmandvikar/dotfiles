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

# add readonly switches for generated temp files
# 	generated files are created in %temp% dir (/tmp)
if test -f /tmp/"$(bn $1)"; then
	readonly="$readonly -wl"
fi
if test -f /tmp/"$(bn $2)"; then
	readonly="$readonly -wr"
fi

if [ "$1" == "$NULL" ]; then
	# echo "added"
	"$difftool" -e -u -wl $readonly -dl "(empty)" "$empty" "$2"
elif [ "$2" == "$NULL" ]; then
	# echo 'removed'
	"$difftool" -e -u -wr $readonly -dr "(empty)" "$1" "$empty"
else
	# echo 'modified'
	"$difftool" -e -u     $readonly               "$1" "$2"
fi

# switches:
# -e	Esc to exit
# -u	Don't add any path to MRU
# -wl	left side readonly
# -wr	right side readonly
# -dl	description for left side
# -dr	description for right side
