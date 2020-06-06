# For GPG SSH Agent, for Yubikey / Smart Cards
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
gpg-connect-agent updatestartuptty /bye > /dev/null

# Editor for my blog posts
export BLOG_EDITOR="open -a typora"

# Set VI mode
bindkey -v
