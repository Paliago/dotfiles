# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"

# Volta for managing JavaScript toolchains
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# lvim to path
export PATH="${HOME}/.local/bin:$PATH"

# add linuxbrew to path
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# sst
export PATH="${HOME}/.sst/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ZSH Theme
ZSH_THEME="robbyrussell"

# ZSH History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Oh my zsh plugins
plugins=(
  aws
  colored-man-pages
  jump
  sudo
  zsh-autosuggestions
  fast-syntax-highlighting
  autoupdate
)

# Source oh-my-zsh and other necessary scripts
source $ZSH/oh-my-zsh.sh

# Aliases
## Git aliases
alias gpsu="git push --set-upstream origin"
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

## File editing
alias edit="lvim"

alias modshell="edit ~/.zshrc"
alias modaws="edit ~/.aws"
alias modmods="edit ~/.config"
alias modship="edit ~/.config/starship.toml"
alias modbar="edit ~/.config/sketchybar"
alias modlunar="edit ~/.config/lvim/config.lua"
alias modmux="edit ~/.tmux.conf"
alias modzelli="edit ~/.config/zellij/config.kdl"

## AWS identity check
alias whoiam="aws sts get-caller-identity | jq -r '\"Account: \(.Account)\nUserId: \(.UserId)\nArn: \(.Arn)\"'"

## pnpm shortcut
alias pn=pnpm

## Miscellaneous
alias ls="ls -al --color=auto"

## Scripts

# Test a specific file with vitest
# Usage: testit <path/to/file>
testit() {
  if [ "$#" -eq 0 ]; then
    echo "Hol' up"
  else
    bunx vitest "-i" "tests/$*.test.ts"
  fi
}

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

# Removes dead remote branches and old local branches
# Usage: cleangit
cleangit() {
  git fetch --prune && git branch | grep -v "main" | xargs git branch -D
}

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "${BUN_INSTALL}/_bun" ] && source "${BUN_INSTALL}/_bun"

# Starship Initialisation
eval "$(starship init zsh)"
