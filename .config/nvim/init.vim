" Make our vimscript linter happy and handle Unicode properly
scriptencoding utf8

" Group some filetypes for use in selectively loading plugins
let g:markdown_filetypes =
            \ ['markdown', 'mkd', 'pandoc']

let g:prose_filetypes = g:markdown_filetypes +
            \ ['sile', 'tex', 'mail', 'org', 'rst', 'text', 'asciidoc', 'usfm']

let g:markdown_embeded =
            \ ['html', 'css', 'bash=sh', 'lua', 'python', 'latex=tex', 'rust']

" Stop vim-polyglot from loading for
" - CSV, which makes a useless power grab for TSV and sets useless conceals
" - Lua, loading full plugin directly for freshness
" - Rust, loading full plugin directly for freshness
" - TeX, using vimtex instead
let g:polyglot_disabled = ['csv', 'lua', 'latex', 'rust']

augroup QueInit
    autocmd!
augroup END

" Some vim plugins have broken repos that my git config flunks via fsck
let $GIT_CONFIG_NOSYSTEM = 1

" Manage plugins with vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin()

" Map vim-plug's external plugin update function (1 arg) to Neovim's (no args)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'alerque/vim-surround' " Forked from tpope to work with vim-textobj-quote
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'gcmt/wildfire.vim'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'sdanielf/vim-stdtabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'
"Plug 'jcf/vim-latex'
"Plug 'git://git.code.sf.net/p/atp-vim/code'
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-sneak'
Plug 'wesQ3/vim-windowswap'
Plug 'sheerun/vim-polyglot'
Plug 'lordm/vim-browser-reload-linux'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tommcdo/vim-exchange'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'LucHermitte/lh-vim-lib' | Plug 'LucHermitte/local_vimrc'
Plug 'brookhong/DBGPavim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi'
Plug 'vim-scripts/RelOps'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'preservim/vimux'
Plug 'jtdowney/vimux-cargo'
Plug 'swekaj/php-foldexpr.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-colors-pencil'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-wordy'
Plug 'preservim/vim-textobj-sentence'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-wheel'
Plug 'preservim/vim-wordchipper'
Plug 'rbonvall/vim-textobj-latex'
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'sile-typesetter/vim-sile'
Plug 'severin-lemaignan/vim-minimap'
Plug '907th/vim-auto-save'
Plug 'lervag/vimtex'
Plug 'gisraptor/vim-lilypond-integrator', { 'for': 'lilypond' }
Plug 'trusktr/seti.vim'
Plug 'alerque/vim-commonmark', { 'do': 'make' }
Plug 'godlygeek/tabular' " required for plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown', { 'for': g:markdown_filetypes }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-criticmarkup', { 'for': g:prose_filetypes }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': g:markdown_filetypes }
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': g:markdown_filetypes }
Plug 'benekastah/neomake'
Plug 'junegunn/vim-easy-align'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'rust-lang/rust.vim'
Plug 'justinmk/molokai'
Plug 'equalsraf/neovim-gui-shim'
Plug 'machakann/vim-highlightedyank'
Plug 'pangloss/vim-javascript'
Plug 'djoshea/vim-autoread'
Plug 'christoomey/vim-titlecase'
Plug 'zhimsel/vim-stay'
Plug 'meain/vim-package-info', { 'do': 'npm install' }
Plug 'w0rp/ale'
Plug 'FooSoft/vim-argwrap'
Plug 'ledger/vim-ledger'
Plug 'andymass/vim-matchup'
Plug 'Konfekt/vim-sentence-chopper'
Plug 'Konfekt/FastFold'
Plug 'Konfekt/vim-DetectSpellLang', { 'for': g:prose_filetypes }
Plug 'Konfekt/vim-unicode-homoglyphs', { 'for': g:prose_filetypes }
Plug 'Konfekt/vim-smartbraces'
Plug 'Konfekt/vim-select-replace'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'projectfluent/fluent.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'haya14busa/vim-asterisk'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tridactyl/vim-tridactyl'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tbastos/vim-lua'
Plug 'leafo/moonscript-vim'
Plug 'junegunn/vader.vim'
Plug 'egberts/vim-syntax-bind-named'

