
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

msg_token_overflow:
	.ascii "[ERROR] Token Overflow.\n"
msg_token_overflow_len = . - msg_token_overflow

msg_not_implemented:
	.ascii "[ERROR] Not Implemented.\n"
msg_not_implemented_len = . - msg_not_implemented

.text

.global error_token_overflow
error_token_overflow: # () -> EXIT 1
	lea (msg_token_overflow), %rsi
	mov $msg_token_overflow_len, %rdx
	jmp error_buffer

.global error_not_implemented
error_not_implemented: # () -> EXIT 1
	lea (msg_not_implemented), %rsi
	mov $msg_not_implemented_len, %rdx
	jmp error_buffer

error_buffer: # (%rsi: msg, %rdx: len) -> EXIT 1
	mov $SYS_WRITE, %rax
	mov $STDERR, %rdi
	syscall

	mov $SYS_EXIT, %rax
	mov $1, %rdi
	syscall
