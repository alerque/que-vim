" Make our vimscript linter happy and handle Unicode properly
scriptencoding utf8

augroup QueInit
    autocmd!
augroup END

" Some vim plugins have broken repos that my git config flunks via fsck
let $GIT_CONFIG_NOSYSTEM = 1

" Manage plugins with vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" Map vim-plug's external plugin update function (1 arg) to Neovim's (no args)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" Plug 'tommcdo/vim-exchange'
Plug 'LucHermitte/lh-vim-lib' | Plug 'LucHermitte/local_vimrc'
Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'swekaj/php-foldexpr.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'rbonvall/vim-textobj-latex'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug '907th/vim-auto-save'
Plug 'lervag/vimtex'
Plug 'gisraptor/vim-lilypond-integrator', { 'for': 'lilypond' }
Plug 'alerque/vim-commonmark', { 'do': 'make' }
Plug 'godlygeek/tabular' " required for preservim/vim-markdown
Plug 'preservim/vim-markdown', { 'for': g:markdown_filetypes }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-criticmarkup', { 'for': g:prose_filetypes }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': g:markdown_filetypes }
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': g:markdown_filetypes }
Plug 'junegunn/vim-easy-align'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'rust-lang/rust.vim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'meain/vim-package-info', { 'do': 'npm install' }
" Plug 'w0rp/ale'
Plug 'Konfekt/vim-unicode-homoglyphs', { 'for': g:prose_filetypes }
Plug 'Konfekt/vim-select-replace'
Plug 'haya14busa/vim-asterisk'

call plug#end()

" Return to regularly scheduled Git configuration
unlet $GIT_CONFIG_NOSYSTEM

" Set custom list characters
set list
set listchars=tab:⇥\ ,trail:␠,nbsp:⍽

" Do some special things for GVim/MacVim only
if has('gui_running')
	" See ginit.vim for GoNVIM config

	" Request powerline patched font
	if has('gui_gtk2')
		set guifont=Hack\ 10
	elseif has('gui_win32')
		" TODO: pick out windows font
	elseif has('gui_macvim')
		set guifont=Hack:h10
		set transparency=15
	endif

	"set guioptions=mraAeigt
	set guioptions=
endif

" Disable cursorline when entering diff mode
" https://vi.stackexchange.com/a/12852/267
au OptionSet diff let &cul=!v:option_new
au OptionSet diff set nofoldenable

" Match split background to tmux scheme
autocmd QueInit VimEnter,ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Shortcut to vim-eunuch's SudoWrite
cmap w!! SudoWrite

" Stop ATP from spawning files (see http://vi.stackexchange.com/a/472/267)
let g:atp_ProjectScript = 0
let g:tex_flavor = 'latex'
let g:atp_developer = 1

" http://www.vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv

" http://www.vimbits.com/bits/25
nnoremap j gj
nnoremap k gk

" http://www.vimbits.com/bits/21
noremap <silent><Leader>/ :nohlsearch<CR>

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
autocmd QueInit InsertLeave * set nopaste

" http://www.vimbits.com/bits/173
autocmd QueInit FileType gitcommit DiffGitCached | wincmd p

" http://www.vimbits.com/bits/223
autocmd QueInit VimResized * exe "normal! \<c-w>="

" http://www.vimbits.com/bits/125
"nnoremap ; :

" Enable backspace over indent,eol,start,etc
set backspace=indent,eol,start

" Highlight search results
set hlsearch

" Do incremental search
set incsearch

" Show live feedback durring commands via split pane
set inccommand=split

" Ignore case of search unless they have a capital
set ignorecase
set smartcase
set infercase

" Give context when scrolling
set scrolloff=2

" Keep lots of command history
set history=1000

" Show ruller at bottom
set ruler

" Setup editing of GPG encrypted files with safe*er* defaults than otherwise
set backupskip+=*.gpg

" Disable swap files, and set binary file format before reading the file
autocmd QueInit BufReadPre,FileReadPre *.gpg
			\ set shada= |
			\ set viminfo= |
			\ setlocal noswapfile bin

