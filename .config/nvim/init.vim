" Manage plugins with vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin()

" My plugins
"Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-abolish'
Plug 'gcmt/wildfire.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sdanielf/vim-stdtabs'
Plug 'bling/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
"Plug 'vim-scripts/taglist.vim'
"Plug 'jcf/vim-latex'
"Plug 'git://git.code.sf.net/p/atp-vim/code'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Lokaltog/vim-easymotion'
Plug 'wesQ3/vim-windowswap'
Plug 'sheerun/vim-polyglot'
Plug 'lordm/vim-browser-reload-linux'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tommcdo/vim-exchange'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
Plug 'brookhong/DBGPavim'
"Plug 'editorconfig/editorconfig-vim'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf'
"Plug 'floobits/floobits-neovim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/RelOps'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'benmills/vimux'
Plug 'swekaj/php-foldexpr.vim'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-wordy'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-sentence'
Plug 'alerque/vim-sile'
Plug 'severin-lemaignan/vim-minimap'
Plug '907th/vim-auto-save'
Plug 'lervag/vimtex'
Plug 'gisraptor/vim-lilypond-integrator'
Plug 'trusktr/seti.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-markdownfootnotes'
Plug 'benekastah/neomake'
call plug#end()

" Default indent style when no filetype specific style guide is in place
set tabstop=4
set shiftwidth=4
set noexpandtab
set cindent
set autoindent
" Setup discraction free mode including tmux integration and limelight
let g:goyo_width = 80
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
let g:limelight_default_coefficient = 0.3

nnoremap <Leader>r :Goyo<CR>

function! Goyo_before()
	silent !tmux set status off
	silent !tmux resize-pane -Z
	set noshowmode
	set noshowcmd
	set wrap
	set nolist
	Limelight
endfunction

function! Goyo_after()
	silent !tmux set status on
	silent !tmux resize-pane -Z
	set showmode
	set showcmd
	set nowrap
	Limelight!
endfunction

let g:goyo_callbacks = [function('Goyo_before'), function('Goyo_after')]

" Setup status bar
set laststatus=2

" Configure airline to use powerline patched fonts and manage the tabbar too
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

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

	"set guioptions=mraAeigt
	set guioptions=
	set guiheadroom=0
endif

" Setup NeoComplete
let g:deoplete#enable_at_startup = 1

" Setup indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
"let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,ColorScheme * highlight IndentGuidesOdd ctermbg=NONE
autocmd VimEnter,ColorScheme * highlight IndentGuidesEven ctermbg=233

" Show leader as typed (used for gitgutter)
set showcmd

" Shut up
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if &diff
	colorscheme ps_color
else
	"colorscheme torte
	"colorscheme vividchalk
	colorscheme molokai
	" NeoVim no longer has GUI running on first startup
	" See issue https://github.com/neovim/neovim/issues/2953
	autocmd VimEnter * colorscheme molokai
endif

" Highlight current line
set cursorline

" Remove underline from cursor line in vividchalk
autocmd VimEnter,ColorScheme * highlight CursorLine cterm=NONE

" Set split separator to Unicode box drawing character
set fillchars=vert:│

" Match split background to tmux scheme
autocmd VimEnter,ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

map - \cn
map _ \cu

map Q <Nop>

" Shortcut to vim-eunuch's SudoWrite
cmap w!! call SudoWrite()

" Stop ATP from spawning files (see http://vi.stackexchange.com/a/472/267)
let g:atp_ProjectScript = 0
let g:tex_flavor = "latex"
let g:atp_developer = 1

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
noremap <silent><Leader>/ :nohlsearch<CR>

" https://gist.github.com/nocash/1988620
augroup AutoReloadVimRC
	autocmd!
	" automatically reload vimrc when it's saved
	autocmd BufWritePost $MYVIMRC so $MYVIMRC
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
autocmd InsertLeave * set nopaste

" http://www.vimbits.com/bits/173
autocmd FileType gitcommit DiffGitCached | wincmd p

" http://www.vimbits.com/bits/223
autocmd VimResized * exe "normal! \<c-w>="

" http://www.vimbits.com/bits/13
if exists('+colorcolumn')
	set colorcolumn=80
else
	autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" http://www.vimbits.com/bits/176
nmap <leader>o :echo 'Obsolete: use ]\<Space\> from vim-unimpaired'<Cr>
nmap <leader>O :echo 'Obsolete: use [\<Space\> from vim-unimpaired'<Cr>

