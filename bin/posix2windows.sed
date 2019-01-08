#!/bin/sed -Ef

#usage:
#   posix2windows.sed <<< "<path>"
#   ... | posix2windows.sed
#
# Convert POSIX paths to windows.

# note: moved from script 'bin/e'

# convert /c/ to /c:/ to c:/ to c:\
#   drive letter can be multiple chars
# convert some/dir/ to some\dir\
#
# see Patterns, http://www.grymoire.com/Unix/Sed.html#uh-27
# example: sed '\,^#, s/[0-9][0-9]*//'

# remove leading "
s,^",,
# remove trailing "
s,"$,,
# ensure 2nd / is present at end for special case "/c"
\,^/[^/]+$, s,$,/,
# if starting with / and no :/, replace the 2nd / with :/
\,^/[^:]+/, s,/,:/,2
# remove leading /
s,^/,,
# replace all / with \
s,/,\\,g
