	.data
val1:	.4byte	10
val2:	.4byte	20
result:	.space	4

	.text
	.global main
main:	ldr	r0, =val1
	ldr	r1, =val2
	ldr	r2, [r0]
	ldr	r3, [r1]
	add	r4, r2, r3
	ldr	r0, =result
	str	r4, [r0]

stop:	b	stop
