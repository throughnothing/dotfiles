# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export NOPASTE_SERVICES=Dancebin
export APP_NOTES_AUTOSYNC=0
NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups:ignorespace
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
shopt -s checkwinsize
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# =============================================================================
. ~/.scripts/z.sh
. ~/.alias
set -o vi

export ANT_HOME=/usr/local/ant
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.scripts:/var/lib/gems/1.8/bin"
export EDITOR="mvim -v"
export SVN_EDITOR="mvim -v"
export JAVA_HOME=$(/usr/libexec/java_home)
export GISTY_DIR="~/gists"

# Vi moed binding, remap C-c to C-x and make C-c exit insert mode
# http://stackoverflow.com/questions/3126453/bash-vi-mode-bind-c-c-to-escape-from-insert-mode
stty intr ^X
bind -m vi-insert C-c:vi-movement-mode

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

function num_git_commits_ahead {
    num=$(git status 2> /dev/null \
        | grep "Your branch is ahead of" \
        | awk '{split($0,a," "); print a[9];}' 2> /dev/null) || return
    [ "$num" ] && echo "+$num"
}

_go() {
  [ $# -eq 0 ] && return
  local default_path="${GO_DEFAULT_PATH:-$HOME/Projects}"

  for f in $(ls -a $HOME | sort); do
    echo $f | grep -qi "^$1"
    [ $? -eq 0 ] && pushd $HOME/$f >> /dev/null && return
  done
  for f in $(ls -a $default_path | sort); do
    echo $f | grep -qi "^$1"
    [ $? -eq 0 ] && pushd "$default_path/$f" >> /dev/null && return
  done
}

g(){
    local target=$(grep "^$1" $HOME/.go | head -1 | awk '{print $2}')
    [ "$target" ] && [ "$1" ] && pushd "$target" 2>&1 >> /dev/null && return

    z $* || _go $*
}


dfc() {
    pushd ~/.dotfiles >> /dev/null
    git add . && git add -u . && git commit -m "automated update"
    popd >> /dev/null
}

dfu() {
    pushd ~/.dotfiles >> /dev/null
    git stash && git pull && git stash pop
    popd >> /dev/null
}

#Git ProTip - Delete all local branches that have been merged into HEAD
git_purge_local_branches() {
  [ -z $1 ] && return
  #git branch -d `git branch --merged $1 | grep -v '^*' | grep -v 'master' | grep -v 'dev' | tr -d '\n'`
  BRANCHES=`git branch --merged $1 | grep -v '^*' | grep -v 'master' | grep -v 'dev' | grep -v "/$1$" | tr -d '\n'`
  echo "Running: git branch -d $BRANCHES"
  git branch -d $BRANCHES
}

#Bonus - Delete all remote branches that are merged into HEAD (thanks +Kyle Neath)
git_purge_remote_branches() {
  [ -z $1 ] && return
  git remote prune origin

  BRANCHES=`git branch -r --merged $1 | grep 'origin' | grep -v '/master$' | grep -v '/dev$' | grep -v "/$1$" | sed 's/origin\//:/g' | tr -d '\n'`
  echo "Running: git push origin $BRANCHES"
  git push origin $BRANCHES
}

git_purge() {
  branch=$1
  [ -z $branch ] && branch="dev"
  git_purge_local_branches $branch
  git_purge_remote_branches $branch
}

pullreq() {
  [ -z $BRANCH ] && BRANCH="dev"
  HEAD=$(git symbolic-ref HEAD 2> /dev/null)
  [ -z $HEAD ] && return # Return if no head
  # Try to find an upstream remote first
  REMOTE=`cat .git/config | grep "remote \"upstream\"" -A 2 | grep "url" | sed 's/.*\/github.com\/\([^\/]*\).*/\1/'`
  # If upstream remote wasn't found, use origin
  [ -z $REMOTE ] && REMOTE=`cat .git/config | grep "remote \"origin\"" -A 2 | grep "url" | sed 's/.*:\([^\/]*\).*/\1/'`

  CUR_BRANCH=${HEAD#refs/heads/}
  MSG=`git log -n1 --pretty=%s`
  git push origin $CUR_BRANCH

  hub pull-request -b $BRANCH -h $REMOTE:$CUR_BRANCH
}

opullreq() {
    open $(BRANCH=$BRANCH pullreq $1)
}

sshc() {
    ssh -t bastion1 "ssh -t $1";
}

## Git bash completion
# Only if we have brew
[[ `command -v brew` ]] &&
[[ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]] &&  \
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash

## Github stuff if it exists
[[ -f ~/.github ]] && . ~/.github

# Perlbrew stuff
[[ -f ~/perl5/perlbrew/etc/bashrc ]] && . ~/perl5/perlbrew/etc/bashrc

# CT Nopaste
[[ -f ~/.ctpaste ]] && . ~/.ctpaste

#Bash Prompt
PS1="\[\e[0;32m\][\u@\w]\[\e[m\]\n\[\e[1;34m\][\h]\[\e[m\]\[\e[0;33m\]\$(parse_git_branch)\$(num_git_commits_ahead)\[\e[m\] : "
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
# Line up bash prompt to first column every time
# http://jonisalonen.com/2012/your-bash-prompt-needs-this/
PS1="\[\033[G\]$PS1"
