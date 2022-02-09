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

" Use the elflord color scheme.
colors elflord

" Enable syntax highlighting.
syntax on

" Store temporary files in .vim to keep the working directories clean.
set directory=~/.vim/swap
set undodir=~/.vim/undo

" Enable mouse support.
set mouse=a

" Enable persistent undo.
set undofile

" Use incremental search and highlight as we go.
set hlsearch
set incsearch

" Search should be case insensitive unless containing uppercase characters.
set ignorecase
set smartcase

" Show line numbers as relative so relative navigation is easier. Show actual
" line number for active line.
set relativenumber
set number

" Show line and character number in lower right hand corner.
set ruler

" Only insert a single space after punctuations when using the automatic
" formatter (via dq).
set nojoinspaces

" Increase history for search and command line entries.
set history=10000

" Highlight the active line and the active column.
set cursorline
set cursorcolumn
highlight CursorColumn ctermbg=lightcyan ctermfg=black

" Set the text width to 80 and create a vertical bar in 81st column. Some
" filetypes such as gitcommit have a custom width defined and we use autocmd
" here so our textwidth value takes precedence.
autocmd FileType * setlocal textwidth=80
set colorcolumn=81

" By default, set the spell checker language to English. Use <leader>l and
" <leader>L to change to Spanish and English respectively. For both, ignore
" Chinese characters.
set spelllang=en,cjk
nnoremap <leader>l :setlocal spelllang=it,cjk<cr>
nnoremap <leader>L :setlocal spelllang=en,cjk<cr>
