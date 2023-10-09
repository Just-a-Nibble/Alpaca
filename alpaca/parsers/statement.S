
.text

.global parse_statement
parse_statement:
	push %rax

_ps_check_end_of_file:
	mov (current_token), %al
	cmp $0x00, %al
	je error_end_of_file

_ps_check_integer_literal:
	call isdigit
	jne _ps_check_keyword_if
	call parse_integer_literal
	jmp _ps_return

_ps_check_keyword_if:
	lea (current_token), %rdi
	lea (keyword_if), %rsi
	call string_equals
	jne _ps_check_keyword_addr_of
	call parse_if_else
	jmp _ps_return

_ps_check_keyword_addr_of:
	lea (current_token), %rdi
	lea (keyword_addr_of), %rsi
	call string_equals
	jne _ps_check_keyword_else
	call parse_addr_of
	jmp _ps_return

_ps_check_keyword_else:
	lea (current_token), %rdi
	lea (keyword_else), %rsi
	call string_equals
	je error_syntax

_ps_check_keyword_end:
	lea (current_token), %rdi
	lea (keyword_end), %rsi
	call string_equals
	je error_internal

_ps_check_call:
	call parse_function_call
	jmp _ps_return

_ps_return:
	pop %rax

	ret
