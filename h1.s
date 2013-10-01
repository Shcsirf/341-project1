.globl main
.data
.text

main:
		addi $a0, $0, 10	#storing 10 in a0
		addi $a1, $0, 2		#storing 2 in a1
		div $a0, $a1
