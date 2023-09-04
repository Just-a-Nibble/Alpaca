
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

.global _start
_start:
_loop_start:
	mov $STDIN, %rdi
	call next_token

	movb (current_token), %al
	cmp $0, %al
	jne _loop_start

	mov $SYS_EXIT, %rax
	mov $0, %rdi
	syscall