" http://www.vimbits.com/bits/229
autocmd BufRead COMMIT_EDITMSG setlocal spell!

" http://www.vimbits.com/bits/125
"nnoremap ; :

" Add some UTF8 character pairs that should match
set matchpairs+=�:�
set matchpairs+=«:»
set matchpairs+=‹:›
set matchpairs+=“:”
set matchpairs+=‘:’
set matchpairs+=►:◄

" Use system clipboard for anonymous register
set clipboard=unnamedplus

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
set scrolloff=2

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

" Swap windows around between panes
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

" Setup editing of GPG encrypted files with safe*er* defaults than otherwise
set backupskip+=*.gpg
augroup encrypted
  autocmd!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ set shada= |
    \ set viminfo= |
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --quiet --no-tty --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Set default vimchant language to turkish (requires hunspell-tr)
let g:vimchant_spellcheck_lang = 'tr'

" Alternate insert mode with Turkish-F keyboard emulation (from Dvorak)
" See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
" See: http://vi.stackexchange.com/q/2260/267
set imsearch=-1
set keymap=dvorak2turkishf
set iminsert=0
"autocmd InsertLeave * set iminsert=0
"nnoremap <leader>i :set iminsert=1<Cr>i
"nnoremap <leader>I :set iminsert=1<Cr>I
"nnoremap <leader>a :set iminsert=1<Cr>a
"nnoremap <leader>A :set iminsert=1<Cr>A
"nnoremap <leader>c :set iminsert=1<Cr>c
"nnoremap <leader>C :set iminsert=1<Cr>C
"nnoremap <leader>r :set iminsert=1<Cr>r
"nnoremap <leader>R :set iminsert=1<Cr>R
"nnoremap <leader>o :set iminsert=1<Cr>o
"nnoremap <leader>O :set iminsert=1<Cr>O

:highlight Cursor guifg=NONE guibg=Green
:highlight lCursor guifg=NONE guibg=Cyan

" Autocompile latex
":autocmd BufWritePost *.tex silent execute ":!(arara % 2>&1; evince ../basili/<afile>:r-okuma.pdf) &"

" Add binding to activate Gundo plugin
nnoremap U :GundoToggle<CR>
let g:gundo_right = 1
"let g:gundo_width = 40
let g:gundo_preview_height = 20

" Map for pasting register 0
xnoremap <leader>p "0p

" Map tab at start of line to indent commands
"imap <tab> <c-t>
"imap <s-tab> <c-d>
"let g:neocomplete#enable_at_startup = 0

" Configure line wrapping to indent broken lines, only break on words and not
" reformat lines when editing
set breakindent
set linebreak
set showbreak=…
set formatoptions+=l

" Fuzzy finder FZF (replacing ctrlp because it's faster)
nnoremap <silent> <Leader>f :FZF<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> gb :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

cnoremap <silent> <c-tab> <c-\>eGetCompletions()<cr>
"add an extra <cr> at the end of this line to automatically accept the fzf-selected completions.

function! Lister()
    call extend(g:FZF_Cmd_Completion_Pre_List,split(getcmdline(),'\(\\\zs\)\@<!\& '))
endfunction

function! CmdLineDirComplete(prefix, options, rawdir)
    let l:dirprefix = matchstr(a:rawdir,"^.*/")
    if isdirectory(expand(l:dirprefix))
        return join(a:prefix + map(fzf#run({
                    \'options': a:options . ' --select-1  --query=' .
                    \ a:rawdir[matchend(a:rawdir,"^.*/"):len(a:rawdir)], 
                    \'dir': expand(l:dirprefix)
                    \}), 
                    \'"' . escape(l:dirprefix, " ") . '" . escape(v:val, " ")'))
    else
        return join(a:prefix + map(fzf#run({
                    \'options': a:options . ' --query='. a:rawdir }),
                    \'escape(v:val, " ")')) 
        "dropped --select-1 to speed things up on a long query
endfunction

