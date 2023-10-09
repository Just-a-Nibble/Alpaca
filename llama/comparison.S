
.text

.global eq
eq: # ( a b -- a==b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jne _eq_false
	movq $1, -16(%r8)
	jmp _eq_end
_eq_false:
	movq $0, -16(%r8)
_eq_end:
	sub $8, %r8
	ret

.global neq
neq: # ( a b -- a!=b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jne _neq_false
	movq $0, -16(%r8)
	jmp _neq_end
_neq_false:
	movq $1, -16(%r8)
_neq_end:
	sub $8, %r8
	ret

.global less
less: # ( a b -- a<b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jge _less_false
	movq $0, -16(%r8)
	jmp _less_end
_less_false:
	movq $1, -16(%r8)
_less_end:
	sub $8, %r8
	ret

.global great
great: # ( a b -- a>b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jle _great_false
	movq $0, -16(%r8)
	jmp _great_end
_great_false:
	movq $1, -16(%r8)
_great_end:
	sub $8, %r8
	ret

.global leq
leq: # ( a b -- a<=b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jg _leq_false
	movq $0, -16(%r8)
	jmp _leq_end
_leq_false:
	movq $1, -16(%r8)
_leq_end:
	sub $8, %r8
	ret

.global geq
geq: # ( a b -- a>=b )
	mov -16(%r8), %rax
	mov  -8(%r8), %rbx
	cmp %rax, %rbx
	jl _geq_false
	movq $0, -16(%r8)
	jmp _geq_end
_geq_false:
	movq $1, -16(%r8)
_geq_end:
	sub $8, %r8
	ret
