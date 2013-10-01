.globl main
.data
x:	.byte 3
y:	.byte 0
z:	.byte 4
question:
	.asciiz "What is 3+4?\n"
answer:
	.asciiz "The answer is: "
.text
main:
		lui $t0, 0x1000		#Load Data(Array) into t0
		lb $t1, 0($t0)		#Load X into t1
		lb $t2, 2($t0)		#Load Z into t2
		add $t1, $t1, $t2	#add X+Z and store in t1
		sb $t1, 1($t0)		#store t1 as Y

		addi $v0, $0, 4		#Print question Prompt
		lui $a0, 0x1000
		addi $a0, $a0, 3
		syscall


		addi $v0, $0, 4		#Print Answer Prompt
		lui $a0, 0x1000
		addi $a0, $a0, 17
		syscall

		addi $v0, $0, 1		#Prints Answer
		add $a0, $0, $t1
		syscall