call plug#end()

" Return to regularly scheduled Git configuration
unlet $GIT_CONFIG_NOSYSTEM

" Default indent style when no filetype specific style guide is in place
set tabstop=4
set shiftwidth=4
set shiftround
set noexpandtab
set cindent
set autoindent

" Don't wrap long lines by default (override for prose file types & Goyo mode)
set nowrap

" Set custom list characters
set list
set listchars=tab:⇥\ ,trail:␠,nbsp:⍽

" Setup discraction free mode including tmux integration
let g:goyo_width = '90%'
" let g:goyo_height = '100%'
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <Leader>r :Goyo<CR>

function! s:goyo_enter()
	silent !tmux set status off
	silent !tmux resize-pane -Z
	set noshowmode
	set noshowcmd
	set wrap
	set nolist
	set scrolloff=999
endfunction

function! s:goyo_leave()
	silent !tmux set status on
	silent !tmux resize-pane -Z
	set showmode
	set showcmd
	set nowrap
	set list
	set scrolloff=2
endfunction

autocmd QueInit User GoyoEnter nested call <SID>goyo_enter()
autocmd QueInit User GoyoLeave nested call <SID>goyo_leave()
autocmd QueInit User GoyoEnter Limelight
autocmd QueInit User GoyoLeave Limelight!

" " Setup extra color focus tools to integrate with distraction free mode
let g:limelight_default_coefficient = 0.6
let g:limelight_priority = -1
" let g:limelight_paragraph_span = 1
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

" Setup status bar
set laststatus=2

" Configure airline to use powerline patched fonts and manage the tabbar too
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 0
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#wordcount#filetypes = g:prose_filetypes
if exists('airline#section#create_right')
	let g:airline_section_y =
				\ airline#section#create_right(['%{PencilMode()}', '%{g:auto_save == 1}'])
endif

" Hide instead of unload abandoned buffers, showing them in airline
set hidden

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
	set guiheadroom=0
endif

" Setup NeoComplete
let g:deoplete#enable_at_startup = 1

" Setup indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
"let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd QueInit VimEnter,ColorScheme * highlight IndentGuidesOdd ctermbg=NONE
autocmd QueInit VimEnter,ColorScheme * highlight IndentGuidesEven ctermbg=233

" Show leader as typed (used for gitgutter)
set showcmd

" Shut up
set noerrorbells visualbell t_vb=
autocmd QueInit GUIEnter * set visualbell t_vb=

" Run my favorite color scheme
silent! colorscheme molokai
let g:molokai_italic = 0

" Highlight current line
set nocursorline

" Disable cursorline when entering diff mode
" https://vi.stackexchange.com/a/12852/267
au OptionSet diff let &cul=!v:option_new

" Set split separator to Unicode box drawing character
set fillchars=vert:│

" Match split background to tmux scheme
autocmd QueInit VimEnter,ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

map - <Leader>cn
map _ <Leader>cu

map Q <Nop>

" Shortcut to vim-eunuch's SudoWrite
cmap w!! SudoWrite

" Stop ATP from spawning files (see http://vi.stackexchange.com/a/472/267)
let g:atp_ProjectScript = 0
let g:tex_flavor = 'latex'
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
" automatically reload vimrc when it's saved
autocmd QueInit BufWritePost $MYVIMRC so $MYVIMRC

" http://www.vimbits.com/bits/90
"let mapleader = ','

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

" http://www.vimbits.com/bits/13
if exists('+colorcolumn')
	set colorcolumn=80
else
	autocmd QueInit BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" http://www.vimbits.com/bits/176
nmap <leader>o :echo 'Obsolete: use ]\<Space\> from vim-unimpaired'<Cr>
nmap <leader>O :echo 'Obsolete: use [\<Space\> from vim-unimpaired'<Cr>

" http://www.vimbits.com/bits/229
autocmd QueInit BufRead COMMIT_EDITMSG setlocal spell!

" http://www.vimbits.com/bits/125
"nnoremap ; :