" Decrypt the contents after reading the file, reset binary file format
" and run any BufReadPost autocmds matching the file name without the .gpg
" extension
autocmd QueInit BufReadPost,FileReadPost *.gpg
			\ execute "'[,']!gpg --quiet --no-tty --decrypt 2> /dev/null" |
			\ setlocal nobin |
			\ execute 'doautocmd BufReadPost ' . expand('%:r')

" Set binary file format and encrypt the contents before writing the file
autocmd QueInit BufWritePre,FileWritePre *.gpg
			\ setlocal bin |
			\ '[,']!gpg --quiet --no-tty --encrypt --default-recipient-self

" After writing the file, do an :undo to revert the encryption in the
" buffer, and reset binary file format
autocmd QueInit BufWritePost,FileWritePost *.gpg
			\ silent u |
			\ setlocal nobin

:highlight Cursor guifg=NONE guibg=Green
:highlight lCursor guifg=NONE guibg=Cyan

" Autocompile latex
":autocmd BufWritePost *.tex silent execute ":!(arara % 2>&1; evince ../basili/<afile>:r-okuma.pdf) &"

" Map tab at start of line to indent commands
"imap <tab> <c-t>
"imap <s-tab> <c-d>
"let g:neocomplete#enable_at_startup = 0

" Configure line wrapping to indent broken lines, only break on words, don't
" reformat long lines when editing, include comment leader wher reformatting,
" avoid single letter words at the end of lines, use the 2nd line in
" paragraphs for indent reference, and don't add space between multi-byte
" characters when joining.
set breakindent
set linebreak
set showbreak=…
set formatoptions+=lr12B

" cnoremap <silent> <C-Tab> <C-\>eGetCompletions()<Cr>
"add an extra <cr> at the end of this line to automatically accept the fzf-selected completions.

function! Lister()
	call extend(g:FZF_Cmd_Completion_Pre_List,split(getcmdline(),'\(\\\zs\)\@<!\& '))
endfunction

function! CmdLineDirComplete(prefix, options, rawdir)
	let l:dirprefix = matchstr(a:rawdir,'^.*/')
	if isdirectory(expand(l:dirprefix))
		return join(a:prefix + map(fzf#run({
					\'options': a:options . ' --select-1  --query=' .
					\ a:rawdir[matchend(a:rawdir,'^.*/'):len(a:rawdir)],
					\'dir': expand(l:dirprefix)
					\}),
					\'"' . escape(l:dirprefix, ' ') . '" . escape(v:val, " ")'))
	else
		return join(a:prefix + map(fzf#run({
					\ 'options': a:options . ' --query='. a:rawdir
					\ }),
					\ 'escape(v:val, " ")')
					\ )
		"dropped --select-1 to speed things up on a long query
	endif
endfunction

function! GetCompletions()
	let g:FZF_Cmd_Completion_Pre_List = []
	let l:cmdline_list = split(getcmdline(), '\(\\\zs\)\@<!\& ', 1)
	let l:Prefix = l:cmdline_list[0:-2]
	execute 'silent normal! :' . getcmdline() . "\<c-a>\<c-\>eLister()\<cr>\<c-c>"
	let l:FZF_Cmd_Completion_List = g:FZF_Cmd_Completion_Pre_List[len(l:Prefix):-1]
	unlet g:FZF_Cmd_Completion_Pre_List
	if len(l:Prefix) > 0 && l:Prefix[0] =~#
				\ '^ed\=i\=t\=$\|^spl\=i\=t\=$\|^tabed\=i\=t\=$\|^arged\=i\=t\=$\|^vsp\=l\=i\=t\=$'
		"single-argument file commands
		return CmdLineDirComplete(l:Prefix, '', l:cmdline_list[-1])
	elseif len(l:Prefix) > 0 && l:Prefix[0] =~#
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
nnoremap <Leader>n :set number relativenumber!<Cr>
nnoremap <Leader>N :set nonumber norelativenumber<Cr>

