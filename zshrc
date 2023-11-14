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

if command -v exa > /dev/null; then
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

rtest () {
        set -x
        RANDOMNUMBER=$(shuf -i 1-100000 -n 1)
        while [[ -e "$HOME/test/randomtest_$RANDOMNUMBER" ]]
        do
                RANDOMNUMBER=$(shuf -i 1-100000 -n 1)
        done
        mkdir -p -p "$HOME/test/randomtest_$RANDOMNUMBER"
        cd "$HOME/test/randomtest_$RANDOMNUMBER"
        set +x
}


if command -v youtube-dl >/dev/null; then
	function download_transcription {
		ID=$1
		LANG=$2

		if [[ -z $LANG ]]; then
			INSTALL=en
		fi

		youtube-dl --write-sub --sub-lang $LANG --skip-download $ID
	}
fi

if command -v gs >/dev/null; then
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

if command -v scontrol >/dev/null; then
	function slurmlogpath { scontrol show job $1 | grep StdOut | sed -e 's/^\s*StdOut=//' }
	function stail { tail -f -n100000 `slurmlogpath $1` }
	function staill { tail -f -n100 `slurmlogpath $1` }
	function stailn { tail -f -n $1 `slurmlogpath $2` }
fi

if command -v whypending >/dev/null; then
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

if command -v squeue >/dev/null; then
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


if command -v mongo >/dev/null; then
	function mongodbtojson {
	    ip=$1
	    port=$2
	    dbname=$3
	    mongo --quiet mongodb://$ip:$port/$dbname --eval "db.jobs.find().pretty().toArray();"
	}
fi

function mount_iso {
	TO=/media/iso
	sudo umount $TO
	sudo mkdir -p $TO
	sudo mount $1 $TO -o loop
	echo "Mounted to $TO"
}

function create_digraph {
	filename=""
	while [[ -z $filename ]]; do
		filename=$(whiptail --inputbox "Filename without .dot" 8 39 "" --title "Create Digraph Dialog" 3>&1 1>&2 2>&3)	
		exitstatus=$?
		if [ $exitstatus != 0 ]; then
			return
		fi

		if [[ -e "$filename.dot" ]]; then
			whiptail --title "Warning" --msgbox "There are already files called either $filename.dot or $filename.svg. Enter another name please." 8 78
			filename=""
		fi
	done
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		filename_with_dot=${filename}.dot
		echo "digraph a {" >> $filename_with_dot
		echo "}" >> $filename_with_dot
		echo "dot -Tsvg $filename.dot > $filename.svg"
		vi $filename.dot
		echo "dot -Tsvg $filename.dot > $filename.svg && firefox $filename.svg" | xclip -selection c
		echo "dot -Tsvg $filename.dot > $filename.svg && firefox $filename.svg"
		echo "(This command has been copied to your clipboard. Press CTRL-Shift-V to insert it now.)"
	else
		echo "User selected Cancel."
	fi
}

function create_graph {
	filename=""
	while [[ -z $filename ]]; do
		filename=$(whiptail --inputbox "Filename without .dot" 8 39 "" --title "Create Graph Dialog" 3>&1 1>&2 2>&3)	
		exitstatus=$?
		if [ $exitstatus != 0 ]; then
			return
		fi

		if [[ -e "$filename.dot" ]]; then
			whiptail --title "Warning" --msgbox "There are already files called either $filename.dot or $filename.svg. Enter another name please." 8 78
			filename=""
		fi
	done
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		filename_with_dot=${filename}.dot
		echo "graph a {" >> $filename_with_dot
		echo "}" >> $filename_with_dot
		vi $filename.dot
		echo "dot -Tsvg $filename.dot > $filename.svg && firefox $filename.svg" | xclip -selection c
		echo "dot -Tsvg $filename.dot > $filename.svg && firefox $filename.svg"
		echo "(This command has been copied to your clipboard. Press CTRL-Shift-V to insert it now.)"
	else
		echo "User selected Cancel."
	fi
}