" Add some UTF8 character pairs that should match
set matchpairs+=�:�
set matchpairs+=«:»
set matchpairs+=‹:›
set matchpairs+=►:◄

" Use system clipboard for anonymous register
set clipboard+=unnamedplus

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

" Highlight matchign brackets
set showmatch

" Setup sneak (in leu of EasyMotion)
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#target_labels = 'aoeuiypqjkxsnthdfgcrlbmwvzAOEUIYPQJKXSNTHDFGCRLBMWVZ'

" Swap windows around between panes
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>

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
			\ execute "'[,']!gpg --quiet --no-tty --decrypt --default-recipient-self" |
			\ setlocal nobin |
			\ execute 'doautocmd BufReadPost ' . expand('%:r')

" Set binary file format and encrypt the contents before writing the file
autocmd QueInit BufWritePre,FileWritePre *.gpg
			\ setlocal bin |
			\ '[,']!gpg --encrypt --default-recipient-self

" After writing the file, do an :undo to revert the encryption in the
" buffer, and reset binary file format
autocmd QueInit BufWritePost,FileWritePost *.gpg
			\ silent u |
			\ setlocal nobin

" Set default vimchant language to turkish (requires hunspell-tr)
let g:vimchant_spellcheck_lang = 'tr'

let g:detectspelllang_langs = {}
let g:detectspelllang_langs.aspell = [ "en_US", "tr_TR" ]

" Alternate insert mode with Turkish-F keyboard emulation (from Programer's Dvorak)
" See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
" See: http://vi.stackexchange.com/q/2260/267
set imsearch=-1
set keymap=dvp2ptf
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

" Configure line wrapping to indent broken lines, only break on words, don't
" reformat long lines when editing, include comment leader wher reformatting,
" avoid single letter words at the end of lines, use the 2nd line in
" paragraphs for indent reference, and don't add space between multi-byte
" characters when joining.
set breakindent
set linebreak
set showbreak=…
set formatoptions+=lr12B

" File & buffer finder (was ctrlp, then fzf, now clap)
nnoremap <silent> !! :Clap! <Cr>
nnoremap <silent> !b :Clap! buffers<Cr>
nnoremap <silent> !f :Clap! files --hidden<Cr>
nnoremap <silent> !g :Clap! grep<Cr>
nnoremap <silent> !h :Clap! history<Cr>
nnoremap <silent> !l :Clap! lines<Cr>
nnoremap <silent> !m :Clap! marks<Cr>
nnoremap <silent> !p :Clap! yanks<Cr>
nnoremap <silent> !w :Clap! windows<Cr>
nnoremap <silent> !r :Clap! registers<Cr>

let g:clap_open_action = { 'ctrl-t': 'tab split', 'ctrl-h': 'split', 'ctrl-v': 'vsplit' }
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden'

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

" Configure Vimux
let g:VimuxOrientation = 'h'
let VimuxUseNearest = 1
nnoremap <leader>p :VimuxPromptCommand<Cr>
" nnoremap <leader>l :VimuxRunLastCommand<Cr>

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

let g:fugitive_gitlab_domains = ['https://gitlab.com', 'https://gitlab.alerque.com']
let g:fugitive_gitlab_ssh_user = 'gitlab'
try
	let g:private_keys = system('gpg --use-agent --decrypt --quiet --no-tty --batch $HOME/.private/keys.vim.gpg')
	execute g:private_keys
catch
endtry

" Shortcut to delete withoud clobbering the registers
nnoremap <leader>x "_x

" Setup plugins for editing prose
function! QueProse()
	call lexical#init()
	call textobj#sentence#init()
	call textobj#quote#init({ 'educate': 0 })
	call pencil#init()
	nnoremap <buffer> <silent> <leader>W :NextWordy<cr>
	inoremap <buffer> <expr> <C-e> wordchipper#chipWith('dE')
	inoremap <buffer> <expr> <C-w> wordchipper#chipWith('dB')
endfunction
let g:lexical#spell = 1
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#concealcursor = 'nc'
let g:pencil#conceallevel = 0
let prose_filetypes = join(g:prose_filetypes, ',')
execute 'autocmd QueInit FileType ' . prose_filetypes . ' call QueProse()'

