.globl main
.globl rtn
.globl count
.data          # Data is placed here
array:
	.byte 0x01
	.byte 0x0A
	.byte 0x02
	.byte 0xFE
	.byte 0x56
	.byte 0x0A
	.byte 0xFF
	.byte 0x00
	.byte 0x0A
	.byte 0x02
prompt:
	.asciiz "Enter an integer: "
answer: 
	.asciiz "The number of occurences is "
.text
main:
	addi $sp, $sp, -4      # Save return register to the stack
	sw $ra, ($sp)
	addi $v0, $0, 4        # Print prompt
	lui $a0, 0x1000
	addi $a0, $a0, 10
	syscall
	
	addi $v0, $0, 5        # Get integer
	syscall

	add $a0, $0, $v0
	jal count              # Put integer to check for in a0
	or $0, $0, $0          # Delay Slot (Branch)
	
	add $t0, $v0, $0       # Store result in a0

	addi $v0, $0, 4        # Print text for answer
	lui $a0, 0x1000
	addi $a0, $a0, 29
	syscall
	addi $v0, $0, 1        # Print answer
	add $a0, $0, $t0
	syscall
 
	lw $ra, ($sp)          # Restore return register from the stack
	addi $sp, $sp, 4

rtn:
	jr $ra                 # Return
	or $0, $0, $0          # Delay Slot (Branch)

count:
	add $t0, $0, $0        # t0 is running sum
	lui $t1, 0x1000        # t1 is the address of the array
	addi $t2, $t1, 10      # t2 is the address at which I stop
loop:
	lb $t3, ($t1)
	or $0, $0, $0          # Delay Slot (Load)
	bne $a0, $t3, next
	or $0, $0, $0          # Delay Slot (Branch)
	addi $t0, $t0, 1
next:
	addi $t1, $t1, 1
	slt $t3, $t1, $t2
	bne $t3, $0, loop
	or $0, $0, $0          # Delay Slot (Branch)

	add $v0, $t0, $0       # Return result

	jr $ra
	or $0, $0, $0          # Delay Slot (Branch)
