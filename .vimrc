" Map Colemak keys in alphabetical order.
noremap d g
noremap e k
noremap f e
noremap g t
noremap i l
noremap j y
noremap k n
noremap l u
noremap n j
noremap o p
noremap p r
noremap r s
noremap s d
noremap t f
noremap u i
noremap y o
noremap D G
noremap E K
noremap F E
noremap G T
noremap I L
noremap J Y
noremap K N
noremap L U
noremap N J
noremap O P
noremap P R
noremap R S
noremap S D
noremap T F
noremap U I
noremap Y O
noremap dd gg
noremap df ge
noremap dF gE

" Essentials
set number
set title
set autoindent
set showcmd
set cmdheight=1
set shiftwidth=2
set mouse=a
set undofile
set backspace=indent,eol,start

" Store temporary files in .vim to keep the working directories clean.
set directory=~/.vim/swap
set undodir=~/.vim/undo
set history=10000

" Use Windows clipboard to copy and to paste
set clipboard=unnamed

" Use Y to copy into clipboard
nnoremap Y "+y
vnoremap Y "+y
nnoremap yY ^"+y$

" Use D to cut into clipboard
nnoremap D "+d
vnoremap D "+d
nnoremap dD ^"+d$
