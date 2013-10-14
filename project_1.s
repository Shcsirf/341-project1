.globl main
.globl comma
.globl string
.globl convert
#.globl mean
#.globl median
.globl disString
.globl disArray
.globl exitProgram
.data
string_buffer:
	.space 100
		#start at spot 0, end at spot 99
.align 1
input_array:
	.space 100
		#start at spot 100, end at spot 199
convert_array:
	.space 100
		#start at spot 200, end at spot 299
string_prompt:
	.asciiz "Enter a string of ASCII comma seperated signed integers\n"
		#start at spot 300, end at spot 356
display_string_prompt:
	.asciiz "Your string is\n"
		#start at spot 357, end at spot 372
main_menu_prompt:
	.asciiz "Enter:\n 1-Input String 2-Display String 3-Convert String\n"
		#start at spot 373, end at spot 431
	.asciiz " 4-Mean 5-Median 6-Display Array\n 7-Exit Program\n"
		#start at spot 431, end at spot 481
	.asciiz "Please enter a nunmber from the given menu\n"
		#start at spot 481, end at spot 525
exit_prompt:
	.asciiz "Program is now exiting, Have a Nice Day!\n"
		#start at spot 525, end at spot 567
convert_prompt:
	.asciiz "The following were removed as duplicates:\n"
		#starts at 567, end at spot 608
.text

main:
		#addi $sp, $sp, -4	#Save return register to stack
		#sw $ra, ($sp)

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 373		#prompt location in the array
		syscall

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 431		#prompt location in the array
		syscall

		addi $v0, $0, 5			#Read Integer
		syscall

		add $t0, $0, $v0		#add v0 to t0

		beq $t0, 1,string		#branch to string
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 2, disString	#branch to disString
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 3, convert		#branch to convert
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 6, disArray	#branch to disArray
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 7, exitProgram	#branch to exit
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 481		#prompt location in the array
		syscall

		j main					#Return to top of main
		or $0, $0, $0			#Delay Slot (Branch)

string:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 300		#prompt location in the array
		syscall

		addi $v0, $0, 8			#read input_string
		lui $a0, 0x1000			#load data array
		addi $a1, $0, 100		#sets max string length
		add $s0, $0, $a0		#add input_string to s0
		syscall
		add $s1, $0, $s0		#copies s0 into s1 used in convert
		add $t5, $0, $0			#initialize t5
		add $t8, $0, $0			#initialize t8

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

disString:
		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 357		#prompt location in the array
		syscall

		addi $v0, $0, 4			#print input_string
		add $a0, $0, $s0		#add input_string to a0
		syscall

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

convert:
		lb $t1, ($s1)			#Load s1
		or $0, $0, $0			#Delay Slot(load)

		beq $t1, 10, comma		#branch if null
		or $0, $0, $0			#Delay Slot(branch)

		beq $t1, 44, comma		#branch if comma
		or $0, $0, $0			#Delay Slot(branch)

		addi $t1, $t1, -48
		beq $t4, 1, next		#branch to next
		or $0, $0, $0			#Delay Slot(branch)
		add $t2, $0, $t1
		addi $t4, $0, 1			#Counter

		addi $s1, $s1, 1		#moving array spot by 1

		j convert
		or $0, $0, $0			#Delay Slot(branch)

next:
		add $t3, $0, $t2
		sll $t2, $t2, 3			#muliply by 10
		add $t2, $t2, $t3
		add $t2, $t2, $t3

		add $t2, $t2, $t1		#add second integer
		addi $s1, $s1, 1		#moving array spot by 1

		j convert
		or $0, $0, $0			#Delay Slot(branch)

comma:
		lui $s2, 0x1000
		or $0, $0, $0			#Delay Slot(branch)

		addi $s2, $s2, 100		#array spot 100
		add $s2, $s2, $t5		#last position in integer_array
		add $s2, $s2, $t5
		addi $t6, $s2, 2			#next spot in the integer_array

		beq $t5, $0, zero		#branch if first element
		or $0, $0, $0			#Delay Slot(branch)

loop:
		lh $t3, ($s2)
		or $0, $0, $0			#Delay Slot(branch)
		sub $t7, $t2, $t3		#compare current element and last element
		beq $t7, $0, equal		#branch if current = last element
		or $0, $0, $0			#Delay Slot(branch)
		bltz $t7, less			#branch if current < last element
		or $0, $0, $0			#Delay Slot(branch)

great:
		sh $t2, ($t6)			#store integer in next spot in array
		j checked
		or $0, $0, $0			#Delay Slot(branch)

equal:
		add $t8, $t8, 1			#Duplicate Counter
		j duplicate
		or $0, $0, $0			#Delay Slot(branch)

less:
		lh $t9, ($s2)			#value in last spot
		or $0, $0, $0			#Delay Slot(branch)
		sh $t9, ($t6)			#store the last element in the next spot
		addi $t6, $t6, -2		#move next spot back one
		addi $s2, $s2, -2		#move last spot back one
		lh $t9, ($s2)			#value in last spot
		or $0, $0, $0			#Delay Slot(branch)
		beq $t9, $t5, great		#branch if counter spot is reached
		or $0, $0, $0			#Delay Slot(branch)

		j loop
		or $0, $0, $0			#Delay Slot(branch)

zero:
		sh $t2, ($t6)		#store first elememt
checked:
		addi $t5, $t5, 1		#element counter
		sh $t5, 100($s0)		#store element count in first integer_array spot

duplicate:
		beq $t1, 10, finCon		#branch to end
		or $0, $0, $0			#Delay Slot(branch)

		addi $t4, $t4, -1		#reduce counter
		addi $s1, $s1, 1		#moving array spot by 1
		j convert
		or $0, $0, $0			#Delay Slot(branch)

finCon:
		lui $s2, 0x1000
		addi $s2, $s2, 100		#array spot 100

		addi $v0, $0, 1			#print integer
		add $a0, $0, $t2		
		syscall
		add $t1, $0, $0			#clear registers
		add $t2, $0, $0			#clear registers
		add $t3, $0, $0			#clear registers
		add $t4, $0, $0			#clear registers
		add $s3, $0, $t5		#save element counter
		add $t5, $0, $0			#clear registers
		add $t6, $0, $0			#clear registers
		add $t7, $0, $0			#clear registers
		add $t8, $0, $0			#clear registers
		add $t9, $0, $0			#clear registers
		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

disArray:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 567		#prompt location in the array
		syscall
		addi $t2, $s3, 1

print:
		lh $t1, ($s2)
		or $0, $0, $0			#Delay Slot(branch)
		addi $v0, $0, 1			#print integer
		add $a0, $0, $t1
		syscall
		addi $t2, $t2, -1		#decrement counter
		addi $s2, $s2, 2		#increment spot in array
		bne $t2, 0, print		#branch to print
		or $0, $0, $0			#Delay Slot(branch)

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

exitProgram:
		addi $v0, $0, 4			#print exit_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 525		#prompt location in the array
		syscall

		addi $v0, $0, 10		#Exit command
		syscall

