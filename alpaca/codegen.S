
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

.bss

current_character:
	.zero 1

.text

.global codegen_string
codegen_string: # (%rsi: buffer) -> ()
	push %rax
	push %rdx

	call string_length
	mov %rax, %rdx

	call codegen_buffer

	pop %rdx
	pop %rax

	ret

.global codegen_buffer
codegen_buffer: # (%rsi: buffer, %rdx: length) -> ()
	push %rax
	push %rdi

	mov $SYS_WRITE, %rax                         # Write Syscall
	mov $STDOUT, %rdi                            #   file descriptor
	                                             #   buffer pointer
	                                             #   buffer length
	syscall

	pop %rdi
	pop %rax

	ret

.global codegen_uid
codegen_uid: # (%rax: integer) -> ()
	#### Register Usage ####
	# rax - TRAMPLED
	#  bl - Current character
	# rcx - TRAMPLED
	# rdx - TRAMPLED
	# rsi - TRAMPLED
	#  r8 - Number

	push %rax
	push %rbx
	push %rcx
	push %rdx
	push %rsi
	push %r8

	mov %rax, %r8

	mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi
	lea (current_character), %rsi
	mov $1, %rdx

cuid_loop_start:
	mov %r8, %rbx
	and $0b1111, %rbx
	add $'A', %bl
	mov %bl, (current_character)

	syscall

	shr $4, %r8
	cmp $0, %r8
	je cuid_loop_end

	jmp cuid_loop_start
cuid_loop_end:

	pop %r8
	pop %rsi
	pop %rdx
	pop %rcx
	pop %rbx
	pop %rax

	ret
