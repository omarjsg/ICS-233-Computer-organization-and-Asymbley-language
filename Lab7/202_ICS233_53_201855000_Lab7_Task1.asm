################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 07			#####################
#####################	Task: 	 01			#####################
################################################################################

####################		Data segment		#####################
.data 
promptN.pt1: .asciiz "Enter integer "
promptN.pt2: .asciiz ": "
result_msg: .asciiz "Integer reversed = "
####################		Text segment		#####################
.text 
main: 
	jal f	#call function f.
	li $v0, 10 #Terminate program.
	syscall
####################		f function			#####################
f: 
	addiu $sp, $sp, -44	# allocate stack frame = 44 bytes
	sw $ra, 40($sp)		# save $ra on the stack
	move  $a0, $sp		# $a0 = address of array on the stack
	li    $a1, 10		# $a1 = 10
	jal   read		# call function read
	move  $a0, $sp		# $a0 = address of array on the stack
	li    $a1, 10		# $a1 = 10
	jal   reverse		# call function reverse
	move  $a0, $sp		# $a0 = address of array on the stack
	li    $a1, 10		# $a1 = 10
	jal   print		# call function print
	lw    $ra, 40($sp)	# load $ra from the stack
	addiu $sp, $sp, 44	# Free stack frame = 44 bytes
	jr    $ra		# return to caller.
	
####################		read function		#####################
#inputs: -	$a0: address of $sp
#			-	$a1: 10
#outputs: none.
read: 
	move $t0, $a1	#Store n into $t0.
	li $t1, 1			# $t1 = 1.
	move $t2, $a0	# Store address dtored in $a0 into $t2.
	promptLoop:
		bgt $t1, $t0, exitPromptLoop	# if($t1 > n) then exit the loop.
		la $a0, promptN.pt1
		li $v0, 4
		syscall
		move $a0, $t1
		li $v0, 1
		syscall
		la $a0, promptN.pt2
		li $v0, 4
		syscall
		li $v0, 5	# Get the values from the user.
		syscall
		sw $v0, 0($t2)	# Store the value from $v0 into the address of the array cell $t2. 
		addiu $t2, $t2, 4	# Incerement the array adress by 4 since it stores integers.
		addiu $t1, $t1, 1	# Incerement $t1 by 1.
		j promptLoop	# Continue the loop.
	exitPromptLoop:
	jr $ra	# return to caller.
	
####################		reverse function		#####################
#inputs: -	$a0: address of $sp
#			-	$a1: 10
#outputs: none.
reverse:
	move $t2, $a0	# Store address dtored in $a0 into $t2.
	divu  $t3, $a1, 2  # Divide n by 2 and store into $t3.
	li $t1, 1	# $t1 = 1.
	sll $t4, $a1, 2		# Multiply n by 4 and store it into $t4
	addu $t5, $t2, $t4	# Store the last element Adress
	reverseLoop:
		bgt $t1, $t3, exitReverseLoop	#if($t1 > n/2) then exit the loop;
		addiu $t5, $t5, -4	#Decrement the last cell in the array's address by 4 since it stores integers.
		lw $t6, 0($t2)	#Store arr[i] into $t6.
		lw $t7, 0($t5)	#Store arr[(n -1) - i] into $t7.
		sw $t7, 0($t2)	#Store $t7 into arr[i].
		sw $t6, 0($t5)	#Store into $t6 arr[(n -1) - i].
		addiu $t2, $t2, 4		# Incerement the array adress by 4 since it stores integers.
		addiu $t1, $t1, 1	# Incerement $t1 by 1
		j reverseLoop	#Continue the loop.
	exitReverseLoop:
	jr $ra	# return to caller
####################		print function		#####################
#inputs: -	$a0: address of $sp
#			-	$a1: 10
#outputs: none.
print: 
	move $t0, $a1	#Store n into $t0.
	li $t1, 1	# $t1 = 1.
	move $t2, $a0	# Store address dtored in $a0 into $t2.
	la $a0, result_msg
	li $v0, 4
	syscall
	printLoop:
		bgt $t1, $t0, exitPrintLoop	#if($t1 < n) then exit the loop.
		lw $a0, 0($t2)	#Store arr[i] into $a0.
		li $v0, 1			#Print arr[i].
		syscall
		li $a0, ' '			#Print spaces between integers.
		li $v0, 11
		syscall
		addiu $t2, $t2, 4		# Incerement the array adress by 4 since it stores integers.
		addiu $t1, $t1, 1	# Incerement $t1 by 1
		j printLoop	#Continue the loop.
	exitPrintLoop:
	jr $ra	# return to caller.
