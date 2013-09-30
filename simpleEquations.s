.globl main
.data
x:	.byte 3
y:	.byte 0
z:	.byte 4
answer:
	.asciiz "The answer is: "
.text
main:
		lui $t0, 0x1000
		lb $t1, 0($t0)
		lb $t2, 2($t0)
		add $t1, $t1, $t2
		sb $t1, 1($t0)

		addi $v0, $0, 1
		add $a0, $0, $t0
		syscall
