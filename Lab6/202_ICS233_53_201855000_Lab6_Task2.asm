################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 06			#####################
#####################	Task: 	 02			#####################
################################################################################

####################		Data segment		#####################
.data 
promptN: .asciiz "Enter n: "
result_msg: .asciiz "n!= "
error_msg: .asciiz "Error!! the number n entered is not valid, please try again.\n"
####################		Text segment		#####################
.text 
start:
	la $a0, promptN
	li $v0, 4
	syscall
	li $v0, 5				#Get the value of n.
	syscall
	move $s0, $v0				#Store the value of n.
	bgez $v0, next				#iif(n >= 0) then go to next; else print error message;
	li $v0, 4
	la $a0, error_msg
	syscall
	j start					#Repeat the program until the value is greater than or equal to 0.
next:
	li $t0, 1 				#Initialize result with 1.
	li $t1, 1				# i = 0;
	loop:
		bgt $t1, $s0, endLoop		#if( i > n ) then break; else continue loop;
		mul $t0, $t0, $t1		#result = result * i;
		addiu $t1, $t1, 1		#i++;
		j loop
	endLoop:
	la $a0, result_msg			#print the result.
	li $v0, 4
	syscall
	move $a0, $t0 
	li $v0, 1
	syscall
end:
li $v0, 10
syscall
