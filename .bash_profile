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

if [ -f ~/work.bashrc ]; then
	source ~/work.bashrc
fi

#~ if [ -f ~/git-completion.bash ]; then
	#~ source ~/git-completion.bash
#~ fi

