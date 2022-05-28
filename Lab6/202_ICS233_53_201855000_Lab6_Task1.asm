################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 06			#####################
#####################	Task: 	 01			#####################
################################################################################

####################		Data segment		#####################
.data 
promptMoney: .asciiz "Enter Withdrawal amount: "
note500:  .asciiz "\n500 Bank note: "
note100:  .asciiz "\n100 Bank note: "
note50:  .asciiz "\n50  Bank note: "
note10:  .asciiz "\n10  Bank note: "
note5:  .asciiz "\n5   Bank note: "
note1:  .asciiz "\n1   Bank note: "
error_msg: .asciiz "Error!! the withdrawl amount should be greater than zero.\n"
####################		Text segment		#####################
.text 
start:
	li $v0, 4
	la $a0, promptMoney
	syscall
	li $v0, 5				#Get the cash amount from the user.
	syscall
	move $s0, $v0
	li $t1, 500 
	check:
		bgtz $s0, find500
			li $v0, 4
			la $a0, error_msg
			syscall
			j start					#Repeat the program until the value is greater than 0.
find500:
	li $t1, 500 
	div  $s0, $t1				#Devide $s0 by $t1
	mflo $t0 				#$s0 / 500
	mfhi $s0 				#$s0%500
	beqz $t0, find100			#if($t0 == 0) go next (No 500s).
	li $v0, 4
	la $a0, note500
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
find100:
	li $t1, 100
	div  $s0, $t1				#Devide $s0 by $t1
	mflo $t0 				#$s0 / 100
	mfhi $s0 				#$s0%100
	beqz $t0, find50				#if($t0 == 0) go next (No 100s).
	li $v0, 4
	la $a0, note100
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
find50:
	li $t1, 50
	div  $s0, $t1				#Devide $s0 by $t1.
	mflo $t0 				#$s0 / 50.
	mfhi $s0 				#$s0%50.
	beqz $t0, find10				#if($t0 == 0) go next (No 50s).
	li $v0, 4
	la $a0, note50
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
find10:
	li $t1, 10
	div  $s0, $t1				#Devide $s0 by $t1.
	mflo $t0 				#$s0 / 10.
	mfhi $s0 				#$s0%10.
	beqz $t0, find5				#if($t0 == 0) go next (No 10s).
	li $v0, 4
	la $a0, note10
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
find5:
	li $t1, 5
	div  $s0, $t1				#Devide $s0 by $t1.
	mflo $t0 				#$s0 / 5.
	mfhi $s0 				#$s0%5. which is the number 1s.
	beqz $t0, find1				#if($t0 == 0) go next (No 5s).
	li $v0, 4
	la $a0, note5
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
find1:
	beqz $s0, end 				#if($s0 == 0) go next (No 1s).
	li $v0, 4
	la $a0, note1
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
end:
li $v0, 10				#Terminate the program
syscall
