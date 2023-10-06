
.text

.global drop
drop: # ( v -- )
	sub $8, %r8

	ret

.global dup
dup: # ( v -- v v )
	add $8, %r8

	mov -16(%r8), %rax

	mov %rax, -8(%r8)

	ret

.global swap
swap: # ( a b -- b a )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx

	mov %rax,  -8(%r8)
	mov %rbx, -16(%r8)

	ret

.global rot
rot: # ( a b c -- b c a )
	mov -24(%r8), %rax
	mov -16(%r8), %rbx
	mov  -8(%r8), %rcx

	mov %rbx, -24(%r8)
	mov %rcx, -16(%r8)
	mov %rax,  -8(%r8)

	ret

.global revrot
revrot: # ( a b c -- c a b )
	mov -24(%r8), %rax
	mov -16(%r8), %rbx
	mov  -8(%r8), %rcx

	mov %rcx, -24(%r8)
	mov %rax, -16(%r8)
	mov %rbx,  -8(%r8)

	ret

.global over
over: # ( a b -- a b a )
	add $8, %r8

	mov -24(%r8), %rax

	mov %rax, -8(%r8)

	ret

.global tuck
tuck: # ( a b -- b a b )
	add $8, %r8

	mov -24(%r8), %rax
	mov -16(%r8), %rbx

	mov %rbx, -24(%r8)
	mov %rax, -16(%r8)
	mov %rbx,  -8(%r8)

	ret

.global pick
pick: # ( xn .. x1 x0 i -- xn .. x1 x0 xi)
	mov -8(%r8), %rax

	# %rax = %r8 - 8 * %rax
	mov %r8, %rbx
	shl $3, %rax
	sub %rax, %rbx

	mov (%rbx), %rbx

	mov %rbx, (%r8)

	ret

# TODO
.global roll
