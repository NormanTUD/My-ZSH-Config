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

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

