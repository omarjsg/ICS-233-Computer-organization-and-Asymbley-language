################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 08			#####################
#####################	Task: 	 01			#####################
################################################################################

####################		Data segment		#####################
.data 
promptX: .asciiz "Enter Dividend (x): "
promptY: .asciiz "Enter Divisor (y): "
result_msg: .asciiz "The result of x/y is "
####################		Text segment		#####################
.text 
li $s0, 0		# $s0 = 0.
la $a0, promptX
li $v0, 4		# Prompt the user to enter integer x.
syscall 
li $v0, 5		# Get x from the user.
syscall 
move $t0, $v0		# Save x in $t0.
la $a0, promptY
li $v0, 4		# Prompt the user to enter integer y.
syscall 
li $v0, 5		# Get y from the user.
syscall 
li $a0, 0	# To select the thrown exception type in the exception handler. (exception key)
teq $v0, $s0		# if(y == 0) throw an exception.
move $t1, $v0		# Save y in $t1.
div  $t2, $t0, $t1	# Divide $t0 by $t1 then save the quotient in $t2
la $a0, result_msg
li $v0, 4		# Print result message.
syscall 
move $a0, $t2
li $v0, 1		# Print the result.
syscall
li $v0, 10		# Terminate.
syscall
##################	   Karnel text segment	          ###################
.ktext 0x80000180 
move $k0, $at		# $k0 = $at.
la $k1, _regs		# $k1 = address of _regs. 
sw $k0, 0($k1)		# Save $at.
sw $v0, 4($k1) 		# Save $v0.
sw $a0, 8($k1) 		# Save $a0.
move $k1, $a0		# Save the value of $a0 to $k1 (Select throw type).
mfc0 $k0, $13 		# $k0 = cause.
srl $k0, $k0, 2 		# Shift right by 2 bits.
andi $k0, $k0, 31	# $k0 = exception code
beq $k0, 13, _thowException	#If($k0 == 13) Trapped exception.

_thowException:			# Select exception type.
	beqz $k1, _devideByZeroException1

_devideByZeroException1:
	la $a0, _dbzMsg		# Print exception message.
	li $v0, 4
	syscall 
	mfc0 $k0, $14		# $k0 = EPC.
	addi $k0, $k0,  -28	# Decrement $k0 by 28.
	mtc0 $k0, $14		# EPC = point to 7 instructions before.
	j _cleanUp		# Jump to _cleanUp
_cleanUp:
	la $k1, _regs		# $k1 = address of _regs.
	lw $at, 0($k1)		# Restore $at.
	lw $v0, 4($k1) 		# Restore $v0.
	lw $a0, 8($k1) 		# Restore $a0.
eret			# exception return: PC = EPC 
##################		Karnel data segment	###################
.kdata
_dbzMsg: .asciiz "Divide by Zero Exception. Please enter a different value for y.\n"
_regs: .word 0:3 