function rcreate_graph {
	rtest
	create_graph
}

function rcreate_digraph {
	rtest
	create_digraph
}

function latextemplate {
	filename=""
	while [[ -z $filename ]]; do
		filename=$(whiptail --inputbox "Filename without .tex" 8 39 "" --title "Dialog" 3>&1 1>&2 2>&3)	
		exitstatus=$?
		if [ $exitstatus != 0 ]; then
			return
		fi

		if [[ -e "$filename.tex" ]]; then
			whiptail --title "Warning" --msgbox "There are already files called either $filename.tex. Enter another name please." 8 78
			filename=""
		fi
	done

	DOCUMENTCLASS=$(whiptail --title "LaTeX-Documentclass for this document" --radiolist \
		"Choose a document class" 20 78 10 \
		"scrartcl" "KOMA-class for articles" ON \
		"scrbook" "KOMA-class for books" OFF \
		"scrreprt" "KOMA-class for reports" OFF \
		"scrlttr2" "KOMA-class for letters" OFF \
		"standalone" "Standalone image (e.g. for TikZ)" OFF \
		"beamer" "For presentations" OFF 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus != 0 ]; then
		return
	fi

	AUTHORNAME=$(cat ~/.defaultnamebrief 2>/dev/null)
	AUTHORNAME=$(whiptail --inputbox "Author name?" 8 49 "$AUTHORNAME" --title "Name of the Author of this document" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus != 0 ]; then
		return
	fi

	TITLE=$(whiptail --inputbox "Title of the paper?" 8 39 "" --title "Title of this paper" 3>&1 1>&2 2>&3)

	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		filename_with_tex=${filename}.tex

		echo "\\\\documentclass{${DOCUMENTCLASS}}" >> $filename_with_tex
		echo "" >> $filename_with_tex
		echo "% These are only some keywords for the autocompletion-feature of many editors: section, subsection, subsubsection, paragraph," >> $filename_with_tex
		echo "% includegraphics, width, linewidth, linespread, figure, wrapfigure, caption, label, footnote, equation, input, cite, citetitle," >> $filename_with_tex
		echo "% citeauthor, footfullcite, tableofcontents, printbibliography, clearpage, frq, frqq, flq, flqq, grq, grqq, glq, glqq, textit," >> $filename_with_tex
		echo "% texttt, mathrm, dots, pmatrix, centering, phantom, minipage, ensuremath, hfill, vfill, " >> $filename_with_tex
		echo "" >> $filename_with_tex
		if [[ "$DOCUMENTCLASS" = "beamer" ]]; then
			echo "\\\\usetheme{Dresden}" >> $filename_with_tex
			echo "\\\\usecolortheme{dolphin}" >>  $filename_with_tex
			echo "\\\\setbeamertemplate{caption}[numbered]" >> $filename_with_tex
			echo "" >> $filename_with_tex
		fi

		if [[ $AUTHORNAME ]]; then
			if [[ $DOCUMENTCLASS != "beamer" ]]; then
				echo "\\\\usepackage[" >> $filename_with_tex
				echo "	hidelinks," >> $filename_with_tex
				echo "	breaklinks=true," >> $filename_with_tex
				echo "	pdftex," >> $filename_with_tex
				echo "	pdfauthor={$AUTHORNAME}," >> $filename_with_tex
				if [[ ! -z $TITLE ]]; then
					echo "	pdftitle={$TITLE}," >> $filename_with_tex
				fi
				echo "	pdfsubject={}," >> $filename_with_tex
				echo "	pdfkeywords={}," >> $filename_with_tex
				echo "	pdfproducer={}," >> $filename_with_tex
				echo "	pdfcreator={}]{hyperref}" >> $filename_with_tex
			fi
		fi

		if [[ ! "$DOCUMENTCLASS" = "beamer" ]]; then
			echo "\\\\newcommand{\\\\centeredquote}[2]{" >> $filename_with_tex
			echo "	\\\\hbadness=5000" >> $filename_with_tex
			echo "	\\\\vspace{-1em}" >> $filename_with_tex
			echo "	\\\\begin{flushright}" >> $filename_with_tex
			echo "		\\\\item\\\\frqq\\\\textsl{#1}\\\\flqq\ " >> $filename_with_tex
			echo "	\\\\end{flushright}" >> $filename_with_tex
			echo "	\\\\nopagebreak" >> $filename_with_tex
			echo "	\\\\hfill ---\\\\,\\\\textsc{#2}\\\\newline" >> $filename_with_tex
			echo "	\\\\vspace{-1em}" >> $filename_with_tex
			echo "}" >> $filename_with_tex
			echo "" >> $filename_with_tex
			echo "\\\\newcommand{\\\\centeredquoteunknownsource}[1]{" >> $filename_with_tex
			echo "	\\\\hbadness=5000" >> $filename_with_tex
			echo "	\\\\vspace{-1em}" >> $filename_with_tex
			echo "	\\\\begin{quotation}" >> $filename_with_tex
			echo "		\\\\begin{flushright}" >> $filename_with_tex
			echo "			\\\\item\\\\frqq\\\\textsl{#1}\\\\flqq\\\\ " >> $filename_with_tex
			echo "		\\\\end{flushright}" >> $filename_with_tex
			echo "	\\\\end{quotation}" >> $filename_with_tex
			echo "	\\\\vspace{-1em}" >> $filename_with_tex
			echo "}" >> $filename_with_tex
		fi

		echo "\\\\usepackage[utf8]{inputenc}" >> $filename_with_tex
		echo "\\\\usepackage[T1]{fontenc}" >> $filename_with_tex
		echo "\\\\usepackage[sc,osf]{mathpazo}" >> $filename_with_tex
		echo "\\\\usepackage{fourier}" >> $filename_with_tex
		echo "\\\\usepackage{soulutf8}" >> $filename_with_tex
		echo "\\\\usepackage{graphicx}" >> $filename_with_tex
		echo "\\\\usepackage{amsmath}" >> $filename_with_tex
		echo "\\\\usepackage{amssymb}" >> $filename_with_tex
		echo "\\\\usepackage[ngerman]{babel}" >> $filename_with_tex
		echo "" >> $filename_with_tex
		echo "\\\\emergencystretch2em" >> $filename_with_tex
		echo "" >> $filename_with_tex
		if [[ -e "literatur.bib" || -e "../literatur.bib" ]]; then
			echo "\\\\usepackage[" >> $filename_with_tex
			echo "	citestyle=authortitle-ibid," >> $filename_with_tex
			echo "	isbn=true," >> $filename_with_tex
			echo "	url=true,">> $filename_with_tex
			echo "	backref=true," >> $filename_with_tex
			echo "	backrefstyle=none," >> $filename_with_tex
			echo "	pagetracker=true," >> $filename_with_tex
			echo "	maxbibnames=50," >> $filename_with_tex
			echo "	defernumbers=true," >> $filename_with_tex
			echo "	maxcitenames=10," >> $filename_with_tex
			echo "	backend=bibtex," >> $filename_with_tex
			echo "	urldate=comp," >> $filename_with_tex
			echo "	dateabbrev=false," >> $filename_with_tex
			echo "	sorting=nty" >> $filename_with_tex
			echo "]{biblatex}" >> $filename_with_tex
			if [[ -e "literatur.bib" ]]; then
				echo "\\\\bibliography{literatur.bib}" >> $filename_with_tex
			else
				echo "\\\\bibliography{../literatur.bib}" >> $filename_with_tex
			fi
		fi

		echo "" >> $filename_with_tex
		echo "\\\\begin{document}" >> $filename_with_tex
		if [[ ! -z $AUTHORNAME ]]; then
			echo "\\\\author{$AUTHORNAME}" >> $filename_with_tex
		fi
		if [[ ! -z $TITLE ]]; then
			echo "\\\\title{$TITLE}" >> $filename_with_tex
		fi
		echo "" >> $filename_with_tex
		if [[ "$DOCUMENTCLASS" = "beamer" ]]; then
			echo "\\\\frame{" >> $filename_with_tex
			echo "	\\\\begin{itemize}[<+->]" >> $filename_with_tex
			echo "		\\\\item Items will be shown step" >> $filename_with_tex
			echo "		\\\\item by step" >> $filename_with_tex
			echo "		\\\\item step" >> $filename_with_tex
			echo "	\\\\end{itemize}" >> $filename_with_tex
			echo "}" >> $filename_with_tex
			echo "" >> $filename_with_tex

			echo "\\\\frame{" >> $filename_with_tex
			echo "	\\\\begin{itemize}" >> $filename_with_tex
			echo "		\\\\item Items will be shown all" >> $filename_with_tex
			echo "		\\\\item at" >> $filename_with_tex
			echo "		\\\\item once" >> $filename_with_tex
			echo "	\\\\end{itemize}" >> $filename_with_tex
			echo "}" >> $filename_with_tex
			echo "" >> $filename_with_tex
		fi
		echo "" >> $filename_with_tex # In the second last fully empty line the cursor will jump to automagically with $LINE_TO_JUMP_TO
		echo "" >> $filename_with_tex # and this line.
		echo "\\\\end{document}" >> $filename_with_tex

		LINE_TO_JUMP_TO=$(grep -nP '^$' $filename_with_tex | tail -n2 | head -n1 | sed -e 's/://')

		if [[ "$EDITOR" == "vim" ]]; then
			$EDITOR +${LINE_TO_JUMP_TO} $filename_with_tex
		elif [[ "$EDITOR" == "kate" ]]; then
			$EDITOR -l ${LINE_TO_JUMP_TO} $filename_with_tex
		else
			$EDITOR $filename_with_tex
		fi

		COMMAND="latexmk -pdf -halt-on-error $filename.tex && evince $filename.pdf"
		echo "$COMMAND" | xclip -selection c
		echo "$COMMAND"
		echo "(This command has been copied to your clipboard. Press CTRL-Shift-V to insert it now.)"
	else
		echo "User selected Cancel."
	fi
}

