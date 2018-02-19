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
alias la='ls -A'   # list almost all horizontally (except . and ..)
alias l='ls -CF'    # list entries by columns
alias lla='ls -lA'

# Pacman
alias pacupg='pacman -Syu'            # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacupd='pacman -Sy'             # Refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacin='pacman -S'               # Install specific package(s) from the repositories
alias pacinu='pacman -U'              # Install specific local package(s)
alias pacre='pacman -R'               # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacun='pacman -Rcsn'            # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinfo='pacman -Si'            # Display information about a given package in the repositories
alias pacse='pacman -Ss'              # Search for package(s) in the repositories

cd_func() {
  case $# in
    0)
      cd
      ;;
    1)
      cd "$1"
      ;;
    2)
      cd "$1/$2"
      ;;
  esac
}

alias cd='cd_func'
alias cdd="cd /c/Users/$USER/Downloads"
alias cdp='cd /c/projects'

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
export PS1='\[\033[0;33m\]\w\[\033[0;32m\]`git_branch`\[\033[0m\]\n\$ '
