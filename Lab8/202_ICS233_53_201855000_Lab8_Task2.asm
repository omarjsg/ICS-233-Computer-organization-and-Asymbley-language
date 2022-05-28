################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 08			#####################
#####################	Task: 	 02			#####################
################################################################################

####################		Data segment		#####################

####################		Text segment		#####################
.text 
main: 
	li $t0, 0xffff0000		# Address of keyboard control register
	wait_keyboard:
		lw $t2, ($t0)		# Read the keyboard control register
		andi $t2, $t2, 1		# Extract ready bit
		addiu $t1, $t1, 1		# wait_counter++ (counts iterations)
		beqz $t2, wait_keyboard	# loop back while not ready
		lw $a0, 4($t0)		# Get character from keyboard 
	isALetter:
		blt $a0, 'A', skip		# If ($a0 < 'A') then it is not an alpahbet letter
		bgt $a0, 'z', skip		# If ($a0 < 'z') then it is not an alpahbet letter
		isUpper:
			bgt $a0, 'Z', isLower		# If ($a0 > 'Z') then it is a lower case alpahbet letter, else switch the case.
			addiu $a0, $a0, 32		# Switch the case.
			j skip			# Jump to display control.
		isLower:
			blt $a0, 'a', skip		# If ($a0 < 'a') then it is not an alpahbet letter, else switch the case.
			addiu $a0, $a0, -32		# Switch the case.
	skip:
	li $t0, 0xffff0008		# Address of display control register
	wait_display:
		lw $t2, ($t0)		# Read the display control register
		andi $t2, $t2, 1		# Extract ready bit
		beqz $t2, wait_display		# loop back while not ready
		sw $a0, 4($t0)		# Send character to display
	j main
