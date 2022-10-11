" Alternate insert mode with Russian JCUKEN keyboard emulation (from Dvorak)
" See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
" See: http://vi.stackexchange.com/q/2260/267
let b:keymap_name = "jcu"

loadkeymap
; й
, ц
. у
p к
y е
f н
g г
c ш
r щ
l з
/ х
@ ъ
<Bslash> \
a ф
o ы
e в
u а
i п
d р
h о
t л
n д
s д
- Э
­ э
' я
q ч
j с
k м
x и
b т
m ь
w б
v ю
z .
: Й
< Ц
> У
P К
Y Е
F Н
G Г
C Ш
R Щ
L З
? Х
" ¿ ?
^ Ъ
"| |
A Ф
O Ы
E В
U А
I П
D Р
H О
T Л
N Д
S Ж
_ Э
\" Я
Q Ч
J С
K М
X И
B Т
M Ь
W Б
V Ю
Z ,

" Helpers to get some things from the DVP positions using Alt
" <M-@> @
" <M-^> ^
" <M--> -
" <M-_> _
" <M-'> '
" <M-?> ?
" <M-"> "
" <M-s> §
" <M-Bslash> \\
" <M-|> |

" Because typeing Shift+Alt- on Advantage/DVORAK is not as good as normal
" Turkish-F positions
" <M-[> "
" <M-/> ?
" <M-?> /
