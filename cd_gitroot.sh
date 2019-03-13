#!/bin/bash

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

alias cdr=cd_gitroot
