#!/bin/bash

function red_text {
	echo -e "\e[101m$1\e[0m"
}

function green_text {
	echo -e "\e[46m\e[103m$1\e[0m"
}

function install_if_not_exists {
	PROGNAME=$1
	INSTALL=$2

	if [[ -z $INSTALL ]]; then
		INSTALL=$PROGNAME
	fi

	if ! which $PROGNAME >/dev/null; then
		red_text "$PROGNAME could not be found. Enter your user password so you can install it via apt-get."
		sudo apt-get -y install $INSTALL
	fi
}

green_text "My-ZSH-Config installer for Debian based systems"

HASROOTRIGHTS=0
if (whiptail --title "Do you have sudo rights on this machine?" --yesno "If not, no new programs can be installed automatically" 8 78); then
	HASROOTRIGHTS=1
	install_if_not_exists "whiptail"
	install_if_not_exists "curl"
	install_if_not_exists "zsh"
	install_if_not_exists "vim"
	install_if_not_exists "git"
	install_if_not_exists "exa"
	install_if_not_exists "hstr"
	if command -v hstr &> /dev/null; then
		hstr --show-configuration >> ~/.zshrc
	fi
else
	red_text "Without sudo rights, you cannot install stuff. I will try to continue anyway for the programs that I can find"
fi

if command -v zsh &> /dev/null; then
	if [ -f ~/.zshrc ]; then
		mv ~/.zshrc ~/.zshrc_ORIGINAL
		green_text "Moved ~/.zshrc to ~/.zshrc_ORIGINAL"
	fi

	if [ -d ~/.zsh ]; then
		mv ~/.zsh ~/.zsh_ORIGINAL
		green_text "Moved ~/.zsh to ~/.zsh_ORIGINAL"
	fi

	cp zshrc ~/.zshrc
	cp -r oh-my-zsh ~/.oh-my-zsh
	cp -r oh-my-zsh/plugins/zsh-syntax-highlighting/highlighters ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/
	if command -v git &> /dev/null; then
		git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
	else
		red_text "Without git, autosuggestions cannot be cloned"
	fi

	cp -r p10k.zsh ~/.p10k.zsh
	cp -r powerlevel10k/ ~/.powerlevel10k/

	if [[ $HASROOTRIGHTS -eq "1" ]]; then
		if (whiptail --title "Set ZSH as default shell?" --yesno "This needs sudo rights." 8 78); then
			green_text "Enter your password for setting zsh as default shell"
			chsh -s /bin/zsh
		fi
	fi
else
	red_text "ZSH does not seem to be installed correctly."
fi

if command -v vim &> /dev/null; then
	if (whiptail --title "Do you want to install my vimrc files too?" --yesno "This installs a sane vim environment." 8 78); then
		if [ -f ~/.vimrc ]; then
			mv ~/.vimrc ~/.vimrc_ORIGINAL
			green_text "Moved ~/.vimrc to ~/.vimrc_ORIGINAL"
		fi

		cp -r vim_runtime ~/.vim_runtime
		cp -r vimrc ~/.vimrc

		mkdir -p ~/.vim/pack/tpope/start
		cd ~/.vim/pack/tpope/start
		git clone https://tpope.io/vim/surround.git
		vim -u NONE -c "helptags surround/doc" -c q

		git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
	fi
else
	red_text "vim does not seem to be installed"
fi
