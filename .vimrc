" Required vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My plugins
Bundle 'gcmt/wildfire.vim'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'sdanielf/vim-stdtabs'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/neocomplete'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdcommenter'

" Execute vundle
filetype plugin indent on

" Setup status bar
set encoding=utf8
set laststatus=2
let g:airline_powerline_fonts = 1
if has('autocmd')
    autocmd GUIEnter * set guifont=Liberation\ Mono\ for\ Powerline\ 12
endif

" Setup NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
set completeopt+=longest
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" Show leader as typed (used for gitgutter)
set showcmd

" Shut up
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

colorscheme vividchalk
map - \cn
map _ \cu

" << refactored to here

" set nofoldenable
set fencs=utf8,cp1254,latin1
set autoindent
set smartindent
set showmatch	"show matchign brackets
"set smarttab
"set cindent
set smartcase
" set tabstop=4
" set shiftwidth=4
syntax on
set infercase
set nohlsearch
set matchpairs+=«:»
set shiftround
set wildmenu
set nowrap
set backup
set backupskip=
set backupdir=.
set history=1000
set ruler	"show ruller at bottom
set scrolloff=1	"give context when scrolling
set hlsearch	"highlight search results
set backspace=2	"smart backspace
set nostartofline
set fo+=r
"set list
"set listchars=tab:>-
set ttymouse=xterm2
set splitright
set shell=zsh

nnoremap gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nmap I :set paste<Cr>i
"<esc>I sets paste mode
nmap i :set nopaste<Cr>i
"<esc>i clears paste mode

let fileType = &ft
if fileType == 'php'
    set kp=/home/users/caleb/bin/phpman
    "iab _S $_SERVER[']i
    "iab _P $_POST[']i
    "iab _G $_GET[']i
endif

":command! -nargs=+ Calc :py print <args>
":py from math import *
:command! -nargs=+ Calc :r! python -c "from math import *; print <args>"

"map ' `	" switch mark jumps so ' goes to column
"map ` '	" and ` goes to row

"map <space> i_<esc>r
map <space> <C-d>

map <tab> >>	"indent when not in edit mode
"map <tab> >>	"indent when not in edit mode

" imap <C-g> <C-x><C-f>	" File complete on ctrl g

" alt+: on most machines
map » :
imap » <Esc><Esc>:

" alt+: on rhino
map ; :
map ; <Esc><Esc>:

map <M-;> :
imap <M-;> <Esc><Esc>:

map <F5> :set hls!<bar>set hls?<CR>

if &filetype == ""
"   setfiletype text
    source ~/.vim/notepad.vim
endif

if &filetype == "mail"
    set nosmartindent
endif

" function MyTabOrComplete()
"     let col = col('.')-1
"     if !col || getline('.')[col-1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<C-X>\<C-O>"
"     endif
" endfunction
" inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

set nowrap

function FirstInPost (...) range
  let cur = a:firstline
  while cur <= a:lastline
    let str = getline(cur)
    if str == 'Subject: '
      execute cur
      :start!
      break
    endif
    if str == 'To: '
      execute cur
      :start!
      break
    endif
    " We have reached the end of the headers.
    if str == ''
        :start
        normal gg/\n\njyypO
        break
    endif
  let cur = cur + 1
  endwhile
endfunction

" Command to be called.
com Fip :set nosmartindent<Bar>:set tw=0<Bar>:%call FirstInPost()

function VeryBeautyQuote (...) range
  " The regular expression used to match quoted lines.
  " NOTE: modify this regexp if you have special needs.
  let re_quote = '^>\(\a\{-,3}[>|]\|[> \t|]\)\{,5}'
  set report=30000 " do not report the number of changed lines.
  let cur = a:firstline
  while cur <= a:lastline
     let str = getline(cur)
     " Match the quote.
     let comm = matchstr(str, re_quote)
     let newcomm = comm
     let commlen = strlen(comm)
     let filelen = line('$')
     if commlen > 0
       let startl = cur
       while newcomm == comm
         " Strip the quote from this group of quoted lines.
         let txt = substitute(str, re_quote, '', '')
         call setline(cur, txt)
         let cur = cur + 1
         let str = getline(cur)
         let newcomm = matchstr(str, re_quote)
       endwhile
       let cur = cur - 1
       " Execute fmt for format the (un-)quoted lines.
       " NOTE: you can call any other formatter that act like a command line
       "       filter.
       " NOTE: 72 is the maximum length of a single line, including
       "       the length of the quote.
       execute startl . ',' . cur . '!fmt -' . (72 - commlen)
       " If the length of the file was changed, move the cursor accordingly.
       let lendiff = filelen - line('$')
       if lendiff != 0
         let cur = cur - lendiff
       endif
       " Restore the stripped quote.
       execute startl . ',' . cur . 's/^/' . comm . '/g'
     endif
   let cur = cur + 1
  endwhile
endfunction

" Execute this command to beautifully rearrange the quoted lines.
com Vbq :let strl = line('.')<Bar>:%call VeryBeautyQuote()<Bar>:exec strl

"let fileType = &ft
"if fileType == 'php'
"    iab _S $_SERVER[']hi
"    iab _P $_POST[']hi
"    iab _G $_GET[']hi
"endif

" vim: ts=30 sw=4

