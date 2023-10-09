
.include "alpaca/syscalls.h"

.text

.global _start
_start:
_loop_start:
	call next_token

	movb (current_token), %al
	cmp $0, %al
	je _loop_end

	lea (current_token), %rsi

_check_function_declaration:
	lea (keyword_def), %rdi
	call string_equals
	jne _check_data_declaration
	call parse_function_declaration
	jmp _loop_start

_check_data_declaration:
	lea (keyword_data), %rdi
	call string_equals
	jne _check_end
	call parse_data_declaration
	jmp _loop_start

_check_end:
	jmp error_syntax

_loop_end:

	mov $SYS_EXIT, %rax
	mov $0, %rdi
	syscall
