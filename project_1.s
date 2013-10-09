.globl main
#.globl string
#.globl convert
#.globl mean
#.globl median
#.globl displayString
#.globl displayArray
.data
buffer:
	.space 200
		#start at spot 0, end at spot 199
string_prompt:
	.asciiz "Enter a string of ASCII comma seperated signed integers\n"
		#start at spot 200, end at spot 256
	.asciiz "Your answer is\n"
		#start at spot 257, end at spot 272
.text

main:

string:
		addi $v0, $0, 4		#print prompt
		lui $a0, 0x1000		#load data array
		addi $a0, $a0, 200	#prompt location in the array
		syscall
		addi $v0, $0, 8		#read string
		lui $a0, 0x1000
		addi $a1, $0, 200
		add $t0, $0, $a0
		syscall
		addi $v0, $0, 4		#print prompt
		lui $a0, 0x1000		#load data array
		addi $a0, $a0, 257	#prompt location in the array
		syscall
		addi $v0, $0, 4
		add $a0, $0, $t0
		syscall
