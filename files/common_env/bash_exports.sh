export EDITOR="vim"

export GOPATH="/Users/throughnothing/Projects/go"

# NOPASTE
export NOPASTE_SERVICES=Dancebin
# APP::NOTES
export APP_NOTES_AUTOSYNC=0

# PATHS
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules:/usr/local/share/npm/lib/node_modules
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.scripts:/var/lib/gems/1.8/bin:/usr/local/share/npm/bin"


# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:ignorespace
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# Haskell .app
# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi
