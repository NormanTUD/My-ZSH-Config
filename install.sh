#!/bin/bash

if ! command -v whiptail &> /dev/null; then
	sudo aptitude -y install whiptail
fi

if ! command -v zsh &> /dev/null; then
	sudo aptitude -y install zsh
fi

if ! command -v vim &> /dev/null; then
	sudo aptitude -y install vim
fi

if ! command -v git &> /dev/null; then
	sudo aptitude -y install git
fi

if ! command -v exa &> /dev/null; then
	sudo aptitude -y install exa
fi

cp zshrc ~/.zshrc
cp -r oh-my-zsh ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

if (whiptail --title "Do you want to install powerlevel10k?" --yesno "This will further improve experience with ZSH, but is not needed." 8 78); then
	cp -r p10k.zsh ~/.p10k.zsh
	cp -r powerlevel10k/ ~/.powerlevel10k/
fi

if (whiptail --title "Do you want to install my vimrc files too?" --yesno "This has nothing to do with ZSH, but is just some small vim stuff." 8 78); then
	cp -r vimrc ~/.vimrc
	cp -r vim ~/.vim
fi

if (whiptail --title "Set ZSH as default shell?" --yesno "This needs sudo rights." 8 78); then
	sudo chsh -s /bin/zsh
fi
