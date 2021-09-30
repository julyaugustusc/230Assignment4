###########################################################
# Assignment #: 4
# Name: Augustus Crosby 
# ASU email: ancrosby@asu.edu
# Course: CSE230, MW 3:05pm
# Description: It prints 2 integers and the sum of the 
#              2 and then subtracts one from another.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM

		.data 
line1:		.asciiz "What is your sales type (1 or 2)?\n"
line2:		.asciiz	"How much was the sales?\n"
line3:		.asciiz "No commission for the sales.\n"
line4:		.asciiz "Your total commission is "
line5:		.asciiz " for the sales of "
line6:		.asciiz " \n"

#program code is contained below under .text

		.text 
		.globl main    #define a global function main

# the program begins execution at main()

main:
	li $v0, 4		# load 4 to print string
	la $t0, line1		# $t0 = address line of sales type question
	move $a0, $t0
	syscall			# print_string()
	
	li $v0, 5		# load 5 to read int
	syscall			# call read_int()
	move $s0, $v0		# $s0 = sales type

	li $v0, 4		# load 4 to print string
	la $t1, line2		# $t1 = address line of how much sales
	move $a0, $t1
	syscall			# print_string()
	
	li $v0, 5		# load 5 to read int
	syscall			# call read_int()
	move $s1, $v0		# $s1 = total sales

	#if $s0 <= 0
	slti $t3, $s0, 0	# $t3 = either 0 or 1
	bne $t3, $zero, exit	# double negation of $s0 <= 0
	
	#if $s0 == 1
	li $t4, 1		# $t4 = 1
	li $t5, 10000		# $t5 = 10000 
	beq $s0, $t4, label1	# if $s0 == 1, go to label1
	
	#if $s1 < 10000
	slt $t6, $s1, $t5	# $t6 = either 0 or 1
	beq $t6, $zero, label3	# if $s1 < 10000 continue on
	li $s2, 3		# $s2 = commission number of 3
	j commission

label1:
	#if $s1 < 10000
	slt $t6, $s1, $t5	# $t6 = either 0 or 1
	beq $t6, $zero, label2	# if $s1 < 10000 continue on
	li $s2, 2		# $s2 = commission number of 2
	j commission

label2:
	li $s2, 4		# $s2 = commission number of 4
	j commission

label3:
	li $s2, 5		# $s2 = commission number of 5
	j commission

commission:
	li $t7, 1000		# $t7 = 1000
	div $s1, $t7		# LO = $s1/$t7, HI= $s1%$t7
	mflo $t8		# $t8 = LO
	mult $t8, $s2		# HI,LO = $t8*$s2
	mflo $t9		# $t9 = LO (not dealing with high numbers)
	
	li $v0, 4		# load 4 to print string
	la $a0, line4		# load address of line4
	syscall			# print_string()
	
	li $v0, 1		# load 1 to print int
	move $a0, $t9		# load $t9 to print
	syscall 		# print_int()
	
	li $v0, 4		# load 4 to print string
	la $a0, line5		# load address of line5
	syscall			# print_string()

	li $v0, 1		# load 1 to print int
	move $a0, $s1		# load $s1 to print
	syscall 		# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line6		# load address of line6
	syscall			# print_string()
	jr $ra

exit:	
	li $v0, 4		# load 4 to print string
	la $t2, line3		# $t2 = address line of "no commission..."
	move $a0, $t2		# load $t2 to print
	syscall			# print_string()
	jr $ra