alias lt="latextemplate"

function youtube_playlist_previewer {
        PLAYLIST=$1

        TMPFILE=$RANDOM.txt

        youtube-dl -j --flat-playlist $PLAYLIST | jq -r '.id' > $TMPFILE

        FILENAME=index.html

        echo "<head>" > $FILENAME
        echo "<style>#images{ text-align:center; margin:50px auto; }" >> $FILENAME
        echo "#images a{margin:0px 20px; display:inline-block; text-decoration:none; color:black; }" >> $FILENAME
        echo ".caption { width: 150px; height: 80px; overflow-y: auto; }" >> $FILENAME
        echo "</style>" >> $FILENAME
        echo '<meta charset="UTF-8">' >> $FILENAME
        echo "</head>" >> $FILENAME
        echo '<div id="images">' >> $FILENAME

        cat $TMPFILE  | perl -lne 'while (<>) { 
                chomp; 
                $id = $_; 
                $title = q##;
                if(!-e qq#.$id# || -z qq#.$id#) {
                        system(qq#youtube-dl --get-filename -o "%(title)s" -- $id > .$id#);
                }
                $title = qx(cat .$id);
                print qq#<a href="https://youtube.com/watch?v=$id"><img src="https://i.ytimg.com/vi/$id/hqdefault.jpg" width="150px"><div class="caption">$title</div></a>\n#;
        }' >> $FILENAME

        echo "</div>" >> $FILENAME

        rm $TMPFILE
}

