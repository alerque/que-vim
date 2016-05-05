" Alternate insert mode with Turkish-F keyboard emulation (from Dvorak)
" See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
" See: http://vi.stackexchange.com/q/2260/267
let b:keymap_name = "dvorak2turkishf"
loadkeymap
; f
\, g
. ğ
p ı
y o
f d
g r
c n
r h
l p
/ q
@ w
\\ x
<M-\\> \
a u
o i
e e
u a
i ü
d t
h k
t m
n l
s y
- ş
­ -
' j
q ö
j v
k c
x ç
b z
m s
w b
v .
z ,
: F
\< G
> Ğ
P I
Y O
F D
G R
C N
R H
L P
? Q
¿ ?
^ W
| X
A U
O İ
E E
U A
I Ü
D T
H K
T M
N L
S Y
_ Ş
\" J
Q Ö
J V
K C
X Ç
B Z
M S
W B
V :
Z ;

" Helpers to get some things from the DVP positions using Alt
<M-/> ?
<M-@> @
<M--> -
<M-'> '
<M-?> ?
<M-"> "
<M-s> §

" Because typeing Shift+Alt- on Advantage/DVORAK is not as good as normal
" Turkish-F positions
<M-[> "
<M-8> ?
