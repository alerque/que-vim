" Manage plugins with vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin()

" Map Neovim's external plugin update function (no args) to vim-plug's (1 arg)
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

" My plugins
"Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'alerque/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-characterize'
Plug 'gcmt/wildfire.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sdanielf/vim-stdtabs'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
"Plug 'vim-scripts/taglist.vim'
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
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-wheel'
Plug 'alerque/vim-sile', { 'for': 'sile' }
Plug 'severin-lemaignan/vim-minimap'
Plug '907th/vim-auto-save'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'gisraptor/vim-lilypond-integrator', { 'for': 'lilypond' }
Plug 'trusktr/seti.vim'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': 'pandoc' }
Plug 'vim-pandoc/vim-criticmarkup', { 'for': ['markdown', 'pandoc'] }
Plug 'benekastah/neomake'
Plug 'junegunn/vim-easy-align'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'cazador481/fakeclip.neovim'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
" Plug 'vim-scripts/PreserveNoEOL'
call plug#end()

" Default indent style when no filetype specific style guide is in place
set tabstop=4
set shiftwidth=4
set shiftround
set noexpandtab
set cindent
set autoindent

" Don't wrap long lines by default (override for prose file types & Goyo mode)
set nowrap

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
let g:molokai_italic = 0

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
set matchpairs+=►:◄

" Use system clipboard for anonymous register
set clipboard+=unnamedplus
let g:vim_fakeclip_tmux_plus = 0

" Enable backspace over indent,eol,start,etc
set backspace=2

" Highlight search results
set hlsearch

" Do incremental search
set incsearch

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
let g:sneak#streak = 1
let g:sneak#use_ic_scs = 1
let g:sneak#target_labels = "aoeuiypqjkxsnthdfgcrlbmwvzAOEUIYPQJKXSNTHDFGCRLBMWVZ"

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

" Configure line wrapping to indent broken lines, only break on words, don't
" reformat long lines when editing, include comment leader wher reformatting,
" avoid single letter words at the end of lines, use the 2nd line in
" paragraphs for indent reference, and don't add space between multi-byte
" characters when joining.
set breakindent
set linebreak
set showbreak=…
set formatoptions+=lr12B

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
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#concealcursor = 'nc'
let g:pencil#conceallevel = 0
augroup pencil
	autocmd!
	autocmd FileType pandoc,markdown,mkd,text,tex,sile,usfm
		\  call lexical#init()
		\| call textobj#sentence#init()
		\| call textobj#quote#init({'educate': 0})
		\| call pencil#init()
augroup END

" Setup autosave plugin, off by default, enable with :AutoSaveToggle
let g:auto_save = 0 
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

" Explicitly enable True Color and cursor features for Neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Map Markdown Footnotes manually because its default of <leader>+f is taken
imap <Leader>^ <Plug>AddVimFootnote
nmap <Leader>^ <Plug>AddVimFootnote
imap <Leader>@ <Plug>ReturnFromFootnote
nmap <Leader>@ <Plug>ReturnFromFootnote

" Mappings for Easy Alignment plugin
xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

" Mapping to pull up ctags based navigator
nmap \t :TagbarToggle<CR>

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
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

" Disable CriticMarkup support in plugins that have it in favor of the
" dedicated plugin that injects it as an addition.
let g:markdown_criticmarkup = 0
let g:pandoc#syntax#critic_markup = 0
let g:markdown_criticmarkup_force_colors = 1

" Configure handling of smart (curly) quotes across plugins
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it", "iq", "aq", "iQ", "aQ"]
map <silent> <leader>qc <Plug>ReplaceWithCurly
map <silent> <leader>qs <Plug>ReplaceWithStraight

" Setup 8 digit numbers as date format even without dashes
au! User * SpeedDatingFormat %Y%m%d

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
	normal zr

	" Autocomplete email addresses for mutt
	call deoplete#enable()
	set omnifunc=mailcomplete#Complete
	let g:deoplete#omni_patterns.mail = ['^\(To\|Cc\|Bcc\|From\|Reply-To\)\+: \w\w\w\+']

	" Move around by line even in wrapped lines
	map j gj
	map k gk

	" Jump throuph things that get filled in
	map <C-n> :%call quemutt#FirstInPost()<CR>
	imap <C-n> <Esc>:%call quemutt#FirstInPost()<CR>
endfunction

" Don't add trailing new lines if the file didn't have one when opened
let g:PreserveNoEOL = 1

" For poor laptop and other pathetic (non Kinesis Advantage) map CTRL-e to Esc
nnoremap <C-e> <Esc>
vnoremap <C-e> <Esc>gV
onoremap <C-e> <Esc>
inoremap <C-e> <Esc>`^

" Configure Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*', '*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }

" Mapping to toggle educate (smart quote) mode from vim-textobj-quote
map <Leader>e :ToggleEducate<CR>

au VimEnter * if &diff | execute 'windo set wrap' | endif

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Force GitGutter to always show the sign column
let g:gitgutter_sign_column_always = 1

" Unset F option from campatability mode so we can use Alt keys in keymaps
set cpoptions-=F

" Set file encoding, first checking for byte order mark, then seeing if UTF8
" works. Adds Windows' Turkish encoding to defaults as check if Latin 1 fails.
set fileencodings=ucs-bom,utf8,default,latin1,cp1254

" Explicitly enable creation of backup files
set backup

" Done reset cursor to the start of lines after linewise commands
set nostartofline

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
:command! -nargs=+ Calc :r! python -c "from math import *; print (<args>)"

" Map space to page down in normal mode
map <space> <C-d>

" Use Alt+; as shortcut co command prompt (modern terminal + nvim only, see
" git gistory for how to do this on older systems).
map <M-;> :
imap <M-;> <Esc><Esc>:

" Toggle search result highlighting
map <F5> :set hlsearch!<bar>set hlsearch?<CR>

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

" vim: ts=4:sw=4:noet
