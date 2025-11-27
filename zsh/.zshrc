# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"

# Volta for managing JavaScript toolchains
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# .local/bin to path
export PATH="${HOME}/.local/bin:$PATH"

# add linuxbrew to path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Editor
export EDITOR="edit"

# ZSH Theme
ZSH_THEME="robbyrussell"

# ZSH History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Oh my zsh plugins
plugins=(
  colored-man-pages
  jump
  sudo
  # https://github.com/zsh-users/zsh-autosuggestions
  zsh-autosuggestions
  # https://github.com/zdharma-continuum/fast-syntax-highlighting
  fast-syntax-highlighting
)

# Source oh-my-zsh and other necessary scripts
source $ZSH/oh-my-zsh.sh

# Aliases
## Git aliases
alias gpsu="git push --set-upstream origin"
alias gsw="git switch"
alias gswc="git switch -c"
alias gswm="git switch main"
alias gf="git fetch"
alias gl="git pull"
alias gp="git push"
alias ga="git add"

alias lg="lazygit"

## Directory navigation
alias home="cd ~"
alias ..="cd .."

## Etc
alias tree="tree --gitignore"
alias treed="tree -d --gitignore"

## File editing
alias edit="nvim"
alias zj="zellij"

alias modshell="edit ~/.zshrc"
alias modaws="edit ~/.aws"
alias modmods="edit ~/.config"
alias modship="edit ~/.config/starship.toml"
alias modmux="edit ~/.tmux.conf"
alias modzelli="edit ~/.config/zellij/config.kdl"
alias modneo="edit ~/.config/nvim"

alias reloadz="source ~/.zshrc"

## AWS identity check
alias whoiam="aws sts get-caller-identity | jq -r '\"Account: \(.Account)\nUserId: \(.UserId)\nArn: \(.Arn)\"'"

## pnpm shortcut
alias pn=pnpm

## Miscellaneous
alias ls="ls -alh --color=auto"

## Scripts

# Commit with shorthand for commitlint
# Usage: gc <shorthand> <message here>
gc() {
  declare -A commit_types=(
    ["c"]="chore"
    ["f"]="feat"
    ["x"]="fix"
    ["r"]="refactor"
    ["d"]="docs"
    ["s"]="style"
    ["t"]="test"
    ["p"]="perf"
    ["ci"]="ci"
    ["b"]="build"
    ["v"]="revert"
  )

  # Extract the shorthand and message from the arguments
  shorthand=$1
  shift
  message="$*"

  if [[ -n "${commit_types[$shorthand]}" ]]; then
    commit_type="${commit_types[$shorthand]}"
    git commit -m "$commit_type: $message"
  else
    echo "Unknown shorthand: $shorthand"
    return 1
  fi
}

# Find and kill process using a port
# Usage: fp <port number
fp() {
  if [ $# -eq 0 ]; then
    echo "Hol' up"
    return 1
  fi

  local port=$1
  local process_info=$(lsof -i :$port -sTCP:LISTEN -P -n)

  if [ -z "$process_info" ]; then
    echo "No process found listening on port $port"
    return 1
  fi

  local pid=$(echo "$process_info" | awk 'NR==2 {print $2}')
  local process_name=$(echo "$process_info" | awk 'NR==2 {print $1}')

  echo "Found process '$process_name' (PID: $pid) listening on port $port"
  
  read -q "REPLY?Do you want to kill this process? (y/n) "
  echo

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    kill -9 $pid
    if [ $? -eq 0 ]; then
        echo "Process '$process_name' (PID: $pid) has been killed"
    else
        echo "Failed to kill process. You may need sudo privileges."
    fi
  else
    echo "Operation cancelled"
  fi
}

# Removes dead remote branches and old local branches and keeeps main
# Usage: cleangit
cleangit() {
  git fetch --prune && git branch | grep -v "main" | xargs git branch -D
}

# bun completions
[ -s "${BUN_INSTALL}/_bun" ] && source "${BUN_INSTALL}/_bun"

# Starship Initialisation
eval "$(starship init zsh)"
