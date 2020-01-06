#!/bin/bash
echo "appending entry to your crontab"
tmp="$(crontab -l)"
if [ "$tmp" != "" ]
then
    #if there already an entry we need to add a new line.
    tmp="$tmp \n"
fi
echo -e "$tmp@hourly `pwd`/git_fetch.sh > $HOME/.logs/git_fetch.log 2>&1" | crontab
mkdir -p "$HOME/.logs"
echo "crontab now contains the following entries"
crontab -l
echo
echo "logs will be written to $HOME/.logs/git_fetch.log"
