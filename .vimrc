
" Required vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My plugins
"Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'gcmt/wildfire.vim'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'sdanielf/vim-stdtabs'
Bundle 'bling/vim-airline'
if has('lua')
    Bundle 'Shougo/neocomplete'
endif
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'vim-scripts/taglist.vim'
"Bundle 'jcf/vim-latex'
Bundle 'git://git.code.sf.net/p/atp-vim/code'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'wesQ3/vim-windowswap'

" To update run: vim +BundleClean! +BundleInstall! +all +qa

" Execute vundle
filetype plugin indent on

" Setup status bar
set encoding=utf8
set laststatus=2

" Let airline know we have powerline patched fonts available
let g:airline_powerline_fonts = 1

" Do some special things for GVim/MacVim only
if has('gui_running')
    " Add a touch of breathing room per line
    set linespace=2

    " Request powerline patched font
    if has('gui_gtk2')
        set guifont=Liberation\ Mono\ for\ Powerline\ 10
    elseif has('gui_win32')
        " TODO: pick out windows font
    elseif has('gui_macvim')
        set guifont=Literation\ Mono\ Powerline:h12
        set transparency=15
    endif
endif

" Setup NeoComplete
if has('lua')
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
endif

" Show leader as typed (used for gitgutter)
set showcmd

" Shut up
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if &diff
    colorscheme ps_color
else
    "colorscheme torte
    colorscheme vividchalk
endif

set guioptions=mraAeigt

map - \cn
map _ \cu

map Q <Nop>

if !exists("*SudoWrite")
    function SudoWrite()
        silent w !sudo tee % > /dev/null
        e! %
    endfunction
endif

cmap w!! call SudoWrite()

let g:tex_flavor = "latex"

set mouse=a

" http://www.vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv

" http://www.vimbits.com/bits/11
map Y y$

" http://www.vimbits.com/bits/25
nnoremap j gj
nnoremap k gk

" http://www.vimbits.com/bits/21
noremap <silent><Leader>/ :nohls<CR>

" https://gist.github.com/nocash/1988620
augroup AutoReloadVimRC
  au!
  " automatically reload vimrc when it's saved
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" http://www.vimbits.com/bits/90
"let mapleader = ","

" http://www.vimbits.com/bits/92
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" http://www.vimbits.com/bits/30
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" http://www.vimbits.com/bits/170
au InsertLeave * set nopaste

" http://www.vimbits.com/bits/173
autocmd FileType gitcommit DiffGitCached | wincmd p

" http://www.vimbits.com/bits/223
au VimResized * exe "normal! \<c-w>="

" http://www.vimbits.com/bits/13
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" http://www.vimbits.com/bits/176
nmap <leader>o o<ESC>k
nmap <leader>O O<ESC>j

" http://www.vimbits.com/bits/229
autocmd BufRead COMMIT_EDITMSG setlocal spell!

" http://www.vimbits.com/bits/125
"nnoremap ; :

set matchpairs+=�:�
set matchpairs+=«:»

" Use system clipboard for anonymous register
set clipboard=unnamed

" Enable backspace over indent,eol,start,etc
set backspace=2

" Highlight search results
set hlsearch

" Do incremental search
set incsearch

" Ignore case of search unless they have a capital
set ignorecase
set smartcase

" Give context when scrolling
set scrolloff=1

" Keep lots of command history
set history=1000

" Show ruller at bottom
set ruler

" Enably syntax coloring and related features
syntax on

" Highlight matchign brackets
set showmatch

" Easy motino bindings ala https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" CTRL-P files ala https://github.com/kien/ctrlp.vim
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Swap windows around between panes
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

" << refactored to here

set fencs=utf8,cp1254,latin1
"set autoindent
"set smartindent
"set smarttab
"set cindent
" set tabstop=4
" set shiftwidth=4
set infercase
set shiftround
set wildmenu
"set nowrap
set backup
set backupskip=
set backupdir=.
set nostartofline
set fo+=r
"set list
"set listchars=tab:>-
set ttymouse=xterm2
set splitright
set shell=zsh

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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

"map <tab> >>	"indent when not in edit mode
"map <tab> >>	"indent when not in edit mode

" imap <C-g> <C-x><C-f>	" File complete on ctrl g

" alt+: on most machines
map � :
imap � <Esc><Esc>:

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
""     else
"         return "\<C-X>\<C-O>"
"     endif
" endfunction
" inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

set nowrap

if !exists("*FirstInPost")
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
endif

" Command to be called.
com Fip :set nosmartindent<Bar>:set tw=0<Bar>:%call FirstInPost()

if !exists("*VeryBeautyQuote")
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
endif

" Execute this command to beautifully rearrange the quoted lines.
com Vbq :let strl = line('.')<Bar>:%call VeryBeautyQuote()<Bar>:exec strl

"let fileType = &ft
"if fileType == 'php'
"    iab _S $_SERVER[']hi
"    iab _P $_POST[']hi
"    iab _G $_GET[']hi
"endif

" vim: ts=30 sw=4
