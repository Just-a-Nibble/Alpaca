
.text

.global add
add: # ( a b -- a+b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	add %rbx, %rax

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global sub
sub: # ( a b -- a-b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	sub %rbx, %rax

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global mult
mult: # ( a b -- a*b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	imul %rbx

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global div
div: # ( a b -- a/b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	idiv %rbx

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global mod
mod: # ( a b -- a%b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	idiv %rbx

	mov %rdx, -16(%r8)
	sub $8, %r8

	ret

.global umult
umult: # ( a b -- a*b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	mul %rbx

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global udiv
udiv: # ( a b -- a/b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	div %rbx

	mov %rax, -16(%r8)
	sub $8, %r8

	ret

.global umod
umod: # ( a b -- a%b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov $0, %rdx
	div %rbx

	mov %rdx, -16(%r8)
	sub $8, %r8

	ret
