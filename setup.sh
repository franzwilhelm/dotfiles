#!/bin/bash
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
export DOTFILES_DIR="$HOME/.config/dotfiles"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  curl -fsSLo install-zsh.sh "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
  chmod +x "$(pwd)/install-zsh.sh"
  RUNZSH=no ./install-zsh.sh
  rm "$(pwd)/install-zsh.sh"
else
  echo "oh-my-zsh already installed"
fi

# Install ZSH plugins
# Spaceship theme
if [ ! -d "${ZSH_CUSTOM}/themes/spaceship-prompt" ]; then
  git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt
  ln -s ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
  echo "spaceship theme installed"
else
  echo "spaceship theme already installed"
fi

# Alias tips plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/alias-tips" ]; then
  git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM}/plugins/alias-tips
  echo "alias-tips plugin installed"
else
  echo "alias-tips plugin already installed"
fi

# History substring search plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-history-substring-search" ]; then
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
  echo "zsh-history-substring-search plugin installed"
else
  echo "zsh-history-substring-search plugin already installed"
fi

# Autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
  echo "zsh-autosuggestions plugin installed"
else
  echo "zsh-autosuggestions plugin already installed"
fi

# Syntax highlighting plugin
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
  echo "zsh-syntax-highlighting plugin installed"
else
  echo "zsh-syntax-highlighting plugin already installed"
fi

if [ ! -L $HOME/.zshrc ]; then
  mv $HOME/.zshrc $HOME/.zshrc.old
  echo "Backed up existing .zshrc to .zshrc.old"
  ln -s $DOTFILES_DIR/shell/zshrc $HOME/.zshrc
  echo "Created symlink for .zshrc"
else
  echo ".zshrc symlink already exists"
fi

# nvim init.lua
if [ ! -L $HOME/.config/nvim/init.lua ]; then
  mkdir -p $HOME/.config/nvim
  mv $HOME/.config/nvim/init.lua $HOME/.config/nvim/init.lua.old
  echo "Backed up existing init.lua to init.lua.old"
  ln -s $DOTFILES_DIR/nvim/init.lua $HOME/.config/nvim/init.lua
  echo "Created symlink for init.lua"
fi
