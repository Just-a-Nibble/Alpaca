
STACK_SIZE = 512

.bss

.global __internal_data_stack
__internal_data_stack:
	.zero 8*STACK_SIZE

.text

.global _start
_start:
	lea (__internal_data_stack), %r8

	add $8, %r8
	movq $0, -8(%r8)

	call main

	mov $60, %rax
	mov -8(%r8), %rdi
	syscall

	ret
