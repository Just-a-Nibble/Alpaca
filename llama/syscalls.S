
SYS_READ  = 0
SYS_WRITE = 1
SYS_EXIT  = 60

.text

.global sys_read
sys_read: # ( fd buf len -- len )
	mov $0,       %rax
	mov -24(%r8), %rdi
	mov -16(%r8), %rsi
	mov  -8(%r8), %rdx
	syscall

	mov %rax, -24(%r8)
	sub $16, %r8

	ret

.global sys_write
sys_write: # ( fd buf len -- len )
	mov $1,       %rax
	mov -24(%r8), %rdi
	mov -16(%r8), %rsi
	mov  -8(%r8), %rdx
	syscall

	mov %rax, -24(%r8)
	sub $16, %r8

	ret

.global sys_exit
sys_exit: # ( code -- )
	mov $60,     %rax
	mov -8(%r8), %rdi
	syscall
