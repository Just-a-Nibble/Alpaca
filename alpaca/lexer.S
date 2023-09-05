
.include "alpaca/syscalls.h"

MAX_TOKEN_LENGTH = 512

.bss

current_character:
	.zero 1

.global current_token
current_token:
	.zero MAX_TOKEN_LENGTH+1

.text

next_character: # (%rdi: fd) -> (%al: char)
	mov $SYS_READ, %rax                          # Read Syscall
	                                             #   file descriptor passed in
	lea (current_character), %rsi                #   destination buffer
	mov $1, %rdx                                 #   buffer size
	syscall

	cmp $1, %rax                                 # Check for success
	je _nc_return                                #   if so, return

	movb $0, (current_character)                 # If not, return null byte
_nc_return:
	mov $0, %rax                                 # Not necessary, clear upper bytes
	mov (current_character), %al                 # Load character into return

	ret                                          # Return

.global next_token
next_token: # (%rdi: fd) -> ()
	#### REGISTER USAGE ####
	#  %al: Current character
	# %rbx: Buffer Pointer
	# %rcx: TRAMPLED
	# %rdx: TRAMPLED
	# %rsi: TRAMPLED
	# %rdi: File Descriptor
	#  %r8: Buffer Length

	push %rax                                    # Push register state
	push %rbx
	push %rcx
	push %rdx
	push %rsi
	push %r8

	mov $0, %rax                                 # Not necessary, clear upper bytes
	lea (current_token), %rbx                    # Set buffer write pointer
	mov $0, %r8                                  # Set buffer length

_nt_space_loop_start:
	call next_character                          # Read next character

	cmp $0, %al                                  # Check if we reached file end
	je _nt_return                                #   if so, return

	call isspace                                 # Check if we reached a space
	je _nt_space_loop_start                      #   if so, repeat loop

	cmp $'\"', %al                               # Check for string literal
	je error_not_implemented                     #   if so, throw error (not implemented)

	cmp $'(', %al                                # Check for comment
	je error_not_implemented                     #   if so, throw error (not implemented)

_nt_loop_start:
	movb %al, (%rbx)                             # Write character to token
	inc %rbx                                     #   step write pointer foreward

	cmp $MAX_TOKEN_LENGTH, %r8                   # Check if over token length
	jge error_token_overflow                     #   if so, display error
	inc %r8                                      #   if not, increment length

	call next_character                          # Read next character

	call isspace                                 # Check if we reached token end
	jne _nt_loop_start                           #   if not, read next character

_nt_return:
	movb $0, (%rbx)                              # Null terminate token

	pop %r8                                      # Pop register state
	pop %rsi
	pop %rdx
	pop %rcx
	pop %rbx
	pop %rax

	ret                                          # Return
