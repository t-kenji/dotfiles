" system settings {{{
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,euc-jisx0213,sjis
set fileformats=unix,dos,mac
set formatoptions+=mm
set pastetoggle=
set nobackup
set noswapfile
set history=1000
" }}}

" style settings {{{
colorscheme elflord
syntax on
set number
set cursorline
set cursorcolumn
set list
set listchars=tab:».,trail:_,extends:»,precedes:«,nbsp:%
if exists('&ambiwidth')
  set ambiwidth=double
endif
set showmatch
set ruler
set scrolloff=5
set sidescrolloff=16
set sidescroll=1
set laststatus=2
set showmode
set showcmd
" }}}

" search settings {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault
" }}}

" tab control settings {{{
" prefix key
nnoremap [Tag] <Nop>
nmap t [Tag]
" tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" tab navigation
map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>
" }}}
