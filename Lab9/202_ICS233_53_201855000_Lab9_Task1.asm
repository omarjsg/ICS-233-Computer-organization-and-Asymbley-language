################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 09			#####################
#####################	Task: 	 01			#####################
################################################################################

####################		Data segment		#####################
.data 
promptX: .asciiz "Enter double x: "
promptY: .asciiz "Enter double y: "
result_msg: .asciiz "The result is "
PI : .double 3.14
####################		Text segment		#####################
.text 
la $a0 , promptX	# Prompt the user to enter x.
li $v0, 4
syscall
li $v0, 7			# Get x value from the user and store it in $f0.
syscall
mov.d $f4, $f0		# Save $f0 value into $f4
la $a0 , promptY	# prompt the user to enter y.
li $v0, 4
syscall
li $v0, 7			# Get x value from the user and store it in $f0.
syscall
mov.d $f6, $f0		# Save $f0 value into $f6
div.d $f8, $f4, $f6	# Divide x/y and store the result into $f8
li $t1, 0			# Store integer(0) into $t2
mtc1.d $t1, $f12	# Move integer(0) to Coprossor and store it into $f12.
cvt.d.w $f12, $f12	# Convert integer(0) to double(0.0) and store it into $f12.
c.lt.d 2, $f8, $f12	# If($f8 < $f12) set flag 2 to true, else set it to false.
bc1t 2, negative	# if flag 2 is false, go to negative, else got to positive.
positive:
	li $t2, 2		# Store integer(2) into $t2
	mtc1.d $t2, $f4	# Move integer(2) to Coprossor and store it into $f4.
	cvt.d.w $f4, $f4	# Convert integer(2) to double(2.0) and store it into $f4.
	mul.d $f8, $f8, $f4	# Multiply 2*(x/y) and store it into $f8.
	li $v0, 4
	la $a0, result_msg
	syscall
	sqrt.d $f12, $f8	# Take the square root of ($f8) and store it $f12.
	li $v0, 3			# Print the value of $f12.
	syscall
	j terminate			#Jump to terminate
negative:
	neg.d $f8, $f8			# Take the negative (-x/y) and store it into $f8.
	sqrt.d $f8, $f8			# Take the square root of ($f8) and store it into $f8.
	la $t0, PI				# Load the address of PI and $t0.
	l.d $f4, 0($t0)			# Load the value of PI and $f4
	mul.d $f12, $f8, $f4	# Multiply PI by the value stored in $f8 and store it into $f12.
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 3			# Print the value of $f12.
	syscall
terminate:
	li $v0, 10		# Terminate. . .
	syscall