" Setup autosave plugin, off by default, enable with :AutoSaveToggle
let g:auto_save = 0
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = [ 'InsertLeave', 'TextChanged' ]
let g:auto_save_events = [ 'CursorHold', 'CursorHoldI', 'CompleteDone', 'InsertLeave' ]
let g:auto_save_silent = 1
nmap <Leader>s :AutoSaveToggle<Cr>

" Explicitly enable True Color and cursor features for Neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Map Markdown Footnotes manually because its default of <leader>+f is taken
" inoreabbrev [] <c-o>:exe "normal \<Plug>AddVimFootnote"<cr>
autocmd QueInit FileType markdown,pandoc imap <buffer> ^^ <Plug>AddVimFootnote
autocmd QueInit FileType markdown,pandoc nmap <buffer> <Leader>^ <Plug>AddVimFootnote
autocmd QueInit FileType markdown,pandoc imap <buffer> @@ <Plug>ReturnFromFootnote
autocmd QueInit FileType markdown,pandoc nmap <buffer> <Leader>@ <Plug>ReturnFromFootnote

" Mappings for Easy Alignment plugin
xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

" Mapping to pull up ctags based navigator
nmap \t :TagbarToggle<CR>

" Add support for markdown files in tagbar.
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : 'markdown2ctags',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
	\ }

let g:markdown_fenced_languages = g:markdown_embeded
let g:pandoc#syntax#codeblocks#embeds#langs = g:markdown_embeded

" I use fenced div more than definition lists, see https://github.com/vim-pandoc/vim-pandoc-syntax/issues/236
let g:pandoc#syntax#use_definition_lists = 0

" Configure CommonMark syntax
let g:commonmark#extensions#all = 1

" Change default order a nd add smart quote objects to wildfire
let g:wildfire_objects = ["i'", 'i"', 'iq', 'aq', 'iQ', 'aQ', 'i)', 'i]', 'i}', 'i<', 'if', 'af', 'it', 'at', 'ip', 'ae']

" Setup 8 digit numbers as date format even without dashes
if exists(':SpeedDatingFormat')
	autocmd QueInit User * SpeedDatingFormat %Y%m%d
endif

" Bindings for argwrap
nmap <Leader>w :ArgWrap<Cr>
autocmd QueInit FileType vim :let b:argwrap_line_prefix = '\ '

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
	call deoplete#enable()
	set omnifunc=mailcomplete#Complete
	call deoplete#custom#option('omni_patterns', {
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

" Configure Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*', '*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_quiet_messages = { 'level': '[]', 'file': ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }

" Configure Rust.vim
let g:rustfmt_autosave = 1
let g:rust_conceal = 1

syn match rustRightArrowTail contained "-" conceal cchar=⟼
syn match rustFatRightArrowTail contained "=" conceal cchar=⟾

" Mapping to toggle educate (smart quote) mode from vim-textobj-quote
map <Leader>e :ToggleEducate<CR>

autocmd QueInit VimEnter * if &diff | execute 'windo set wrap' | endif

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let s:spacePreStr = ' '

" Force GitGutter to always show the sign column
set signcolumn=yes
let g:gitgutter_highlight_linenrs = 1

" Unset F option from campatability mode so we can use Alt keys in keymaps
set cpoptions-=F

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
set foldlevelstart=10

" Setup extras in JS syntax plugin
let g:javascript_plugin_jsdoc = 1

" Default title case key bindings conflict with tab control
let g:titlecase_map_keys = 0
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

" Ledger stuff
let g:ledger_maxwidth = 80
let g:ledger_align_at = 50
let g:ledger_default_commodity = '₺'
let g:ledger_decimal_sep = ','
let g:ledger_detailed_first = 1
let g:ledger_fold_blanks = 1
let g:ledger_bin = 'hledger'
let g:ledger_extra_options = '-x'
let g:ledger_accounts_generate = 1
let g:ledger_accounts_cmd = 'make _vim_accounts'
let g:ledger_descriptions_cmd = 'make _vim_descriptions'

