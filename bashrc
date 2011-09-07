# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
. ~/.bash-will



# =============================================================================
. ~/.alias
set -o vi

export ANT_HOME=/usr/local/ant
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:~/.scripts/:/var/lib/gems/1.8/bin/:~/.scripts/"
export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
export SVN_EDITOR="vim"
export JAVA_HOME="/usr/lib/jvm/java-6-sun/"
export PATH="$PATH:/home/wwolf/.scripts/:/var/lib/gems/1.8/bin/"

# Vi moed binding, remap C-c to C-x and make C-c exit insert mode
# http://stackoverflow.com/questions/3126453/bash-vi-mode-bind-c-c-to-escape-from-insert-mode
stty intr ^X
bind -m vi-insert C-c:vi-movement-mode

function parse_git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "("${ref#refs/heads/}")" 
}

function num_git_commits_ahead {
	num=$(git status 2> /dev/null | grep "Your branch is ahead of" | awk '{split($0,a," "); print a[9];}' 2> /dev/null) || return
	if [[ "$num" != "" ]]; then
		echo "+$num"
	fi
}

go() {
    target=''
    if [ $# == 0 ]; then
        target=$HOME
    else
        target=$(grep "^$1" $HOME/.go | head -1 | col2)
    fi
    if [ $target ]; then
        pushd "$target" >> /dev/null
        return
    fi
    for f in $(ls $HOME | sort); do
        echo $f | grep "^$1" > /dev/null
		if [ "$?" == "0" ]; then
			pushd $HOME/`echo $f | grep "^$1" | head -n 1` >> /dev/null
		fi
    done
    for f in $(ls $HOME/Projects | sort); do
        echo $f | grep -q "^$1"
        if [ $? -eq 0 ]; then
            pushd "$HOME/Projects/$f" >> /dev/null
            return
        fi
    done
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

## Git bash completion
#. `brew --prefix`/etc/bash_completion

# Perlbrew stuff
[[ -f ~/perl5/perlbrew/etc/bashrc ]] && . ~/perl5/perlbrew/etc/bashrc

#Bash Prompt
PS1="\[\e[0;32m\][\u@\w]\[\e[m\]\n\[\e[1;34m\][\h]\[\e[m\]\[\e[0;33m\]\$(parse_git_branch)\$(num_git_commits_ahead)\[\e[m\] : "
