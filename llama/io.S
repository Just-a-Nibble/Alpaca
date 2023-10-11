
STDIN  = 0
STDOUT = 1
STDERR = 2

.text

.global fputs
fputs: # ( fd str -- )
	call dup
	call str_len
	call sys_write
	call drop
	ret

.global puts
puts: # ( s -- )
	movq $STDOUT, (%r8)
	add $8, %r8

	call swap

	call fputs

	ret

.global eputs
eputs: # ( s -- )
	movq $STDERR, (%r8)
	add $8, %r8

	call swap

	call fputs

	ret
