.globl main
.globl string
.globl convert
.globl mean
.globl median
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
string_prompt:
	.asciiz "Enter a string of ASCII comma seperated signed integers\n"
		#start at spot 200, end at spot 256
display_string_prompt:
	.asciiz "Your string is\n"
		#start at spot 257, end at spot 272
main_menu_prompt:
	.asciiz "Enter:\n 1-Input String 2-Display String 3-Convert String\n"
		#start at spot 273, end at spot 331
	.asciiz " 4-Mean 5-Median 6-Display Array\n 7-Exit Program\n"
		#start at spot 331, end at spot 381
	.asciiz "Please enter a nunmber from the given menu\n"
		#start at spot 381, end at spot 425
exit_prompt:
	.asciiz "Program is now exiting, Have a Nice Day!\n"
		#start at spot 425, end at spot 467
convert_prompt:
	.asciiz "The number of removed duplicates were:\n"
		#starts at 467, end at spot 506
display_array:
	.asciiz "Displaying Array: \n"
		#starts at 507, end at 526
newline_char:
	.asciiz "\n"
		#starts at 527, end at 528
element_count:
	.asciiz "Number of Elements: "
		#starts at 529, end at 549
no_string:
	.asciiz "Please enter a string first\n"
		#starts at 550, end at 578
no_convert:
	.asciiz "Please convert string first\n"
		#starts at 579, end at 607
mean_prompt:
	.asciiz "Your mean is:\n"
		#starts at 608, end at 622
median_prompt:
	.asciiz "Your median is:\n"
		#starts at 623, end at 637
.text

main:
		#addi $sp, $sp, -4	#Save return register to stack
		#sw $ra, ($sp)

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 273		#prompt location in the array
		syscall

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 331		#prompt location in the array
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
		beq $t0, 4, mean		#branch to mean
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 5, median		#branch to median
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 6, disArray	#branch to disArray
		or $0, $0, $0			#Delay Slot(branch)
		beq $t0, 7, exitProgram	#branch to exit
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print main_menu_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 381		#prompt location in the array
		syscall

		j main					#Return to top of main
		or $0, $0, $0			#Delay Slot (Branch)

string:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 200		#prompt location in the array
		syscall

		addi $v0, $0, 8			#read input_string
		lui $a0, 0x1000			#load data array
		addi $a1, $0, 100		#sets max string length
		add $s0, $0, $a0		#add input_string to s0
		syscall
		addi $s5, $0, 1			#string counter
		add $s1, $0, $s0		#copies s0 into s1 used in convert
		add $t5, $0, $0			#initialize t5
		add $t8, $0, $0			#initialize t8

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

disString:
		beq $s5, 1, string_exists
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 550		#prompt location in the array
		syscall

		j main
		or $0, $0, $0

string_exists:
		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 257		#prompt location in the array
		syscall

		addi $v0, $0, 4			#print input_string
		add $a0, $0, $s0		#add input_string to a0
		syscall

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

convert:
		beq $s5, 1, can_convert
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 550		#prompt location in the array
		syscall

		j main
		or $0, $0, $0

can_convert:
		add $s6, $0, 1			#convert counter
		lb $t1, ($s1)			#Load s1
		or $0, $0, $0			#Delay Slot(load)

		bne $t1, 45, not_neg
		or $0, $0, $0			#Delay Slot(branch)
		addi $s4, $0, 1			#neg counter
		addi $s1, $s1, 1		#moving array spot by 1

		j convert
		or $0, $0, $0			#Delay Slot(branch)

not_neg:
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

neg:
		sub $t2, $0, $t2
		addi $s4, $s4, 1

comma:
		beq $s4, 1, neg			#negative number
		add $t4, $0, $0			#clear counter
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
		addi $t4, $t4, 1		#increment counter
		lh $t9, ($s2)			#value in last spot
		or $0, $0, $0			#Delay Slot(branch)
		sh $t9, ($t6)			#store the last element in the next spot
		addi $t6, $t6, -2		#move next spot back one
		addi $s2, $s2, -2		#move last spot back one
		addi $t9, $s0, 100
		beq $t9, $s2, great		#branch if counter spot is reached
		or $0, $0, $0			#Delay Slot(branch)

		j loop
		or $0, $0, $0			#Delay Slot(branch)

zero:
		sh $t2, ($t6)		#store first elememt
		j checked
		or $0, $0, $0			#Delay Slot(branch)

dup_less:
		addi $t6, $t6, 2		#increment next and last spot
		addi $s2, $s2, 2
		lh $t9, ($t6)			#value in next
		or $0, $0, $0			#Delay Slot(branch)
		sh $t9, ($s2)
		or $0, $0, $0			#Delay Slot(branch)
		addi $t4, $t4, -1		#decrement counter
		beq $t4, $0, last_dup
		or $0, $0, $0			#Delay Slot(branch)
		j duplicate
		or $0, $0, $0			#Delay Slot(branch)

last_dup:
		add $t9, $0, $0
		sh $t9, ($t6)
		or $0, $0, $0			#Delay Slot(branch)
		j duplicate
		or $0, $0, $0			#Delay Slot(branch)