function clean_latex_tmp_files {
	rm *.aux
	rm *.nav
	rm *.out
	rm *.snm
	rm *.toc
	rm *.fdb_latexmk
	rm *.fls
	rm *.log
}

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

function "$" () { $@ }

function mc () {
	mkdir $1
	cd $1
}


function forceumountcifs () { sudo umount -a -t cifs -l }

function jc {
	(for i in *.java; do 
		md5sum_filename=".$(echo $i | md5sum | sed -e 's/\s*-//')"
		md5sum_content="$(cat $i | md5sum | sed -e 's/\s*-//')"
		RECOMPILE=0
		if [[ -e $md5sum_filename ]]; then
			if [[ $(cat $md5sum_filename) =~ "$md5sum_content" ]]; then
				RECOMPILE=0
			else
				RECOMPILE=1
			fi
		else
			RECOMPILE=1
		fi

		echo "$i:"
		if [[ "$RECOMPILE" == "1" ]]; then
			javac $i
			echo $md5sum_content > $md5sum_filename
		else
			echo "No need for recompiling";
			echo $md5sum_content > $md5sum_filename
		fi

	done)
}

acs () {
	apt-cache search $1
}

function arp {
	let i=0 # define counting variable
	W=() # define working array
	while read -r line; do # process file by file
		let i=$i+1
		W+=($i "$line")
	done < <(ls -1 /sys/class/net)
	FILE=$(dialog --title "Available network devices for ARP-scan" --menu "Chose one" 24 80 17 "${W[@]}" "q" "quit" 3>&2 2>&1 1>&3)
	clear
	if [ $? -eq 0 ]; then
		if [[ "$FILE" =~ "quit" ]]; then
			return 0
		fi
		RESULT=$(ls -1 /sys/class/net | head -n $(($FILE)) | tail -n1)
	else
		return $?
	fi

	if [[ ! -z $RESULT ]]; then
		if [[ -e /sys/class/net/$RESULT ]]; then
			sudo arp-scan --interface=$RESULT --localnet

			echo "Press any key to continue"
			while [ true ] ; do
				read -t 3 -n 1
				if [ $? = 0 ] ; then
					arp
				else
					return
				fi
			done
		else
			return 0
		fi
	else
		return 0
	fi
}


