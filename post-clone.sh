#!/bin/bash

INSTALLDIR=${INSTALLDIR:-~/.dotfiles}
PRIVATE_INSTALLDIR=${PRIVATE_INSTALLDIR:-~/.dotfiles-private}
PRIVATE_GIT_URL=${PRIVATE_GIT_URL:-keybase://private/throughnothing/dotfiles-private}
PGP_KEY_URL=${PGP_KEY_URL:-https://willwolf.me/williamwolf.asc}
PGP_KEY_URL_PC=${PGP_KEY_URL_PC:-https://willwolf.me/williamwolf-polychain.asc}

# question_string, function_to_run
function ask {
  # Discard Any keystrokes from a prior task
  read -t 1 -n 10000 discard 

  read -p "$1 (y/n): " yesno
  if [ "$yesno" == "y" ] || [ "$yesno" == "Y" ]; then $2; fi
}

# command_name, function_to_run
function has_cmd {
  which $1 >> /dev/null
  if [ "$?" -eq "1" ]; then echo "No $1 found. Skipping steps that require it."; else $2; fi
}

function install_dotfiles_symlinks {
  echo "Setting up dotfiles symlinks..."
  ./install-symlinks
}

function install_homebrew_packages {
  echo "Installing from Brewfile..."
  brew bundle

  echo "Setting homebrew to autoupdate + upgrade every 24 hours..."
  brew autoupdate --start --upgrade

  # Discard anything that was typed during the above
  read -t 1 -n 10000 discard 
  read -p "Done. You should now setup Keybase, 1Password, GPG, etc." empty
}

function import_gpg_key {
  function _do {
    curl -sSL $PGP_KEY_URL | gpg --import -
    echo "Imported Personal GPG Key."

    curl -sSL $PGP_KEY_URL_PC | gpg --import -
    echo "Imported Polychain GPG Key."
  }
  ask "Would you like to import your public gpg key?" _do
}

function setup_private_dotfiles {
  function _install_symlinks {
    function _do {
      pushd $PRIVATE_INSTALLDIR >> /dev/null
      # Use install-symlinks from .dotfiles repo
      $INSTALLDIR/install-symlinks
      popd >> /dev/null
    }
    ask "Would you like to install your private-dotfiles symlinks?" _do
  }

  function _do {
    if [ -e "$PRIVATE_INSTALLDIR" ]; then
      echo "~/.dotfiles-private already exists!";
      _install_symlinks
    else
      echo "Setting up private dotfiles at $PRIVATE_INSTALLDIR..."
      mkdir -p $PRIVATE_INSTALLDIR
      pushd $PRIVATE_INSTALLDIR >> /dev/null
      git clone $PRIVATE_GIT_URL .
      popd >> /dev/null

      _install_symlinks
    fi
  }

  ask "Would you like to setup private dotfiles? Note that you'll need to have keybase setup and configured first." \
    _do
}

function main {
  pushd $INSTALLDIR >> /dev/null

  # Check for perl
  which perl >> /dev/null
  if [ "$?" -eq "1" ]; then echo "Need Perl!"; exit 1; fi

  echo -n "Installing git hooks..."
  cp git-hooks/* .git/hooks/
  echo "Done."

  ask "Would you like to install your dotfiles symlinks?" \
    install_dotfiles_symlinks
  ask "Would you like to install your Homebrew Packages?" \
    install_homebrew_packages

  function _do_gpg {
    import_gpg_key
    setup_private_dotfiles
  }
  has_cmd "gpg" _do_gpg

  popd >> /dev/null

  echo "All Done!"
}

main
