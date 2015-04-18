#!/bin/bash
# Credits:
# - https://github.com/mahmoudimus/dotfiles/blob/master/setup.sh

set -e

# Log <type> <msg>
log() {
  printf "  \033[36m%10s\033[0m : \033[90m%s\033[0m\n" $1 $2
}

# Begin Setup

log 'Installing' 'Ansible'

# prefer pip for installing python packages over the older easy_install
#
if [[ ! -x `which pip` ]]; then
    sudo easy_install pip
fi

if [[ -x `which pip` && ! -x `which ansible` ]]; then
    sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments \
   pip install ansible
fi


#
# Mac OSX Only
#

# Install xcode
function install_xcode() {
  if [[ ! -x /usr/bin/xcode-select ]]; then
      if [[ ! -d "/Applications/Xcode.app" ]]; then
    log install "Xcode.app"
    open "macappstore://itunes.apple.com/cn/app/id497799835"
      fi
      exit 1
  fi

  if [[ ! -x /usr/bin/gcc ]]; then
    log install "command line tools"
    xcode-select --install
    exit 1
  fi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    install_xcode
    # Install homebrew
    if [[ ! -x `which brew` ]]; then
      log "Installing Homebrew"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      log "Homebrew already installed."
    fi
    # Install brew-bundle https://github.com/Homebrew/homebrew-bundle
    log "Installing Homebrew-Bundle + Apps"
    brew tap Homebrew/bundle
    brew bundle
fi

./install-symlinks