cut_domian() {
	set -x
	id=$1
	from=$2
	to=$3

	outputfilename=$(whiptail --inputbox "Name of the file?" 8 39 "Domian, " --title "cut_domian" 3>&1 1>&2 2>&3)
	if [[ $? != 0 ]]; then
		return;
	fi
	# Domian, Daniel (18) ist Daniel.
	outputfilename=$(echo $outputfilename | sed -e 's/\.+$//' | sed -e 's/ (/, /g' | sed -e 's/) /, /')
	outputfilename="$outputfilename.mp4"

	TMPFILEYTDL=".$RANDOM.mp3"
	youtube-dl -i -x --audio-format mp3 --audio-quality 0  $1 --output=$TMPFILEYTDL

	if [[ ! -e domian.jpg ]]; then
		wget optimalbliss.de/domian.jpg
	fi


	set -x

	TMPFILEFFMPEG=.$RANDOM.mp3
	ffmpeg -i $TMPFILEYTDL -ss "$from" -to "$to" $TMPFILEFFMPEG

	ffmpeg -loop 1 -i domian.jpg -i $TMPFILEFFMPEG -c:a copy -c:v libx264 -shortest $outputfilename

	rm $TMPFILEFFMPEG $TMPFILEYTDL
	echo $outputfilename
}

