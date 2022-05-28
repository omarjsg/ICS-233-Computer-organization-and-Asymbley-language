################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 07			#####################
#####################	Task: 	 02			#####################
################################################################################

####################		Data segment		#####################
.data 
promptN: .asciiz "Enter n: "
result_msg: .asciiz "fib(n) = "
error_msg: .asciiz "Error: please enter a non-negative integer.\n"
####################		Text segment		#####################
.text 
main:
	la $a0, promptN
	li $v0, 4
	syscall
	li $v0, 5	#Take n from the user.
	syscall
	move $t0, $v0
	bgez $v0, excuteFib		#if($v0 >= 0) {$v0 = fib(n)};
		la $a0, error_msg
		li $v0, 4
		syscall
		j main
	excuteFib:
		move $a0, $t0	#Store n ($v0) in $a0.
		jal fib
	move $a0, $v0	#Store the result of fib(n) ($v0) in $a0.
	li $v0, 1
	syscall
	li $v0, 10	#Terminate.
	syscall

####################		Fibonacci  function	#####################
#inputs: -			$a0: n.
#outputs: -			$v0: fib(n).
fib:
	slti $t0, $a0, 3		# base: if(n < 3) then set $t0 to 1.
	beq $t0, $zero, else	# if(n >= 3) go to else.
	li $v0, 1		# Set $v0 to 1.
	jr $ra			# Return to caller.
	else:
		addi $sp, $sp, -12	# PUSH: adjust stack ptr for 3 items
		sw $ra, 0($sp)		# Store $ra in the stack.
		sw $s0, 4($sp)		# Store $s0 in the stack.
		sw $s1, 8($sp)		# Store $s1 in the stack.
		move $s0, $a0		# Store n ($a0) in $s0.
		addi $a0, $s0, -1	# Store (n-1) in $a0. 
		jal fib			# Recursive call, result will be stored in $v0.
		move $s1, $v0		# Store result1 ($v0) in $s1.
		addi $a0, $s0, -2	# Store (n-2) in $a0.
		jal fib			# Recursive call, result will be stored in $v0.
		add $v0, $s1, $v0	# Store result1 + result2 in $v0.
		lw $s1, 8($sp)		# POP: retrieve $s1 from stack
		lw $s0, 4($sp)		# Retrieve $s0 from the stack.
		lw $ra, 0($sp)		# Retrieve $ra from the stack.
		addi $sp, $sp, 12	# Emptying the stack pointer.
	jr $ra			# Return to caller.
	
