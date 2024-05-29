# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

ZSH_THEME="robbyrussell"

# ZSH-history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

plugins=(
  aws
  colored-man-pages
  jump
  sudo
  zsh-autosuggestions
  fast-syntax-highlighting
  autoupdate
)

source $ZSH/oh-my-zsh.sh
source ~/.bash_profile

# User configuration

## Aliases
alias vim="lvim"

alias gpsu="git push --set-upstream origin"
alias gswc="git switch -c"
alias gswm="git switch main"
alias gf="git fetch"
alias gl="git pull"
alias gp="git push"
alias ga="git add"

alias ls="ls -alG --color=auto"

alias home="cd ~"
alias ..="cd .."
alias modshell="vim ~/.zshrc"
alias modaws="vim ~/.aws"
alias modmods="vim ~/.config"
alias modship="vim ~/.config/starship.toml"
alias modbar="vim ~/.config/sketchybar"
alias modlunar="vim ~/.config/lvim/config.lua"
alias modmux="vim ~/.tmux.conf"
alias modzelli="vim ~/.config/zellij/config.kdl"

alias whoiam="aws sts get-caller-identity | jq -r '\"Account: \(.Account)\nUserId: \(.UserId)\nArn: \(.Arn)\"'"

alias pn=pnpm

## Scripts

# Test a specific file with jest
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

# Starship Initialisation
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
