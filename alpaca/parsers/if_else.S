
.text

asm_if_else_header:
	.ascii "\tsub $8, %r8\n"
	.ascii "\tmov (%r8), %rax\n"
	.ascii "\tcmp $0, %rax\n"
	.ascii "\tje _label_if_"
asm_if_else_header_len = . - asm_if_else_header

asm_if_else_0:
	.ascii "\n_label_if_"
asm_if_else_0_len = . - asm_if_else_0

asm_if_else_1:
	.ascii "\tjmp _label_if_"
asm_if_else_1_len = . - asm_if_else_1

asm_if_else_newline:
	.ascii "\n"
asm_if_else_newline_len = . - asm_if_else_newline

asm_if_else_label:
	.ascii "_label_if_"
asm_if_else_label_len = . - asm_if_else_label

asm_if_else_label_end:
	.ascii ":\n"
asm_if_else_label_end_len = . - asm_if_else_label_end

.data

label_if_uid:
	.quad 0

.text

.global parse_if_else
parse_if_else:
	#### GENERATED ASSEMBLY (if) ####
	#   sub $8, %r8
	#   mov (%r8), %rax
	#   cmp $0, %rax
	#   je _labelX
	#   ... statements ...
	# _labelX:

	#### GENERATED ASSEMBLY (if-else) ####
	#   sub $8, %r8
	#   mov (%r8), %rax
	#   cmp $0, %rax
	#   je _labelX
	#   ... statements ...
	#   jmp _labelY
	# _labelX:
	#   ... statements ...
	# _labelY:

	push %rax
	push %rdx
	push %rsi
	push %rdi

	mov (label_if_uid), %rax
	add $2, %rax
	mov %rax, (label_if_uid)
	sub $2, %rax

_pie_true_header:
	lea (asm_if_else_header), %rsi
	mov $asm_if_else_header_len, %rdx
	call codegen_buffer

	call codegen_uid

	lea (asm_if_else_newline), %rsi
	mov $asm_if_else_newline_len, %rdx
	call codegen_buffer

_pie_true_start:
	call next_token
	lea (current_token), %rdi

	lea (keyword_else), %rsi
	call string_equals
	je _pie_false_header

	lea (keyword_end), %rsi
	call string_equals
	je _pie_end

	call parse_statement

	jmp _pie_true_start

_pie_false_header:
	lea (asm_if_else_1), %rsi
	mov $asm_if_else_1_len, %rdx
	call codegen_buffer

	inc %rax
	call codegen_uid

	lea (asm_if_else_newline), %rsi
	mov $asm_if_else_newline_len, %rdx
	call codegen_buffer

	lea (asm_if_else_label), %rsi
	mov $asm_if_else_label_len, %rdx
	call codegen_buffer

	dec %rax
	call codegen_uid
	inc %rax

	lea (asm_if_else_label_end), %rsi
	mov $asm_if_else_label_end_len, %rdx
	call codegen_buffer

_pie_false_start:
	call next_token
	lea (current_token), %rdi

	lea (keyword_end), %rsi
	call string_equals
	je _pie_end

	call parse_statement

	jmp _pie_false_start
_pie_end:

	lea (asm_if_else_label), %rsi
	mov $asm_if_else_label_len, %rdx
	call codegen_buffer

	call codegen_uid

	lea (asm_if_else_label_end), %rsi
	mov $asm_if_else_label_end_len, %rdx
	call codegen_buffer

	pop %rdi
	pop %rsi
	pop %rdx
	pop %rax

	ret
