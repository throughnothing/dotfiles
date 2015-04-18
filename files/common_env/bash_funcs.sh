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