set timeout timeoutlen=3000
set nottimeout

" try
"     let g:private_keys = system('gpg --use-agent --decrypt --quiet --no-tty --batch $HOME/.private/keys.vim.gpg')
"     execute g:private_keys
" catch
" endtry

" " Setup plugins for editing prose
" function! QueProse()
"     call lexical#init()
"     call textobj#sentence#init()
"     call textobj#quote#init({ 'educate': 0 })
"     call pencil#init()
"     nnoremap <buffer> <silent> <leader>W :NextWordy<cr>
"     inoremap <buffer> <expr> <C-e> wordchipper#chipWith('dE')
"     inoremap <buffer> <expr> <C-w> wordchipper#chipWith('dB')
" endfunction
" let prose_filetypes = join(g:prose_filetypes, ',')
" execute 'autocmd QueInit FileType ' . prose_filetypes . ' call QueProse()'

" Setup autosave plugin, off by default, enable with :AutoSaveToggle
let g:auto_save = 0
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = [ 'InsertLeave', 'TextChanged' ]
let g:auto_save_events = [ 'CursorHold', 'CursorHoldI', 'CompleteDone', 'InsertLeave' ]
let g:auto_save_silent = 1
nmap <Leader>s :AutoSaveToggle<Cr>

" Map Markdown Footnotes manually because its default of <leader>+f is taken
" inoreabbrev [] <c-o>:exe "normal \<Plug>AddVimFootnote"<cr>
autocmd QueInit FileType markdown,pandoc imap <buffer> ^^ <Plug>AddVimFootnote
autocmd QueInit FileType markdown,pandoc nmap <buffer> <Leader>^ <Plug>AddVimFootnote
autocmd QueInit FileType markdown,pandoc imap <buffer> @@ <Plug>ReturnFromFootnote
autocmd QueInit FileType markdown,pandoc nmap <buffer> <Leader>@ <Plug>ReturnFromFootnote

" Mappings for Easy Alignment plugin
xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)


let g:markdown_fenced_languages = g:markdown_embeded
let g:pandoc#syntax#codeblocks#embeds#langs = g:markdown_embeded
let g:vim_markdown_folding_disabled = 1

" I use fenced div more than definition lists, see https://github.com/vim-pandoc/vim-pandoc-syntax/issues/236
let g:pandoc#syntax#use_definition_lists = 0
let g:pandoc#spell#enabled = 0

" Configure CommonMark syntax
let g:commonmark#extensions#all = 1

" Setup 8 digit numbers as date format even without dashes
if exists(':SpeedDatingFormat')
	autocmd QueInit User * SpeedDatingFormat %Y%m%d
endif

aug mutt_mail
	au!
	au FileType mail call QueMutt()
	au VimEnter * doautoa FileType
aug END

function! QueMutt()
	command! Reflow call quemutt#FixFlowed()
	autocmd mutt_mail BufWritePre * call quemutt#FixIndented()
	autocmd mutt_mail BufReadPost * call quemutt#FixFlowed() | %call quemutt#FirstInPost()
	set wrap
	set nosmartindent
	set textwidth=72
	set linebreak
	set formatoptions=2tcqaw
	set digraph
	set spell!
	set display+=lastline

	" Less comments
	"set comments=n:>,n::,n:#,n:%,n:\|

	" Open folds so our field jumper doesn't choke
	normal! zr

	" Autocomplete email addresses for mutt
	" call deoplete#enable()
	set omnifunc=mailcomplete#Complete
	" call deoplete#custom#option('omni_patterns', {
		\ 'mail': '^\(To\|Cc\|Bcc\|From\|Reply-To\)\+: \w\w\w\+',
		\})

	" Move around by line even in wrapped lines
	map j gj
	map k gk

	" Jump throuph things that get filled in
	map <C-n> :%call quemutt#FirstInPost()<CR>
	imap <C-n> <Esc>:%call quemutt#FirstInPost()<CR>

	" Disable whitespace highlighting
	DisableWhitespace
