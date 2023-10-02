
.text

.global string_equals
string_equals: # (%rsi: string, %rdi: string) -> (ZF)
	push %rax
	push %rbx
	push %rsi
	push %rdi

_se_loop_start:
	mov (%rsi), %al
	mov (%rdi), %bl

	cmp %al, %bl
	jne _se_loop_end

	cmp $0, %al
	je _se_loop_end

	inc %rsi
	inc %rdi

	jmp _se_loop_start
_se_loop_end:

	pop %rdi
	pop %rsi
	pop %rbx
	pop %rax

	ret

.global string_length
string_length: # (%rsi: string) -> (%rax: length)
	push %rcx
	push %rsi

	mov $0, %rax
	dec %rax

_sl_loop_start:
	mov (%rsi), %cl
	inc %rsi
	inc %rax

	cmp $0, %cl
	jne _sl_loop_start

	pop %rsi
	pop %rcx

	ret
