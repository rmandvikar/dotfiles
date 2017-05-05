#!/bin/sh

# I want to keep THEIR version when there is a conflict
# Copy their version over ours
cp -f $3 $2
# exit 0 will cause the merge to succeed
exit 1
