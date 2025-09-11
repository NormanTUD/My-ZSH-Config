syntax on "enables syntax-highlighting
filetype on "looks on filetype for syntax-highlight
filetype indent on " ???
filetype plugin on " ???

"Tab-Functions
"Enables CTRL x as close-tab-shortcut
map <C-x> :tabclose<CR>
"Enables writing with CTRL w
map <C-w> :w<CR>
"Enables F5 to autoset filetype to 'perl'
map <F5> :set filetype=perl <CR>
"Enables ,t to create a  new tab
map ,t :tabnew<CR>
"Enables CTRL c for next tab
map <C-c> :tabnext<CR>
"Enables CTRL y for previous tab
map <C-Y> :tabprev<CR>

set background=dark "Good for dark screens
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%) "Defines a useful Ruler (%filename %Date_and_time %line_and_character_of_cursor ???)
set showmode "???
set encoding=utf8
set number "Enables numbers at the left
set modeline "???
set ls=2 "???
set backspace=2 "???
set backup "???
set cmdheight=1 "Height of the command line
set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:- "???
set completeopt=menuone,longest "???
set magic "For regular expressions turn magic on
set incsearch "Makes search act like search in modern browsers
set complete-=i "???
set fillchars=vert:\ ,stl:\ ,stlnc:\ , "???
set hidden "???
set history=500
set hlsearch "Forwardsearch
set ignorecase "Ignore case on search
set incsearch " ???
set laststatus=2 "???
set lazyredraw "???
set linebreak "???
set listchars=precedes:$,extends:$,tab:>-,trail:.,eol:< "???
set mouse=nvi "Enables mouse support
set ruler "Enables ruler
set scrolloff=1 "???
set showcmd "???
set sidescroll=5 "???
set smartcase "???
set softtabstop=8 "???
set switchbuf=useopen,usetab "???
set whichwrap=<,>,h,l,[,] "???
set wildignore=*.o,*.obj,*.exe,*~,moc_* "???
set wildmode=list:longest,full "???
set wrap "Wrap long lines
set cursorcolumn "???
set cursorline "???
set showmatch "Show search matches
set smartindent "???
setlocal spelllang=de "???
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
nmap <F1> <nop>
set nospell
set nobackup
set nowb
set noswapfile
set smarttab
set ai "Auto indent
set si "Smart indent
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"filetype indent on
"filetype plugin on
"filetype on
"let g:tex_flavor='latex'
"set grepprg=grep\ -nH\ $*
 
"let g:Tex_Folding=0 "I don't like folding.
"set iskeyword+=:
"
"
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.

nnoremap <F5> :GundoToggle<CR>
set title
set wildmenu
set wildmode=list:longest

set backupdir=~/vimtmp,.
set directory=~/vimtmp,.
set colorcolumn=800

let g:colorizer_auto_color = 1
set autoindent

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

set runtimepath+=~/.vim_runtime

function MyCalc(str)
  if exists("g:MyCalcRounding")
    return system("echo 'x=" . a:str . ";d=.5/10^" . g:MyCalcPresition
          \. ";if (x<0) d=-d; x+=d; scale=" . g:MyCalcPresition . ";print x/1' | bc -l")
  else
    return system("echo 'scale=" . g:MyCalcPresition . " ; print " . a:str . "' | bc -l")
  endif
endfunction

