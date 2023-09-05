
.text

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
