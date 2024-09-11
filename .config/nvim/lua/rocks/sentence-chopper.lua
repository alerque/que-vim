vim.g.punctuation_marks = ".;:?!"
vim.g.latexindent = 0

vim.keymap.set(
   "o",
   ".",
   [[:<c-u>call search('\v\C%(%([^[:digit:]IVX]\|[)''"])\zs[.]\|[,;:!?])[[:space:])''"]\|[.,;:!?]$','W')<CR>]],
   { remap = false, silent = true }
)
