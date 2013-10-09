.globl main
.globl string
#.globl convert
#.globl mean
#.globl median
.globl disString
#.globl disArray
.data
buffer:
	.space 200
		#start at spot 0, end at spot 199
string_prompt:
	.asciiz "Enter a string of ASCII comma seperated signed integers\n"
		#start at spot 200, end at spot 256
display_string_prompt:
	.asciiz "Your answer is\n"
		#start at spot 257, end at spot 272
main_menu_prompt:
	.asciiz "Enter: 1-Enter a string 2-Display String 3-Convert String\n"
		#start at spot 273, end at spot 331
	.asciiz "4-Mean 5-Median 6-Display Array\n"
		#start at spot 332, end at spot 364
.text

main:
		addi $sp, $sp, -4	#Save return register to stack
		sw $ra, ($sp)

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 273		#prompt location in the array
		syscall

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 332		#prompt location in the array
		syscall

		addi $v0, $0, 5			#Read Integer
		syscall

		add $t0, $0, $v0		#add v0 to t0

		beq $t0, 1,string		#branch to string
		beq $t0, 2, disString

		jr $ra					#Return to top of main
		or $0, $0, $0			#Delay Slot(branch)
string:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 200		#prompt location in the array
		syscall
		addi $v0, $0, 8			#read input_string
		lui $a0, 0x1000			#load data array
		addi $a1, $0, 200		#sets max string length
		add $s0, $0, $a0		#add input_string to s0
		syscall
		jal main

disString:
		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 257		#prompt location in the array
		syscall
		addi $v0, $0, 4			#print input_string
		add $a0, $0, $s0		#add input_string to a0
		syscall
