# Computer Architecture Course Fall Semester 2020 - RISC-V Calculator Project
# Name: Ibrahim Zuheir Ibrahim Elwazer
# Student ID: B202000390



.text	
# main
main:
	jal x1, test #functionality test, Do not modify!!
	
	
	#----TODO-------------------------------------------------------------
	#1. read a string from the console
	#2. perform arithmetic operations
	#3. print a string to the console to show the computation result
	#----------------------------------------------------------------------
	
	# Exit (93) with code 0
        li a0, 0
        li a7, 93
        ecall
        ebreak


#----------------------------------
#name: calc
#func: performs arithmetic operation
#x11(a1): arithmetic operation (0: addition, 1:  subtraction, 2:  multiplication, 3: division)
#x12(a2): the first operand
#x13(a3): the second operand
#x10(a0): return value
#x14(a4): return value (remainder for division operation)
#----------------------------------

calc:
	
	bne a1, zero subtraction
	li a7, 8
	
addition:
	add a0, a2, a3
	
	jalr x0, 0(x1)
	
subtraction:
	li t6, 2
	beq a1, t6, multiplication
	neg t4, a3 
	add a0, t4, a2
		
	jalr x0, 0(x1)

multiplication: 

	li t3, 3
	beq a1, t3, division
	li a0, 0
	addi t5, a2, 0 #multiplicand
	addi t6, a3, 0 #multiplier
	li t3, 32
	
comparison:
	li t4, 1
	and t4, t4, t6
	beq t4, zero, shiftloop
	add a0, t5, a0
	
shiftloop:
	li t4, 1
	sll t5, t5, t4
	srl t6, t6, t4
	addi t3, t3, -1
	beqz t3, endloop
	j comparison
	
endloop: 
	
	jalr x0, 0(x1)


division:
	
	li a0, 0 #quotient
	addi t4, a3, 0 #divisor
	addi t5, a4, 0 #remainder
	li t6, 65
	
remaindercheck:
	neg t3, t4
	add t5, t3, t5
	blt t5, zero, restore
	slli a0, a0, 1
	j shiftdivisor
	
restore: 	
	add t5, t5, t4
	slli a0, a0, 1
	
shiftdivisor:
	srli t4, t4, 1
	addi t6, t6, -1
	beqz t6, stoploop
	j remaindercheck
	
stoploop:
	
	jalr x0, 0(x1)


.include "common.asm"