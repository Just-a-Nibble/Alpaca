
.text

asm_addr_of_0:
	.ascii "\tlea ("
asm_addr_of_0_len = . - asm_addr_of_0

asm_addr_of_1:
	.ascii          "), %rax\n"
	.ascii "\tmov %rax, (%r8)\n"
	.ascii "\tadd $8, %r8\n"
asm_addr_of_1_len = . - asm_addr_of_1

.text

# TODO: Implement @ (load)
# TODO: Implement @<identifier> (load from identifier)
# TODO: Implement ! (store)
# TODO: Implement !<identifier> (store to identifier)
# TODO: Implement &<identifier> (addr_of)

.global parse_addr_of
parse_addr_of:
	#### GENERATED ASSEMBLY ####
	# lea (<current_token+1>), %rax
	# mov %rax, (%r8)
	# add $8, %r8

	push %rsi
	push %rdx

	call next_token

	lea (asm_addr_of_0), %rsi
	mov $asm_addr_of_0_len, %rdx
	call codegen_buffer

	lea (current_token), %rsi
	call codegen_string

	lea (asm_addr_of_1), %rsi
	mov $asm_addr_of_1_len, %rdx
	call codegen_buffer

	pop %rdx
	pop %rsi

	ret
