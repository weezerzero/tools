#!/bin/bash

# create a link to the file in this directory so we don't
# have to re-copy if the file changes
if [ -e ~/.git_prompt.sh ]
then
	rm -f ~/.git_prompt.sh
fi
echo "Creating symbolic link to git_prompt.sh in home directory."
ln -s $PWD/git_prompt.sh ~/.git_prompt.sh

# append script to ~/.bashrc so it launches when the shell launches.
# only do this if it isn't already in bashrc
if ! grep -Fxq ". ~/.git_prompt.sh" ~/.bash_profile
then
	echo "Appending git_prompt.sh to ~/.bash_profile..."
	echo ". ~/.git_prompt.sh" >> ~/.bash_profile
fi

# exec bashrc to refresh
exec bash
echo "Install complete."
