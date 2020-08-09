# My-ZSH-Config
This is the collection of config files needed for my configuration of my ZSH. I did not write most of these myself, but copied them from any number of sources as seemed fit, though, because it was ever only intended for personal use, I never documented these sources. Most of them stem by the project oh-my-zsh.



## Installation

Install the powerline-fonts (on Debian, sudo apt install fonts-powerline, see https://github.com/powerline/fonts for other systems).

Copy these files to ~/.oh-my-zsh and ~/.zshrc respectively.

Also, for autocompletion, run

> git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

## Features

* Barely any need for `cd` anymore (just type the folder name)
* Automatically expand `...` to `../..`, `....` to `../../..` etc.
* Colorize man-pages
* Show latest git-status in git-repositories
* Show aliases (e.g. `git clone ...` shows `Alias tip: g clone ...`)
* Auto-completetion with tab-cycle-through and error-correction
* Syntax-highlighting like in the `fish`-shell
* Completion of commands that start similiar with right arrow key
* Central repository for zsh-history for all open shells
* ... much more :-)

## Screenshots

![SyntaxHighlighting](syntaxhighlighting.png "SyntaxHighlighting")
![Tabccat](tabccat.png "Tabccat")
![UnknownCommand](unknowncommand.png "UnknownCommand")
![powerlevel10k](powerlevel10k.png "powerlevel10k")
![everything](fullfeatures.png "everything")