function! GetCompletions()
    let g:FZF_Cmd_Completion_Pre_List = []
    let l:cmdline_list = split(getcmdline(), '\(\\\zs\)\@<!\& ', 1)
    let l:Prefix = l:cmdline_list[0:-2]
    execute "silent normal! :" . getcmdline() . "\<c-a>\<c-\>eLister()\<cr>\<c-c>"
    let l:FZF_Cmd_Completion_List = g:FZF_Cmd_Completion_Pre_List[len(l:Prefix):-1]
    unlet g:FZF_Cmd_Completion_Pre_List
    if len(l:Prefix) > 0 && l:Prefix[0] =~
                \ '^ed\=i\=t\=$\|^spl\=i\=t\=$\|^tabed\=i\=t\=$\|^arged\=i\=t\=$\|^vsp\=l\=i\=t\=$'
                "single-argument file commands
        return CmdLineDirComplete(l:Prefix, "",l:cmdline_list[-1])
    elseif len(l:Prefix) > 0 && l:Prefix[0] =~ 
                \ '^arg\=s\=$\|^ne\=x\=t\=$\|^sne\=x\=t\=$\|^argad\=d\=$'  
                "multi-argument file commands
        return CmdLineDirComplete(l:Prefix, '--multi', l:cmdline_list[-1])
    else 
        return join(l:Prefix + fzf#run({
                    \'source':l:FZF_Cmd_Completion_List, 
                    \'options': '--select-1 --query='.shellescape(l:cmdline_list[-1])
                    \})) 
    endif
endfunction

" Binding to toggle numbering mode an and then between relative and absolute
let g:NumberToggleTrigger="<leader>n"
nnoremap <leader>N :set nonumber<Cr>

" Configure Vimux
let g:VimuxOrientation = "h"
let VimuxUseNearest = 1
nnoremap <leader>p :VimuxPromptCommand<Cr>
nnoremap <leader>l :VimuxRunLastCommand<Cr>

" Use Alt key fix from http://stackoverflow.com/a/10216459/313192)
"let c='a'
"while c <= 'z'
"exec "set <A-".c.">=\e".c
"exec "imap \e".c." <A-".c.">"
"let c = nr2char(1+char2nr(c))
"endw
set timeout timeoutlen=3000
set nottimeout

" Configure tmux navigator to use alt instead of control to match my tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-w> :TmuxNavigateLeft<cr>

" Fugitive bindings
nnoremap <leader>gb :Gblame<Cr>
nnoremap <leader>gs :Gstatus<Cr>
nnoremap <leader>gc :Gcommit<Cr>
nnoremap <leader>gl :Glog<Cr>
nnoremap <leader>gw :Gwrite<Cr>
nnoremap <leader>gd :Gvdiff<Cr>

" Shortcut to delete withoud clobbering the registers
nnoremap <leader>x "_x

" Setup plugins for editing prose
let g:airline_section_x = '%{PencilMode()}'
let g:lexical#spell = 0
nnoremap <silent> <leader>s :NextWordy<cr>
augroup pencil
	autocmd!
	autocmd FileType pandoc,markdown,mkd,text,tex
				\| call lexical#init()
				\| call textobj#sentence#init()
				"\| call pencil#init()
augroup END

" Setup autosave plugin, off by default, enable with :AutoSaveToggle
let g:auto_save = 0 
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

" Explicitly enable True Color and cursor features for Neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

function! AddSubtract(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction
nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>

" Map Markdown Footnotes manually because its default of <leader>+f is taken
imap <Leader>^ <Plug>AddVimFootnote
nmap <Leader>^ <Plug>AddVimFootnote
imap <Leader>@ <Plug>ReturnFromFootnote
nmap <Leader>@ <Plug>ReturnFromFootnote

" << refactored to here

set fencs=utf8,cp1254,latin1
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
set splitright
set diffopt+=vertical
cabbrev help vert help
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

" imap <C-g> <C-x><C-f>	" File complete on ctrl g

" alt+: on most machines
map � :
imap � <Esc><Esc>:

" alt+: on rhino
map ; :
map ; <Esc><Esc>:

map <M-;> :
imap <M-;> <Esc><Esc>:

map <F5> :set hlsearch!<bar>set hlsearch?<CR>

if &filetype == ""
"   setfiletype text
	source ~/.vim/notepad.vim
endif

if &filetype == "mail"
	set nosmartindent
endif

" function MyTabOrComplete()
"	 let col = col('.')-1
"	 if !col || getline('.')[col-1] !~ '\k'
"		 return "\<tab>"
""	 else
"		 return "\<C-X>\<C-O>"
"	 endif
" endfunction
" inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

set nowrap

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
		"	   filter.
		" NOTE: 72 is the maximum length of a single line, including
		"	   the length of the quote.
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
endif

"let fileType = &ft
"if fileType == 'php'
"	iab _S $_SERVER[']hi
"	iab _P $_POST[']hi
"	iab _G $_GET[']hi
"endif

" vim: ts=4:sw=4:noet
