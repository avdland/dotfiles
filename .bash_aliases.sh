#!/bin/bash

alias lla='ll -a'
alias cdp='cd ~/projects'
alias dps="docker ps | awk '{print \$NF}'"

cd_gitroot()
{
  local cnt=0

  while [[ "$PWD" != "/" ]]; do
    if [[ ! -d .git ]]; then
      pushd .. &> /dev/null
      cnt=$((cnt+1))
      continue
    else
      return 0
    fi
  done

  if [[ "$PWD" == "/" ]]; then
    while [[ $cnt > 0 ]]; do
      popd &> /dev/null
      cnt=$((cnt-1))
    done
    return 1
  fi
}

git_pull_develop()
{
  for dir in $(find . -maxdepth 1 -type d)
  do
    ( [ ${#dir} -lt 3 ] || [ ${dir:0:3} == "./." ] ) && continue || true
    echo "$dir"
    pushd $dir &> /dev/null

    if [ ! -d .git ]; then
      popd &> /dev/null
      continue
    fi

    BRANCH=`git branch | grep \* | cut -d ' ' -f2`
    if [ "$BRANCH" != "develop" ]; then
      git checkout develop
    fi

    HAS_CHANGES=`git diff-index --name-only HEAD --`
    if [ -n "$HAS_CHANGES" ]; then
      git stash
    fi

    git pull --rebase

    if [ -n "$HAS_CHANGES" ]; then
      git stash pop
    fi

    popd &> /dev/null
  done

  echo "Finished successfully"
}

alias cdr=cd_gitroot
alias gpd=git_pull_develop