autocmd QueInit FileType ledger noremap <buffer> <Leader>h vip:!hledger -f- print -x<Cr> <bar> vip:LedgerAlign<Cr>
autocmd QueInit FileType ledger inoremap <buffer> <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<Cr>
autocmd QueInit FileType ledger vnoremap <buffer> <silent> <Tab> :LedgerAlign<Cr>
autocmd QueInit FileType ledger nmap <buffer> <C-o> <Plug>SpeedDatingDown
autocmd QueInit FileType ledger SpeedDatingFormat %Y-%m-%d

" Matchup
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1

" Sentence chopper
let g:punctuation_marks = '.;:?!'
let g:latexindent = 0
onoremap <silent> . :<c-u>call search('\v\C%(%([^[:digit:]IVX]\|[)''"])\zs[.]\|[,;:!?])[[:space:])''"]\|[.,;:!?]$','W')<CR>

" Spellcheck language guesser
let g:guesslang_langs = [ 'en', 'tr', 'ru' ]

" This is useful but slows down big files a lot
let g:is_homoglyph_on = 0

" Configure multiple cursor plugin to be more aggressive
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" vim-visual-multi configuration
let g:VM_mouse_mappings = 1
let g:VM_skip_shorter_lines = 1
let g:VM_skip_empty_lines = 1

" Configure smartbrace key so it doesn't clobber vim default
" See https://github.com/Konfekt/vim-smartbraces/issues/4
nmap g{ <Plug>(smartbraces-OpenBrace)
nmap g} <Plug>(smartbraces-CloseBrace)
xmap g{ <Plug>(smartbraces-OpenBrace)
xmap g} <Plug>(smartbraces-CloseBrace)
omap g{ <Plug>(smartbraces-OpenBrace)
omap g} <Plug>(smartbraces-CloseBrace)

" Configure Firenvim. To enable in Firefox install plugin from:
" https://addons.mozilla.org/en-US/firefox/addon/firenvim/
" Plus setup system with:
" $ nvim --headless "+call firenvim#install(0) | q"
function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') &&
      \ has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set guifont=Hack\ Nerd\ Font:h14
    let b:syntastic_skip_checks = 1
    set showtabline=0
    set laststatus=0
    set spell
    " set spelllang=en
    AutoSaveToggle
    nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
    nnoremap <C-z> :call firenvim#hide_frame()<CR>
    nnoremap <C-z> :call firenvim#hide_frame()<CR>
  endif
endfunction

autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

let s:fc = {}
let s:fc['.*'] = {
			\ 'priority': 0,
			\ 'selector': 'textarea, div[role="textbox"]',
			\ 'takeover': 'once',
			\ }
let s:fc['https://app\.element\.io'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://twitter\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://.*stackoverflow\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://gitter\.im'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://mail\.google\.com/mail/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://keep\.google\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://mastodon\.social/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://mattermost\.alerque\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://discord\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://app\.slack\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let s:fc['https://.*stackexchange\.com/'] = {
			\ 'priority': 1 ,
			\ 'takeover': 'never',
			\ }
let g:firenvim_config = {
			\ 'globalSettings': {
				\ 'ignoreKeys': {
					\ 'all': ['<C-Tab>'],
				\ },
				\ '<C-w>': 'noop',
				\ '<C-n>': 'default',
			\ },
			\ 'localSettings': s:fc,
			\ }

autocmd QueInit BufEnter github.com_*.txt set filetype=markdown
autocmd QueInit BufEnter gitlab.com_*.txt set filetype=markdown
autocmd QueInit BufEnter gitlab.alerque.com_*.txt set filetype=pandoc
autocmd QueInit BufEnter gitter.im_*.txt set filetype=markdown | nnoremap <leader><Cr> write<Cr>:call firenvim#press_keys("<Lt>CR>")<cR>ggdGa

" colorizer.lua
set termguicolors
lua << EOC
local function load_colorizer ()
	require 'colorizer'.setup {
		'*',
		'!vim-plug',
		'!gitcommit',
		css = {
			rgb_fn = true,
			hsl_fn = true,
			css_fn = true
		}
	}
end
pcall(load_colorizer)
EOC

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
