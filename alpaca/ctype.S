
.text

.global isdigit
isdigit: # (%al: char) -> ZF
	cmp $'0', %al
	jl _id_return
	cmp $'9', %al
	jg _id_return
	cmp %al, %al
_id_return:
	ret

.global isspace
isspace: # (%al: char) -> ZF
	cmp $' ', %al
	je _is_return
	cmp $'\t', %al
	je _is_return
	cmp $'\r', %al
	je _is_return
	cmp $'\n', %al
	je _is_return
	cmp $0, %al
	je _is_return
_is_return:
	ret
