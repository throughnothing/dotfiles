#!/bin/bash
INSTALLDIR=${INSTALLDIR:-~/.dotfiles}
PRIVATE_INSTALLDIR=${PRIVATE_INSTALLDIR:-~/.dotfiles-private}
PRIVATE_GIT_URL=${PRIVATE_GIT_URL:-keybase://private/throughnothing/dotfiles-private}
PGP_KEY_URL=${PGP_KEY_URL:-https://willwolf.me/williamwolf.asc}

function install_dotfiles_symlinks {
  read -p "Would you like to install your dotfiles symlinks? (y/n): " yesno
  if [ $yesno == "y" ] || [ $yesno == "Y" ]; then
    echo "Setting up dotfiles symlinks..."
    ./install-symlinks
  fi
}

function install_homebrew_packages {
  read -p "Would you like to install your Homebrew Packages? (y/n): " yesno
  if [ $yesno == "y" ] || [ $yesno == "Y" ]; then
    echo "Installing from Brewfile..."
    brew bundle
    read -p "Done. You should now setup Keybase, 1Password, etc." empty
  fi
}

function import_gpg_key {
  read -p "Would you like to import your public gpg key? (y/n): " yesno
  if [ $yesno == "y" ] || [ $yesno == "Y" ]; then
    curl -sSL $PGP_KEY_URL | gpg --import -
    echo "Imported GPG Key."
  fi
}

function setup_private_dotfiles {
  function _install_symlinks {
    read -p "Would you like to install your private-dotfiles symlinks? (y/n): " yesno
    if [ $yesno == "y" ] || [ $yesno == "Y" ]; then
        pushd $PRIVATE_INSTALLDIR >> /dev/null
        # Use install-symlinks from .dotfiles repo
        $INSTALLDIR/install-symlinks
        popd >> /dev/null
    fi
  }

  if [ -e "$PRIVATE_INSTALLDIR" ]; then
    echo "~/.dotfiles-private already exists!";
    _install_symlinks
  else
    read -p "Would you like to setup private dotfiles? Note that you'll need to have keybase setup and configured first. (y/n): " yesno
    if [ $yesno == "y" ] || [ $yesno == "Y" ]; then
      echo "Setting up private dotfiles..."
      mkdir -p $PRIVATE_INSTALLDIR && pushd $PRIVATE_INSTALLDIR >> /dev/null
      git clone $PRIVATE_GIT_URL .
      popd >> /dev/null

      _install_symlinks
    fi
  fi
}

function main {
  pushd $INSTALLDIR >> /dev/null

  # Check for perl
  which perl >> /dev/null
  if [ "$?" -eq "1" ]; then echo "Need Perl!"; exit 1; fi

  install_dotfiles_symlinks
  install_homebrew_packages

  # Check for gpg
  which gpg >> /dev/null
  if [ "$?" -eq "1" ]; then
    echo "No GPG detected, skipping key and private dotfiles setup"
  else
    import_gpg_key
    setup_private_dotfiles
  fi

}

main;
