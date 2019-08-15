#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias lt='ts -lt'

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_GREEN
  elif [[ $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_YELLOW
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_status {
  local git_status="$(git status 2> /dev/null)"
  local staged_changes=""
  local unstaged_changes=""

  if [[ $git_status =~ "Changes not staged for commit" ]]; then
    unstaged_changes="•"
  fi
  if [[ $git_status =~ "Changes to be committed" ]]; then
    staged_changes="+"
  fi
  echo "$staged_changes$unstaged_changes"
}


PS1="\[$COLOR_WHITE\]\n[\u@\h \w]"          # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="(\$(git_branch)\$(git_status))"           # prints current branch
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1

#PS1='[\u@\h \W]\$ '
