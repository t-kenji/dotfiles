" system settings {{{
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
"set fileencodings=utf-8,iso-2022-jp,euc-jp,euc-jisx0213,sjis
set fileencodings=utf-8,euc-jp,sjis
set fileformats=unix,dos,mac
set formatoptions+=mm
set pastetoggle=
set clipboard=unnamed,unnamedplus,autoselect
set lazyredraw
set nobackup
set noswapfile
set history=1000
set hidden                          " バッファを切り替えても undo の効力を破棄しない
set switchbuf=useopen
" }}}

" statusline settings {{{
set showmode
set showcmd
set statusline=[%n]                   " バッファ番号表示
set statusline+=%{g:gitCurrentBranch} " Git のブランチ名表示
set statusline+=%F                    " ファイル名表示
set statusline+=%m                    " 変更チェック表示
set statusline+=%r                    " 読み込み専用チェック表示
set statusline+=%h                    " ヘルプページチェック表示
set statusline+=%w                    " プレビューウィンドウチェック表示
set statusline+=%=                    " 以降右寄せ表示
set statusline+=[COL=%v,LOW=%l/%L]    " 現在/全体行数表示
set statusline+=[%{&fenc},%{&ff}]     " エンコーディング,フォーマット表示
set laststatus=2

"挿入モード時、ステータスラインの色を変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=darkgreen ctermbg=lightgreen cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" git のブランチを表示
let g:gitCurrentBranch = ''
function! GitCurrentBranch()
    let cwd = getcwd()
    cd %:p:h
    let branch = matchlist(system('/usr/bin/env git branch -a --no-color'), '\v\* ([0-9A-Za-z\/]*)\r?\n')
    execute 'cd '.cwd
    if (len(branch))
        let g:gitCurrentBranch = '[git:'.branch[1].']'
    else
        let g:gitCurrentBranch = ''
    endif
    return g:gitCurrentBranch
endfunction
autocmd BufEnter * :call GitCurrentBranch()
" }}}

" style settings {{{
set t_Co=256
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
set scrolloff=5
set sidescrolloff=16
set sidescroll=1
if v:version >= 800
    set emoji         " 絵文字を全角として扱う
    set fixendofline  " ファイル末尾に <EOL> をつける
    "set termguicolors " ターミナルで GUI カラーを使う
endif
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

" ,nn で相対/絶対行表示の切り替え {{{
function Num_switch()
    if &relativenumber == '1'
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
nmap ,nn :call Num_switch()<CR>
" }}}

"" Gtags settings {{{
"nmap <C-g> :Gtags -g <C-r><C-w>
"nmap <C-h> :Gtags -f %<CR>
"nmap <C-j> :GtagsCursor<CR>
"nmap <C-n> :cn<CR>
"nmap <C-p> :cp<CR>
"" }}}
