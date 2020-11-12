#!/bin/bash

echo "My-ZSH-Config installer for Debian based systems"

if ! command -v whiptail &> /dev/null; then
	echo "For this script to work, whiptail needs to be installed. To install automatically, enter your password"
	sudo aptitude -y install curl
fi

if ! command -v whiptail &> /dev/null; then
	echo "For this script to work, whiptail needs to be installed. To install automatically, enter your password"
	sudo aptitude -y install whiptail
fi

HASROOTRIGHTS=0
if (whiptail --title "Do you have sudo rights on this machine?" --yesno "If not, no new programs can be installed automatically" 8 78); then
	HASROOTRIGHTS=1
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
else
	echo "Without sudo rights, you cannot install stuff. I will try to continue anyway for the programs that I can find"
fi

if command -v zsh &> /dev/null; then
	if [ -f ~/.zshrc ]; then
		mv ~/.zshrc ~/.zshrc_ORIGINAL
		echo "Moved ~/.zshrc to ~/.zshrc_ORIGINAL"
	fi

	if [ -d ~/.zsh ]; then
		mv ~/.zsh ~/.zsh_ORIGINAL
		echo "Moved ~/.zsh to ~/.zsh_ORIGINAL"
	fi

	cp zshrc ~/.zshrc
	cp -r oh-my-zsh ~/.oh-my-zsh
	cp -r oh-my-zsh/plugins/zsh-syntax-highlighting/highlighters ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/
	if command -v git &> /dev/null; then
		git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
	else
		echo "Without git, autosuggestions cannot be cloned"
	fi

	if (whiptail --title "Do you want to install powerlevel10k?" --yesno "This will further improve experience with ZSH, but is not needed." 8 78); then
		cp -r p10k.zsh ~/.p10k.zsh
		cp -r powerlevel10k/ ~/.powerlevel10k/
	fi

	if [[ $HASROOTRIGHTS -eq "1" ]]; then
		if (whiptail --title "Set ZSH as default shell?" --yesno "This needs sudo rights." 8 78); then
			sudo chsh -s /bin/zsh
		fi
	fi
else
	echo "ZSH does not seem to be installed correctly."
fi

if command -v vim &> /dev/null; then
	if (whiptail --title "Do you want to install my vimrc files too?" --yesno "This has nothing to do with ZSH, but is just some small vim stuff." 8 78); then
		if [ -f ~/.vimrc ]; then
			mv ~/.vimrc ~/.vimrc_ORIGINAL
			echo "Moved ~/.vimrc to ~/.vimrc_ORIGINAL"
		fi

		mkdir -p ~/.vim/pack/tpope/start
		cd ~/.vim/pack/tpope/start
		git clone https://tpope.io/vim/surround.git
		vim -u NONE -c "helptags surround/doc" -c q

		#cd ~/.vim/bundle
		#git clone https://github.com/valloric/youcompleteme
		#cd ~/.vim/bundle/YouCompleteMe
		#git submodule update --init --recursive
		#sudo python3 install.py --all
        cp -r vim_runtime ~/.vim_runtime
		cp -r vimrc ~/.vimrc
	fi
else
	echo "vim does not seem to be installed"
fi


if (whiptail --title "Do you want to install fselect too?" --yesno "This allows SQL-like search through the file system." 8 78); then
    if ! command -v whiptail &> /dev/null; then
        echo "For this script to work, whiptail needs to be installed. To install automatically, enter your password"
        sudo aptitude -y install cargo
    fi
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    echo "source \$HOME/.cargo/env" >> $HOME/.zshrc
    cargo install fselect
fi