" Control the precision with this variable
let g:MyCalcPresition = 2
" Comment this if you don't want rounding
let g:MyCalcRounding = 1
" Use \C to replace the current line of math expression(s) by the value of the computation:
map <silent> <Leader>c :s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c :B s/.*/\=MyCalc(submatch(0))/<CR>:noh<CR>
" With \C= don't replace, but add the result at the end of the current line
map <silent> <Leader>c= :s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Same for a visual selection block
vmap <silent> <Leader>c= :B s/.*/\=submatch(0) . " = " . MyCalc(submatch(0))/<CR>:noh<CR>
" Try: :B s/.*/\=MyCalc("1000 - " . submatch(0))/
" The concatenation is important, since otherwise it will try
" to evaluate things like in ":echo 1000 - ' 1748.24'"
vmap <Leader>c+ :B s/.*/\=MyCalc(' +' . submatch(0))/<C-Left><C-Left><C-Left><Left>
vmap <Leader>c- :B s/.*/\=MyCalc(' -' . submatch(0))/<C-Left><C-Left><C-Left><Left>
" With \Cs you add a block of expressions, whose result appears in the command line
vmap <silent> <Leader>ct y:echo MyCalc(substitute(@0," *\n","+","g"))<CR>:silent :noh<CR>
" Try: :MyCalc 12.7 + sqrt(98)
command! -nargs=+ MyCalc :echo MyCalc("<args>")

function FrameItemize (...)
	:normal o\frame{
	let total = a:1
	let stepbystep = 0
	if a:0 == 2
		let stepbystep = 1
	endif
	if total > 0
		:normal o\begin{itemize}
		if stepbystep
			:normal a[<+->]
		endif
		let cnt = 1
		echom total
		while cnt <= total
			:normal o\item 
			let cnt += 1
		endwhile
		:normal o\end{itemize}
	endif
	:normal o}
	:normal o
endfunction


function Enumerate (...)
	let total = a:1
	if total > 0
		:normal o\begin{enumerate}
		let cnt = 1
		echom total
		while cnt <= total
			:normal o\item 
			let cnt += 1
		endwhile
		:normal o\end{enumerate}
	endif
endfunction

function Itemize (...)
	let total = a:1
	if total > 0
		:normal o\begin{itemize}
		let cnt = 1
		echom total
		while cnt <= total
			:normal o\item 
			let cnt += 1
		endwhile
		:normal o\end{itemize}
	endif
endfunction


function Section(name)
	execute ":normal a\\section{". a:name ."}"
	:normal o
endfunction

function SubSection(name)
	execute ":normal a\\subsection{". a:name ."}"
	:normal o
endfunction

function FrameImage(filename)
	:normal o\frame{
	execute ":normal o\\includegraphics[width=\\textwidth]{". a:filename ."}"
	:normal o}
endfunction

function FrameImageCaption(filename, caption)
	:normal o\frame{
	execute ":normal o\\includegraphics[width=\\textwidth]{". a:filename ."}"
	execute ":normal o\\caption{". a:caption."}"
	:normal o}
endfunction

nnoremap <F2> :call FrameItemize(input('Number of items: '))<CR>
nnoremap <F3> :call FrameItemize(input('Number of items (step by step): '), 1)<CR>

nnoremap <F4> :call Section(input('Section name: '))<CR>
nnoremap <F5> :call SubSection(input('Subsection name: '))<CR>

nnoremap <F6> :call Itemize(input('Number of items: '))<CR>
nnoremap <F7> :call Enumerate(input('Number of items: '))<CR>

nnoremap <F8> :call FrameImage(input('Filename: '))<CR>
nnoremap <F9> :call FrameImageCaption(input('Filename: '), input("Caption: "))<CR>

" keep text selected when doing > and < to indent
tnoremap <Esc> <C-\><C-n>
noremap < <gv
noremap > >gv

call plug#begin('~/.vim/plugged')

" Mistfly Statusline
Plug 'bluz71/vim-mistfly-statusline'

call plug#end()

let g:mistfly_theme = 'gruvbox'  " optional, anderes Farbschema
set laststatus=2                " Statusline immer anzeigen

call plug#begin('~/.vim/plugged')

" Statusline
Plug 'bluz71/vim-mistfly-statusline'

" Fuzzy Finder
Plug 'junegunn/fzf.vim'

" Auto-Pairs & Surround
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Python Autocomplete & Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvie/vim-flake8'

call plug#end()
