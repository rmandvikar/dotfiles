#!/bin/sh

# aliases
alias clip=pbcopy
alias o=vim
alias ls="ls -1"

tabs -4

export EDITOR=vim

# add ~/bin to path
PATH=$PATH:~/bin
export PATH

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
