alias lla='ls -lah'

alias cdp='cd ~/projects'
alias cdd='cd ~/Downloads'

alias dps="docker ps | awk '{print \$NF'"
alias ff="find . -name $1"
alias mcp='mvn clean package -DskipTests'

alias grc='git reset --hard && git clean -f -d'
alias gca='git commit --amend --no-edit'

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
alias cdgr=cd_gitroot

alias k=kubectl
complete -o default -F __start_kubectl k

alias kn=kubens
alias kx=kubectx
alias kdp='kubectl describe pod'
alias kgp='kubectl get pod'
alias kgpvc='kubectl get pvc'
alias keti='kubectl exec -ti'
