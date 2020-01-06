#!/bin/bash
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the branch/status of the current git repository
#
# USAGE:
#
#   1. Save this file as ~/.git_prompt.sh
#   2. Add the following line to the end of your ~/.profile or ~/.bash_profile:
#        . ~/.git_prompt.sh
#   3. Alternatively you can just make a symbolic link to this profile
#   4. Finally just run install.sh and it will add a symbolic link for you
#
# AUTHOR:
#
#   Shane K. Panter
#   Boise State
#
#   Based on work by halbtuerke and lakiolen and scott woods
#   Shane- Removed .svn integration it is too slow....
#
# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}


# WAY TOO SLOW!! Execute "git fetch" command to update local history.
#function update_local_history {
#  git fetch > /dev/null 2>&1
#}

# Determine the branch/state information for this git repository.
function set_git_prompt {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="(.*)Your branch is (.*) '"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[2]} == "ahead of" ]]; then
      remote="↑"
    elif [[ ${BASH_REMATCH[2]} == "behind" ]]; then
      remote="↓"
    else # sometimes it says up-to-date with, so we don't want an arrow
      remote=""
    fi
  else
    remote=""
  fi
  diverge_pattern="(# |)Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  else
    branch="error_check_bash_script"
  fi

  # Set the final branch string.
  BRANCH="${state}(${branch})${remote}${COLOR_NONE}"
}


# Set the full bash prompt.
function set_bash_prompt () {

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_prompt
  else
    BRANCH=''
  fi

  # Set the bash prompt variable.
  PS1="[\u@\h \W${BRANCH}]\$ "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
