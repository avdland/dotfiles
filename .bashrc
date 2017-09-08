# Default to human readable figures
alias df='df -h'
alias du='du -h'                                                                              

# Misc
alias less='less -r'
alias whence='type -a'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
 
# Some shortcuts for different directory listings
alias ls='ls -hF --color=auto'
alias ll='ls -lF'
alias lla='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# command line copy 2 web
copy2web() {
  if [ $# -ne 1]; then
    echo 'usage: c2w <filename>'
    exit 1
  fi
  if [ ! -r $1 ]; then
    echo 'file doesn\'t exist or isn\'t readable'
    exit 1
  fi
  cat $1 | curl -F 'sprunge=<-' http://sprunge.us
}

alias c2w=copy2web
