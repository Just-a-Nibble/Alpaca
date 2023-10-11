
.text

.global str_len
str_len: # ( s -- n )
	mov $0, %rax
	mov -8(%r8), %rbx

	dec %rax

_str_len_loop_start:
	mov (%rbx), %cl
	inc %rax
	inc %rbx

	cmp $0, %cl
	jne _str_len_loop_start

	mov %rax, -8(%r8)

	ret
