
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

.global parse_statement
parse_statement:
	push %rax

_ps_check_integer_literal:
	mov (current_token), %al
	call isdigit
	jne _ps_check_call
	call parse_integer_literal
	jmp _ps_return

_ps_check_call:
	call parse_function_call
	jmp _ps_return

_ps_return:
	pop %rax

	ret
