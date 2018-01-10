#!/bin/sh

# aliases
alias clip=pbcopy

tabs -8

export EDITOR=vim

# add ~/bin to path
PATH=$PATH:~/bin
export PATH

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
