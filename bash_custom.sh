#!/bin/bash
_wrap () {
  alias $1="echo \" ~ $2\" && $2"
}
 
alias gh="cat ~/scripts/gitaliases.sh"
_wrap gba "git branch -a"
_wrap gpaa "git add . --all && git commit --amend --no-edit && git push origin -f"
_wrap grbi "git rebase upstream/master -i"
_wrap gph "git push heroku master"
_wrap gaa "git add -A"
_wrap gd "git diff"
_wrap gs "git status"
_wrap gco "git checkout"
_wrap gcp "git cherry-pick"
_wrap gci "git commit"
_wrap gcia "git commit --amend --no-edit"
_wrap grb "git rebase -i"
_wrap gp "git pull"
_wrap gpp "git push origin"
_wrap gfa "git fetch --all"
_wrap gfu "git fetch upstream"
_wrap grh "git reset --hard"
_wrap gmt "git mergetool"
_wrap gl "git log --oneline --graph"
_wrap shipit "npm run deploy"
_wrap gpft "git push --follow-tags"
_wrap npmv "npm version $1 && git push --follow-tags && npm publish"
_wrap gif "~/scripts/gif"
_wrap hosts "sudoedit /etc/hosts && sudo /etc/init.d/dns-clean restart && sudo /etc/init.d/networking restart"
_wrap amisafe "ps auxwww | grep sshd"
_wrap empty-trash "rm -rf ~/.local/share/Trash/*"
 
export PS1="\[\033[38;5;220m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\A \\$ \[$(tput sgr0)\]"


export PS1="\[\033[38;5;220m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\A \\$ \[$(tput sgr0)\]"

# GIT PS1
print_pre_prompt () {
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    repo_color="\033[38;5;10m" # bold green
    status=$(git status --porcelain 2> /dev/null)
    if [[ "$branch" == "HEAD" ]]; then
      repo_color="\033[38;5;13m" # bold purple
      branch='detached*'
    fi
    status=$(git status --porcelain 2> /dev/null)
    if [[ "$status" != "" ]]; then
      repo_color="\033[38;5;9m" # bold red
    fi
    git_branch="$branch"
  else
    git_branch=""
  fi
  PS1R="$git_branch"
  if [[ $git_branch ]]; then
    PS1L="[$(basename $(git rev-parse --show-toplevel))] "
    printf "\n\033[38;5;7m%s$repo_color%s \n" "$PS1L" "$PS1R"
  fi
}
PROMPT_COMMAND=print_pre_prompt

ipp () {
  dig +short myip.opendns.com @resolver1.opendns.com
}
 
ipl () {
  ifconfig | grep broadcast | awk '{print $2}'
}

# Kill all processes that match the given name. ie: `killname webpack` will kill all running webpack instances
killname() {
  sudo kill -9 $(ps -e | grep $1 | awk '{print $1}')
}