checked:
		addi $t5, $t5, 1		#element counter
		sh $t5, 100($s0)		#store element count in first integer_array spot
		add $t4, $0, $0

duplicate:
		bne $t4, 0, dup_less
		beq $t1, 10, finCon		#branch to end
		or $0, $0, $0			#Delay Slot(branch)

		add $t4, $0, $0		#clear counter
		addi $s1, $s1, 1		#moving array spot by 1
		j convert
		or $0, $0, $0			#Delay Slot(branch)

finCon:
		lui $s2, 0x1000
		addi $s2, $s2, 100		#array spot 100

		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 467		#prompt location in the array
		syscall

		addi $v0, $0, 1			#print integer
		add $a0, $0, $t8		
		syscall

		addi $v0, $0, 4			#print newline
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 527		#prompt location in the array
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
		beq $s6, 1, can_array
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 579		#prompt location in the array
		syscall

		j main
		or $0, $0, $0

can_array:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 507		#prompt location in the array
		syscall
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 529		#prompt location in the array
		syscall

		addi $t2, $s3, 1

print:
		lh $t1, ($s2)
		or $0, $0, $0			#Delay Slot(branch)
		addi $v0, $0, 1			#print integer
		add $a0, $0, $t1
		syscall

		addi $v0, $0, 4			#print newline
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 527		#prompt location in the array
		syscall

		addi $t2, $t2, -1		#decrement counter
		addi $s2, $s2, 2		#increment spot in array
		bne $t2, 0, print		#branch to print
		or $0, $0, $0			#Delay Slot(branch)

		j main					#Return to Main
		or $0, $0, $0			#Delay Slot(branch)

mean:
		beq $s6, 1, can_mean
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 579		#prompt location in the array
		syscall

		j main
		or $0, $0, $0

can_mean:
		add $t4, $0, $0			#clear register
		lui $t1, 0x1000			#load data
		or $0, $0, $0			#Delay Slot(load)
		addi $t1, $t1, 102		#point to convert_array
		lh $t2, 100($s0)		#number of converted elements
		or $0, $0, $0			#Delay Slot(load)
sum:
		lh $t3, ($t1)			#load element
		or $0, $0, $0			#Delay Slot(load)
		add $t4, $t4, $t3		#add element to sum
		addi $t1, $t1, 2		#increment pointer
		addi $t2, $t2, -1		#decrement number of elements
		bne $t2, $0, sum		#loop to sum
		or $0, $0, $0			#Delay Slot(load)
		lh $t2, 100($s0)		#number of converted elements
		or $0, $0, $0			#Delay Slot(load)
		add $t1, $0, $0			#counter
		bgez $t4, div_pos		#branch if sum is pos
		or $0, $0, $0			#Delay Slot(branch)
div_neg:
		add $t4, $t4, $t2		#sum plus number of elements
		addi $t1, $t1, -1		#increment counter
		blez $t4, div_neg
		or $0, $0, $0			#Delay Slot(branch)
		addi $t1, $t1, 1		#increment counter
		j final_mean
		or $0, $0, $0			#Delay Slot(branch)
div_pos:
		sub $t4, $t4, $t2		#sum minus number of elements
		addi $t1, $t1, 1		#increment counter
		bgez $t4, div_pos		#branch if counter is not = 0
		or $0, $0, $0			#Delay Slot(load)
		addi $t1, $t1, -1		#decrement counter by 1
final_mean:
		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 608		#prompt location in the array
		syscall

		addi $v0, $0, 1			#print integer
		add $a0, $0, $t1		
		syscall

		addi $v0, $0, 4			#print newline
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 527		#prompt location in the array
		syscall

		j main
		or $0, $0, $0			#Delay Slot(branch)

median:
		beq $s6, 1, can_med
		or $0, $0, $0			#Delay Slot(branch)

		addi $v0, $0, 4			#print display_string_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 579		#prompt location in the array
		syscall

		j main
		or $0, $0, $0

can_med:
		lui $t1, 0x1000			#load data
		or $0, $0, $0			#Delay Slot(load)
		addi $t1, $t1, 100		#point to convert_array
		lh $t2, 100($s0)		#number of converted elements
		or $0, $0, $0			#Delay Slot(load)
		andi $t3, $t2, 1		#even or odd
		beq $t3, 0, even
		or $0, $0, $0			#Delay Slot(branch)
		addi $t2, $t2, 1		#increment elements by 1 byte
even:
		add $t1, $t1, $t2
		lh $t4, ($t1)
		or $0, $0, $0			#Delay Slot(load)

		addi $v0, $0, 4			#print prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 623		#prompt location in the array
		syscall

		addi $v0, $0, 1			#print integer
		add $a0, $0, $t4		
		syscall

		addi $v0, $0, 4			#print newline
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 527		#prompt location in the array
		syscall

		j main
		or $0, $0, $0			#Delay Slot(branch)

exitProgram:
		addi $v0, $0, 4			#print exit_prompt
		lui $a0, 0x1000			#load data array
		addi $a0, $a0, 425		#prompt location in the array
		syscall

		addi $v0, $0, 10		#Exit command
		syscall

