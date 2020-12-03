# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	alias-tips
	colored-man-pages
	colorize
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
ZSH_THEME="agnoster"

source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

setopt inc_append_history
setopt share_history

rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}

zle -N rationalise-dot
bindkey . rationalise-dot

setopt correct_all
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt CDABLE_VARS
setopt AUTO_PUSHD
setopt AUTO_CD
setopt CHASE_DOTS

alias gitc="git clone --depth=1 ."

if command -v exa &> /dev/null; then
	alias ll='exa -l'
	alias lll='exa -l | less'
	alias lla='exa -la'
	alias llt='exa -T'
	alias llfu='exa -bghHliS --git'
fi

alias cp='cp -R'
alias scp='scp -r'
alias mkdir='mkdir -p'
alias lgl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

alias vim="vim -p"

# Enable alt arrow keys for movements
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Delete next word with alt del
bindkey '^[[3;3~' kill-word

#powerlevel10k
if [[ -f "~/.powerlevel10k/powerlevel10k.zsh-theme" ]]; then
	source ~/.powerlevel10k/powerlevel10k.zsh-theme
	ZSH_THEME=".powerlevel10k/powerlevel10k"
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

export http_proxy=
export https_proxy=

function randomtest {
	set -x
	RANDOMNUMBER=$(shuf -i 1-100000 -n 1)
	while [[ -e "$HOME/test/randomtest_$RANDOMNUMBER" ]]; do
		RANDOMNUMBER=$(shuf -i 1-100000 -n 1)
	done
	mkdir -p "$HOME/test/randomtest_$RANDOMNUMBER"
	cd "$HOME/test/randomtest_$RANDOMNUMBER"
	set +x
}

if command -v youtube-dl; then
	function download_transcription {
		ID=$1
		LANG=$2

		if [[ -z $LANG ]]; then
			INSTALL=en
		fi

		youtube-dl --write-sub --sub-lang $LANG --skip-download $ID
	}
fi

if command -v gs; then
	function make_pdf_smaller {
		if [[ -e $1 ]]; then
			RANDPDF="$RANDOM$RANDOM$RANDOM.pdf"
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$RANDPDF" "$1"
			mv "$1" "$1.old"
			mv "$RANDPDF" "$1"
		else
			echo "pdf file $1 not found";
		fi
	}
fi

function treesize {
	du -k --max-depth=1 | sort -nr | awk '
		BEGIN {
			split("KB,MB,GB,TB", Units, ",");
		}
		{
			u = 1;
			while ($1 >= 1024) {
				$1 = $1 / 1024;
				u += 1
			}
		$1 = sprintf("%.1f %s", $1, Units[u]);
		print $0;
		}
	'
}

function pretty_csv {
    perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' "$@" | column -t -s, | less  -F -S -X -K
}

function mytail { tail -n1000000 -f *$1* }

if command -v scontrol; then
	function slurmlogpath { scontrol show job $1 | grep StdOut | sed -e 's/^\s*StdOut=//' }
	function stail { tail -f -n100000 `slurmlogpath $1` }
	function staill { tail -f -n100 `slurmlogpath $1` }
	function stailn { tail -f -n $1 `slurmlogpath $2` }
fi

if command -v whypending; then
	function showmyjobsstatus { 
	    if [ $# -eq 0 ]; then
		for i in $(squeue -u $USER | grep -v JOBID | sed -e 's/^\s*//' | sed -e 's/\s.*//'); do 
		    echo ">>>>>> $i"; whypending $i | egrep "(Position in)|(Estimated)";
		done 
	    else 
		echo ">>>>>> $i"; whypending $1 | egrep "(Position in)|(Estimated)";
	    fi
	}
fi

if command -v squeue; then
	function ftails {
		if [ $# -eq 0 ]; then
			SLURMID=$(squeue -u $USER | cut -d' ' -f11- | sed -e 's/\s.*//' | egrep -v "^\s*$" | sort -nr | head -n1)
			if [ ! -z $SLURMID ]; then
				tail -f $(slurmlogpath $SLURMID)
			fi
		else
			tail -f $(slurmlogpath $1)
		fi
	}
fi

function countdown() {
    secs=$1
    shift
    msg=$@
    while [ $secs -gt 0 ]
    do
        printf "\r\033[KWaiting %.d seconds $msg" $((secs--))
        sleep 1
    done
    echo
}

function myavg () {
    OUTPUT="count,ave,median,first,last\n"
    OUTPUT2=$(awk '
      BEGIN {
        c = 0;
        sum = 0;
      }
      $1 ~ /^(\-)?[0-9]*(\.[0-9]*)?$/ {
        a[c++] = $1;
        sum += $1;
      }
      END {
        ave = sum / c;
        if( (c % 2) == 1 ) {
          median = a[ int(c/2) ];
        } else {
          median = ( a[c/2] + a[c/2-1] ) / 2;
        }
        OFS=",";
        print c, ave, median, a[0], a[c-1];
      }
      ')
      echo "$OUTPUT$OUTPUT2" | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | column -t -s,
}

function mongodbtojson {
    ip=$1
    port=$2
    dbname=$3
    mongo --quiet mongodb://$ip:$port/$dbname --eval "db.jobs.find().pretty().toArray();"
}

