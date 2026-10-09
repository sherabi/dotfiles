#!/usr/bin/env bash

# Exports
GPG_TTY=$(tty)
export GPG_TTY
export PATH="/opt/pel/formae/bin:/opt/homebrew/opt/postgresql@16/bin/:/Users/shezaan/.lmstudio/bin:/Users/shezaan/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/curl/bin:/usr/local/opt/openssl@1.1/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/opt/findutils/libexec/gnubin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/grep/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/sbin:/usr/bin:$PATH"
export EDITOR='nvim'
export BASH_SILENCE_DEPRECATION_WARNING=1
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
# Only set TERM outside tmux -- inside tmux, TERM is managed by tmux itself
# (via default-terminal in tmux.conf); overriding it here unconditionally
# stomps on that and makes nvim's checkhealth flag a $TERM/default-terminal mismatch.
if [ -z "$TMUX" ]; then
  export TERM="xterm-256color"
fi

# Source other configs
eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(fzf --bash)"

# New Aliases
alias fe="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n 1 nvim"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -rf'
alias ls='eza -lhaagb' # Used "-a" twice to show . and .. as well
alias k='kubectl'
alias tf='terraform'

# Completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && ."/usr/local/etc/profile.d/bash_completion.sh"

# Old Aliases
alias grep='grep --color'
# alias ls='ls -lhF --color'

shopt -s checkwinsize
shopt -s histappend

HISTFILESIZE=1000000000
HISTSIZE=10000
HISTTIMEFORMAT="%D %T  "
HISTCONTROL=ignoredups:ignorespace

sman(){
  curl "https://cheat.sh/$1"
}

# Git Worktree Functions
gwa() {
  git_root=$(dirname "$(git rev-parse --git-common-dir)")
  cd "$git_root" || return
  git pull
  git worktree add ".worktrees/$1"
  cd ".worktrees/$1" || return
}

gwr() {
  local branch git_root path confirm

  git_root=$(dirname "$(git rev-parse --git-common-dir)")

  if [[ -z "$1" ]]; then
    path=$(git worktree list \
      | grep ".worktrees/" \
      | awk '{print $1}' \
      | fzf --prompt="Delete worktree: ")

    [[ -z "$path" ]] && return
    branch=$(basename "$path")

    echo
    read -r -p "Delete worktree '$branch'? [Y/n] " confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
      echo "Aborted."
      return
    fi
  else
    branch="$1"
  fi

  cd "$git_root" || return

  git worktree remove --force "${git_root}/.worktrees/$branch"
  git branch -D "$branch"
  git remote prune origin
  git pull
}

gwl() {
  git worktree list
}

gws() {
  local dir
  dir=$(git worktree list | fzf | awk '{print $1}')
  [[ -n "$dir" ]] && cd "$dir" || return
}
# End Git Worktree Functions

dedup_history() {
  local histfile="${HISTFILE:-$HOME/.bash_history}"
  tac "$histfile" | awk '!seen[$0]++' | tac > "${histfile}.tmp" && mv "${histfile}.tmp" "$histfile"
  history -c
  history -r
  echo "History deduplicated."
}
