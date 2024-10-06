#!/bin/bash

cwd=$(pwd)

# bash
ln -sf "$cwd/bash/.bashrc" ~/.bashrc

# zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc
ln -sf "$cwd/zsh/.zshenv" ~/.zshenv
ln -sf "$cwd/zsh/.zprofile" ~/.zprofile

# vim
ln -sf "$cwd/vim/.vimrc" ~/.vimrc
ln -sf "$cwd/vim/.vimrc" ~/.ideavimrc

# neovim and coc
if [ -d "~/.config/nvim" ]; then
  ln -sf "$cwd/nvim/init.vim" ~/.config/nvim/init.vim
fi

# vscode
ln -sf "$cwd/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig
ln -sf "$cwd/git/.gitconfig-self" ~/.gitconfig-self
ln -sf "$cwd/git/.gitconfig-work" ~/.gitconfig-work
ln -sf "$cwd/git/.gitignore" ~/.gitignore
ln -sf "$cwd/git/.gitattributes" ~/.gitattributes

#tmux
# ln -sf "$cmd/tmux/.tmux.conf" ~/.tmux.conf
# ln -sf "$cmd/tmux/.tmux.conf.local" ~/.tmux.conf.local


 #git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
 #git clone git://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
