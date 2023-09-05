
.include "alpaca/filenos.h"
.include "alpaca/syscalls.h"

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
