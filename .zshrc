export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export EDITOR="nvim"

if [[ $USER != "root" ]]; then
  export STARSHIP_CONFIG=~/.config/starship.toml
  eval "$(starship init zsh)"
  export GPG_TTY=$(tty)

  export PATH=$HOME/.local/share/nvim/mason/bin:$HOME/.nimble/bin:$HOME/bin:/usr/local/bin:$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.spicetify:$HOME/.local/share/coursier/bin:$HOME/.local/bin:$HOME/.local/share/fnm:$HOME/go/bin/:/usr/local/go/bin:$PATH
  export PATH=/usr/lib/android-sdk/emulator/:/usr/lib/android-sdk/cmdline-tools/latest/bin:$HOME/flutter/bin:$PATH
  fpath=(~/.zsh $fpath)
  autoload -Uz compinit compinit -u

  # fnm
  eval "$(fnm env --use-on-cd)"

  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

  [[ ! -r /home/iperez/.opam/opam-init/init.zsh ]] || source /home/iperez/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

  function node_package_manager {
    if [ -f yarn.lock ]; then
      yarn "$@"
    elif [ -f package-lock.json ]; then
      npm "$@"
    else
      yarn "$@"
    fi
  }

  function chpwd() {
    if [[ -f package.json ]]; then
      fnm use --resolve-engines >/dev/null 2>/dev/null
    fi
  }

  # bun completions
  [ -s "/home/iperez/.bun/_bun" ] && source "/home/iperez/.bun/_bun"

  # bun
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"

  # -------------| Alias |----------------

  alias pm=node_package_manager
fi

function docker_connect() {
  if docker ps >/dev/null 2>&1; then
    container=$(docker ps | awk '{if (NR!=1) {print $NF}}' | fzf)

    if [[ -n $container ]]; then
      container_id=$(echo "$container" | awk -F ': ' '{print $1}')

      docker exec -it "$container_id" /bin/sh
    else
      echo "No container selected"
    fi

  else
    echo "Docker is not running"
  fi
}

COMPLETION_WAITING_DOTS="true"

_Z_NO_RESOLVE_SYMLINKS="true"

ZSH_COLORIZE_TOOL=chroma

ZSH_COLORIZE_STYLE=vim
ZSH_DISABLE_COMPFIX=true

plugins=(
  colorize
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-interactive-cd
  urltools
  taskwarrior
)

source $ZSH/oh-my-zsh.sh

# ----| Commands |----

# Ubuntu
alias apt="nala"
alias apt-get="nala"

alias vi="nvim $1"
alias v.="nvim ."
alias mk="mkdir $1"
alias zathura="nohup zathura $1"
alias ls="exa --group-directories-first --icons"
alias la="ls --group-directories-first --icons -a"
alias cat="bat --style=plain --paging=never"
alias tree="exa -T --icons"
alias grep="grep --color=auto"
alias ng="npm init -y && git init"
alias nd="npm i -D $1"
alias ns="npm i $1"
alias t="tree $1"
alias paru="paru --bottomup $1"
alias sudo='sudo '
alias c.='code .'
alias f='vifm'
alias rm='rm -i'

alias grep="grep --color=auto"
alias cat="bat --style=plain --paging=never"
alias mk="mkdir $1"
alias zathura="nohup zathura $1"
alias ls="eza --group-directories-first --icons"
alias la="eza --group-directories-first --icons -a"
alias ll="eza --group-directories-first --icons -l"
alias cat="bat --style=plain --paging=never"
alias tree="eza -T --icons"
alias grep="grep --color=auto"
alias t="tree $1"
alias paru="paru --skipreview --bottomup $1"

alias up="docker compose up"
alias upt="docker compose -f docker-compose.test.yml up --abort-on-container-exit"
alias down="docker compose down"
alias downt="docker compose -f docker-compose.test.yml down"
alias dconnect="docker_connect"

# Git
alias g="git"

alias gclone="g clone"

# Add
alias gaa="git add -A"

# Branch
alias gb="git branch"
alias gba="git branch --all --verbose"

# Checkout
alias gco="git checkout"
alias gbc="git checkout -b"

# Commit
alias gc="git commit --verbose"

# Status
alias gs="git status -sb"

# Fetch
alias gf="git fetch --all -p"

# Push
alias gps="git push"

# Pull
alias gpl="git pull"

# Merge (m)
alias gm='git merge'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'

# Working Copy
alias gd="git diff --no-ext-diff --cached"

alias dot="g --git-dir ~/.dotfiles --work-tree ~"

# Workspace
export DEV="~/dev/personal"
export DEV_HOULAK="~/dev/work/Houlak"

alias dv="cd $DEV"
alias dh="cd $DEV_HOULAK"

alias aws-houlak="awsume HOULAK"

eval "$(atuin init zsh)"
source $HOME/.atuin_zshrc
