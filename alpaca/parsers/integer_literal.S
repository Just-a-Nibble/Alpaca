
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

asm_integer_literal_0:
	.ascii "\tmovq $"
asm_integer_literal_0_len = . - asm_integer_literal_0

asm_integer_literal_1:
	.ascii          ", (%r8)\n"
	.ascii "\tadd $8, %r8\n"
asm_integer_literal_1_len = . - asm_integer_literal_1

.text

.global parse_integer_literal
parse_integer_literal:
	#### GENERATED ASSEMBLY ####
	#   mov $<current_token>, (%r8)
	#   add $8, %r8

	push %rdx
	push %rsi

	lea (asm_integer_literal_0), %rsi
	mov $asm_integer_literal_0_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_integer_literal_1), %rsi
	mov $asm_integer_literal_1_len, %rdx
	call codegen_buffer

	pop %rsi
	pop %rdx

	ret
