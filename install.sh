#!/bin/bash

sudo aptitude install zsh vim exa fonts-powerline git

cp zshrc ~/.zshrc
cp oh-my-zsh ~/.oh-my-zsh

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

chsh -s /bin/zsh
