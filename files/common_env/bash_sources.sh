
source ~/.scripts/z.sh
source ~/.common_env/bash_exports.sh
source ~/.common_env/bash_funcs.sh
source ~/.common_env/alias.sh


## Github stuff if it exists
#[[ -f ~/.github ]] && source ~/.github

# Perlbrew stuff
#[[ -f ~/perl5/perlbrew/etc/bashrc ]] && source ~/perl5/perlbrew/etc/bashrc

# Load GPG Agent Exports
[[ -s "$HOME/.gpg-agent-info" ]] && source "$HOME/.gpg-agent-info"

# Load Sensitive
[[ -s "$HOME/.common_env/sensitive.sh" ]] && source "$HOME/.common_env/sensitive.sh"

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Load RVM functin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 2>&1 > /dev/null

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
