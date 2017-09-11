# Default to human readable figures
alias df='df -h'
alias du='du -h'                                                                              

# Misc
alias less='less -r' # output "raw" control characters
alias whence='type -a' # show all
alias vi='vim'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
 
# Some shortcuts for different directory listings
alias ls='ls -hF --color=auto' # human readable, append indicator (*/=>@|)
alias ll='ls -l'   # vertical list
alias lla='ls -al' # list all vertically
alias la='ls -A'   # list almost all horizontally (except . and ..)
alias l='ls -C'    # list entries by columns

# command line copy 2 web
function copy2web() {
  if [[ $# -ne 1 ]]; then
    echo "usage: c2w <filename>"
    exit 1
  fi
  if [[ ! -r "$1" ]]; then
    echo "file doesn't exist or isn't readable"
    exit 1
  fi
  cat $1 | curl -F 'sprunge=<-' http://sprunge.us
}

alias c2w='copy2web'

# Pacman
alias pacupg='pacman -Syu'            # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacupd='pacman -Sy'             # Refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacin='pacman -S'               # Install specific package(s) from the repositories
alias pacinu='pacman -U'              # Install specific local package(s)
alias pacre='pacman -R'               # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacun='pacman -Rcsn'            # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinfo='pacman -Si'            # Display information about a given package in the repositories
alias pacse='pacman -Ss'              # Search for package(s) in the repositories
