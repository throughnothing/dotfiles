alias h='history 10'
alias hh='history 20'
alias hhh='history 30'
alias fch='fc -10 0'
alias fchh='fc -20 0'
alias fchhh='fc -30 0'
alias grep='grep --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias ls='ls -G'
alias dateymd='date +%Y-%m-%d'
alias ctagsr='ctags -R'

alias col1="awk '{print \$1}'"
alias col2="awk '{print \$2}'"
alias col3="awk '{print \$3}'"

alias psag="ps aux | grep"
alias lssh='ps aux | grep ssh'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'

#Git
alias gcu="sed -i -e 's/https:\/\/github\.com\//git@github\.com:/' .git/config"
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gdp='git diff -p'
alias gl='git log --oneline'
alias glp='git log --oneline -p'
alias gc='git commit'
alias gp='git pull'
alias gpo='git push origin'
alias gfa='git fetch --all'
alias gx='open -a Gitx'
alias gdsv="git diff | vim -"
alias gdv="git diff | vim -"

if [ `command -v mvim` ]; then
    alias vim="mvim -v"
fi

alias tmux='TERM=xterm-256color tmux'

alias pubip="curl -s http://checkip.dyndns.org/ | grep -o \"[[:digit:].]\+\""

alias cal_unload="launchctl unload -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist"
alias cal_load="launchctl load -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist"
