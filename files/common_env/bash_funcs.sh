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

function _go {
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

function g {
    local target=$(grep "^$1" $HOME/.go | head -1 | awk '{print $2}')
    [ "$target" ] && [ "$1" ] && pushd "$target" 2>&1 >> /dev/null && return

    z $* || _go $*
}
