" Using equalsraf/neovim-gui-shim plugin to set GUI font in Gonvim
if exists('g:GuiLoaded')
	GuiFont Hack:h10
	GuiLinespace 0
endif

" Font config for neovim-ghk
call rpcnotify(1, 'Gui', 'Font', 'Hack 14')
