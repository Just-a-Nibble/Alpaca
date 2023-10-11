
.text

.global load8
load8: # (p -- v)
	mov $0, %rax
	mov -8(%r8), %rbx
	mov (%rbx), %al
	mov %rax, -8(%r8)

	ret

.global load
load: # (p -- v)
	mov -8(%r8), %rax
	mov (%rax), %rax
	mov %rax, -8(%r8)

	ret

.global store8
store8: # ( p v -- )
	mov -16(%r8), %rbx
	mov  -8(%r8), %rax
	mov %al, (%rbx)
	sub $16, %r8

	ret

.global store
store: # ( p v -- )
	mov -16(%r8), %rbx
	mov  -8(%r8), %rax
	mov %rax, (%rbx)
	sub $16, %r8

	ret

.global temp
temp: # ( -- 0 p )
	mov %r8, %rax
	movq $0, (%r8)
	mov %rax, 8(%r8)
	add $16, %r8

	ret
