#!/bin/sh

if [ -f ~/.profile ]; then
	source ~/.profile
fi

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ -f ~/git-prompt.sh ]; then
	source ~/git-prompt.sh
fi

# call setup
setup --quiet
