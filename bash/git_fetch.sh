#!/bin/bash

#Find all the repos that are checkout to your home folder
#and run git fetch on them. git fetch will not modify 
#your working copy just download anything new.

#logs a message to stdout. The log file name is set in the 
#crontab entry
function log {
    echo "[`date`] $1"
}

#Run git fetch on each repo that was found (recursively)
#from the given start directory (arg 1)
function update_repos {
    log "START: update_repos in $1"
    find $1 -name ".git" |
    while read repo
    do 
	cd $repo
	cd ..
	git fetch
	log "fetching $repo"
    done
    log "DONE: update_repos in $1"
}

WDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $WDIR/__git_fetch
log "################################"
log "DIRS: $DIRS"
for d in $DIRS
do
    update_repos $d
done



