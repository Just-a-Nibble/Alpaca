
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

.global str_eq
str_eq:
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	sub $8, %r8

_str_eq_loop_start:
	mov (%rax), %cl
	mov (%rbx), %dl

	cmp %cl, %dl
	jne _str_eq_return_false

	cmp $0, %cl
	je _str_eq_return_true

	inc %rax
	inc %rbx

	jmp _str_eq_loop_start

_str_eq_return_true:
	movq $1, -8(%r8)
	ret

_str_eq_return_false:
	movq $0, -8(%r8)
	ret
