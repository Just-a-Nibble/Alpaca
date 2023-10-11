
SYS_READ  = 0
SYS_WRITE = 1

STDIN  = 0
STDOUT = 1
STDERR = 2

.text

.global puts
puts: # ( s -- )
	call dup
	call str_len

	mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi
	mov -16(%r8), %rsi
	mov -8(%r8), %rdx
	syscall

	sub $16, %r8

	ret
