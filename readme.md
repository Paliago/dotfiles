# Dotfiles

Make sure you're cd:d into this directory before running stow aimed at your home dir.

### Requirements

- zsh
- oh-my-zsh
- nvim 0.11+
- brew

## Mac

```bash
stow --target=/Users/alvinjohansson */
```

## Linux

### Quick Setup

```bash
# oh-my-zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# answer no for overwrite and yes for setting default shell

# oh my extensions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# starship
curl -sS https://starship.rs/install.sh | sh

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.12

# aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# brew
sudo apt-get install build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install gcc

# nvim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# brewing
brew tap elva-labs/elva
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-fira-code-nerd-font
brew install lazygit awsesh oven-sh/bun/bun zellij opencode

# volta (node)
curl https://get.volta.sh | bash
volta install node
volta install pnpm

stow --target=/home/alv */
```
