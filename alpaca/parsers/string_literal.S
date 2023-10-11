
.text

asm_string_literal_0:
	.ascii ".data\n"
	.ascii "_label_string_"
asm_string_literal_0_len = . - asm_string_literal_0

asm_string_literal_1:
	.ascii                 ":\n"
	.ascii "\t.asciz "
asm_string_literal_1_len = . - asm_string_literal_1

asm_string_literal_2:
	.ascii            "\n"
	.ascii ".text\n"
	.ascii "\tlea (_label_string_"
asm_string_literal_2_len = . - asm_string_literal_2

asm_string_literal_3:
	.ascii                        "), %rax\n"
	.ascii "\tmov %rax, (%r8)\n"
	.ascii "\tadd $8, %r8\n"
asm_string_literal_3_len = . - asm_string_literal_3

.data

label_string_uid:
	.quad 0

.text

.global parse_string_literal
parse_string_literal:
	#### GENERATED ASSEMBLY ####
	# .data
	# _label_string_<label_string_uid>:
	#   .asciz <current_token>
	# .text
	#   lea (_label_string_<label_string_uid>), %rax
	#   mov %rax, (%r8)
	#   add $8, %r8

	push %rax
	push %rdx
	push %rsi

	mov (label_string_uid), %rax

	lea (asm_string_literal_0), %rsi
	mov $asm_string_literal_0_len, %rdx
	call codegen_buffer

	call codegen_uid

	lea (asm_string_literal_1), %rsi
	mov $asm_string_literal_1_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_string_literal_2), %rsi
	mov $asm_string_literal_2_len, %rdx
	call codegen_buffer

	call codegen_uid

	lea (asm_string_literal_3), %rsi
	mov $asm_string_literal_3_len, %rdx
	call codegen_buffer

	inc %rax
	mov %rax, (label_string_uid)

	pop %rsi
	pop %rdx
	pop %rax

	ret
