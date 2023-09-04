
.text

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
	cmp $'\0', %al
	je _is_return
_is_return:
	ret