endfunction

" Don't add trailing new lines if the file didn't have one when opened
let g:PreserveNoEOL = 1

" For poor laptop and other pathetic (non Kinesis Advantage) map CTRL-e to Esc
nnoremap <C-e> <Esc>
vnoremap <C-e> <Esc>gV
onoremap <C-e> <Esc>
inoremap <C-e> <Esc>`^

" Configure Rust.vim
let g:rustfmt_autosave = 1
let g:rust_conceal = 1

syn match rustRightArrowTail contained "-" conceal cchar=⟼
syn match rustFatRightArrowTail contained "=" conceal cchar=⟾

autocmd QueInit VimEnter * if &diff | execute 'windo set wrap' | endif

" Set file encoding, first checking for byte order mark, then seeing if UTF8
" works. Adds Windows' Turkish encoding to defaults as check if Latin 1 fails.
set fileencodings=ucs-bom,utf8,default,latin1,cp1254

" Explicitly enable creation of backup files
set backup

" Done reset cursor to the start of lines after linewise commands
set nostartofline

" If shinny new vim, use better diff options
if has('nvim-0.3.2') || has('patch-8.1.0360')
	set diffopt+=algorithm:histogram,indent-heuristic
endif

" Setup verticle split behavior
set splitright
set diffopt+=vertical
cabbrev help vert help

" Add macro to re-select the last affected block
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" <esc>I sets paste mode
nmap I :set paste<Cr>i
" <esc>i clears paste mode
nmap i :set nopaste<Cr>i

" Do and insert results of fancy math equations via python
:command! -nargs=+ Calc :r! python -c 'from math import *; print (<args>)'

" Change default ]h mapping from vim-markdown so it can be used for gitsigns
" map ]H <Plug>Markdown_MoveToNextHeader
" map [H <Plug>Markdown_MoveToPreviousHeader
map ]H <Plug>Markdown_MoveToCurHeader
" map [H <Plug>Markdown_MoveToParentHeader

" Map space to page down in normal mode
map <space> <C-d>

" Use Alt+; as shortcut co command prompt (modern terminal + nvim only, see
" git history for how to do this on older systems).
map <M-;> :
imap <M-;> <Esc><Esc>:

" Toggle search result highlighting
map <F5> :set hlsearch!<bar>set hlsearch?<CR>

if !exists('*VeryBeautyQuote')
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

" Default to having folds open on buffer load
set foldlevelstart=0
set nofoldenable

" Setup extras in JS syntax plugin
let g:javascript_plugin_jsdoc = 1

" This is useful but slows down big files a lot
let g:is_homoglyph_on = 0

" Configure multiple cursor plugin to be more aggressive
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" vim-visual-multi configuration
let g:VM_mouse_mappings = 1
let g:VM_skip_shorter_lines = 1
let g:VM_skip_empty_lines = 1

" vim-asterisk bindings
let g:asterisk#keeppos = 1

nmap *  <Plug>(asterisk-z*)
nmap #  <Plug>(asterisk-z#)
nmap g* <Plug>(asterisk-gz*)
nmap g# <Plug>(asterisk-gz#)

xmap *  <Plug>(asterisk-z*)
xmap #  <Plug>(asterisk-z#)
xmap g* <Plug>(asterisk-gz*)
xmap g# <Plug>(asterisk-gz#)

omap *  <plug>(vim-select-replace-star)
omap g* <plug>(vim-select-replace-g-star)
omap #  <plug>(vim-select-replace-hash)
omap g# <plug>(vim-select-replace-g-hash)

set diffopt+=iwhite
set diffexpr=DiffW()
function DiffW()
    let opt = ""
    if &diffopt =~ "icase"
        let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
        let opt = opt . "-w " " swapped vim's -b with -w
    endif
    silent execute "!diff -a --binary " . opt .
                \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

let g:strip_only_modified_lines = 1

au BufNewFile,BufRead git-revise-todo       setf gitrebase

" vim: ts=4:sw=4:et