audiodomian () {
	set -x
	inputfile=$1

	# Domian_2006-10-03.lq.ogg 
	outputfilename="$(echo $inputfile | sed -e 's/.*\///' | sed -e 's/-/./g' | sed -e 's/_/ - /g' | sed -e 's/\.[hl]q\.ogg//' | sed -E 's/([0-9]{4})\.([0-9]{1,2})\.([0-9]{1,2})/\3.\2.\1/').mp4"

	if [[ -z $inputfile ]]; then
		echo "First parameter cannot be empty, must be existing audio file"
		return
	fi


	if [[ ! -e $inputfile ]]; then
		echo "First parameter cannot be empty, must be existing audio file"
		return
	fi

	if [[ ! -e domian.jpg ]]; then
		wget optimalbliss.de/domian.jpg
	fi

	ffmpeg -loop 1 -i domian.jpg -i $inputfile -c:a copy -c:v libx264 -shortest $outputfilename

	set +x
	notify-send "$outputfilename"
}

audiodomiandir () {
	for i in $(ls *.hq.ogg); do
		audiodomian $i
	done
	for i in $(ls *.lq.ogg); do
		audiodomian $i
	done
}

function scan_here () {
        max_number=$(ls | grep out | grep jpg | sed -e 's/out//' | sed -e 's/\.jpg//' | sort -nr | head -n1)
        STARTPDF=$(echo "$max_number+1" | bc)
        echo "Starting at $STARTPDF"
        scanimage --batch --batch-start=$STARTPDF --source="ADF Duplex" --resolution 300 --format=jpeg --mode Color
}

function move_empty_scanned_pages {
        if [[ "$NOMOVE" -eq "1" ]]; then
                return
        fi

        echo "Run with 'export NOMOVE=1' to disable auto-moving blank pages"

        mkdir -p "blanks"

        for i in $(ls *.jpg); do
                echo "${i}"
                if [[ -e $(dirname "$i")/.$(basename "$i") ]]; then
                        echo "   protected."
                        continue
                fi

                histogram=$(convert "${i}" -threshold 50% -format %c histogram:info:-)
                #echo $histogram
                white=$(echo "${histogram}" | grep "white" | cut -d: -f1)
                black=$(echo "${histogram}" | grep "black" | cut -d: -f1)
                if [[ -z "$black" ]]; then
                        black=0
                fi

                #blank=$(echo "scale=4; ${black}/${white} < 0.005" | bc)
                #echo $white $black $blank
                #if [ "${blank}" -eq "1" ]; then
                if [ "${black}" -lt "100" ]; then
                        echo "${i} seems to be blank - removing it..."
                        mv "${i}" "blanks/${i}"
                fi
        done
}

function ocr_this_folder () {
        for file in *.jpg; do
                pdfname=$(echo $file | sed -e 's/\..*//');
                if [[ ! -e "$pdfname.pdf" ]]; then
                        if [[ ! -e ".$pdfname.pdf_working_on" ]]; then
                                touch ".$pdfname.pdf_working_on"
                                tesseract -l deu $file "$pdfname" pdf;
                                echo "$pdfname.pdf done"
                        fi
                else
                        echo "$pdfname.pdf already exists"
                fi
        done
}

function merge_all_out_pdfs {
        outname=gesamt.pdf
        i=1
        while [[ -e "$outname" ]]; do
                outname="gesamt_${i}.pdf"
                i=$(echo "$i+1" | bc)
        done
        pdftk *.pdf cat output gesamt.pdf
}

function pn { set -x; for var in "$@"; do play -qn synth 2 pluck $var & sleep 0.25; done; set +x; wait }

function _vlc {

        VIDEOS=()

        IFS=$'\n'
        for line in $(ls **/*.mp4 **/*.MP4 **/*.mp3 **/*.MP3 **/*.OGV **/*.ogv *.mp4 *.mp3 *.ogv *.MP4 *.MP3 *.OGV); do
                VIDEOS+=("$line")
        done

        FILES=$(printf "\n'%s'" "${VIDEOS[@]}")

        eval "_describe 'command' \"($FILES)\""
}


compdef _vlc "vlc"

upgr () {
        sudo apt-get update && sudo apt-get -y upgrade
}
