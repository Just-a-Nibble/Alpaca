
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.text

asm_function_call_0:
	.ascii "\tcall "
asm_function_call_0_len = . - asm_function_call_0

asm_function_call_1:
	.ascii "\n"
asm_function_call_1_len = . - asm_function_call_1

.text

.global parse_function_call
parse_function_call:
	#### GENERATED ASSEMBLY ####
	#   call <current_token>

	push %rdx
	push %rsi

	lea (asm_function_call_0), %rsi
	mov $asm_function_call_0_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_function_call_1), %rsi
	mov $asm_function_call_1_len, %rdx
	call codegen_buffer

	pop %rsi
	pop %rdx

	ret
