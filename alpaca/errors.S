
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

msg_token_overflow:
	.ascii "[ERROR] Token Overflow.\n"
msg_token_overflow_len = . - msg_token_overflow

msg_not_implemented:
	.ascii "[ERROR] Not Implemented.\n"
msg_not_implemented_len = . - msg_not_implemented

msg_internal:
	.ascii "[ERROR] Internal Error.\n"
msg_internal_len = . - msg_internal

msg_end_of_file:
	.ascii "[ERROR] Unexpected End of File.\n"
msg_end_of_file_len = . - msg_end_of_file

msg_syntax:
	.ascii "[ERROR] Invalid Syntax.\n"
msg_syntax_len = . - msg_syntax

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

.global error_internal
error_internal: # () -> EXIT 1
	lea (msg_internal), %rsi
	mov $msg_internal_len, %rdx
	jmp error_buffer

.global error_end_of_file
error_end_of_file: # () -> EXIT 1
	lea (msg_end_of_file), %rsi
	mov $msg_end_of_file_len, %rdx
	jmp error_buffer

.global error_syntax
error_syntax: # () -> EXIT 1
	lea (msg_syntax), %rsi
	mov $msg_syntax_len, %rdx
	jmp error_buffer

error_buffer: # (%rsi: msg, %rdx: len) -> EXIT 1
	mov $SYS_WRITE, %rax
	mov $STDERR, %rdi
	syscall

	mov $SYS_EXIT, %rax
	mov $1, %rdi
	syscall
