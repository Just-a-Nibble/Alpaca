
.text

asm_function_declaration_0:
	.ascii "\n"
	.ascii ".text\n"
	.ascii ".global "
asm_function_declaration_0_len = . - asm_function_declaration_0

asm_function_declaration_1:
	.ascii "\n"
asm_function_declaration_1_len = . - asm_function_declaration_1

asm_function_declaration_2:
	.ascii ":\n"
asm_function_declaration_2_len = . - asm_function_declaration_2

asm_function_declaration_3:
	.ascii "\tret\n"
asm_function_declaration_3_len = . - asm_function_declaration_3

.text

.global parse_function_declaration
parse_function_declaration:
	#### GENERATED ASSEMBLY ####
	# .text
	# .global <current_token>
	# <current_token>:
	#   ...parse statements...
	#   ret

	push %rdx
	push %rsi
	push %rdi

	call next_token

	lea (asm_function_declaration_0), %rsi
	mov $asm_function_declaration_0_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_function_declaration_1), %rsi
	mov $asm_function_declaration_1_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_function_declaration_2), %rsi
	mov $asm_function_declaration_2_len, %rdx
	call codegen_buffer

_pfd_loop_start:
	call next_token
	lea (current_token), %rdi

	lea (keyword_end), %rsi
	call string_equals
	je _pfd_loop_end

	call parse_statement

	jmp _pfd_loop_start
_pfd_loop_end:

	lea (asm_function_declaration_3), %rsi
	mov $asm_function_declaration_3_len, %rdx
	call codegen_buffer

	pop %rdi
	pop %rsi
	pop %rdx

	ret
