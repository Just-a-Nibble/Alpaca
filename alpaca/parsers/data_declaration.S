
.text

asm_data_declaration_0:
	.ascii "\n"
	.ascii ".data\n"
	.ascii ".global "
asm_data_declaration_0_len = . - asm_data_declaration_0

asm_data_declaration_1:
	.ascii "\n"
asm_data_declaration_1_len = . - asm_data_declaration_1

asm_data_declaration_2:
	.ascii ":\n"
asm_data_declaration_2_len = . - asm_data_declaration_2

asm_data_declaration_3:
	.ascii "\t.quad "
asm_data_declaration_3_len = . - asm_data_declaration_3

.text

.global parse_data_declaration
parse_data_declaration:
	#### GENERATED ASSEMBLY ####
	# .data
	# .global <current_token+0>
	# <current_token+0>:
	#   .quad <current_token+0>

	push %rdx
	push %rsi
	push %rdi

	call next_token

	lea (asm_data_declaration_0), %rsi
	mov $asm_data_declaration_0_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_data_declaration_1), %rsi
	mov $asm_data_declaration_1_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_data_declaration_2), %rsi
	mov $asm_data_declaration_2_len, %rdx
	call codegen_buffer

_pdd_loop_start:
	call next_token
	lea (current_token), %rsi

	lea (keyword_end), %rdi
	call string_equals
	je _pdd_loop_end

	lea (asm_data_declaration_3), %rsi
	mov $asm_data_declaration_3_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_data_declaration_1), %rsi
	mov $asm_data_declaration_1_len, %rdx
	call codegen_buffer

	jmp _pdd_loop_start
_pdd_loop_end:

	pop %rdi
	pop %rsi
	pop %rdx

	ret
