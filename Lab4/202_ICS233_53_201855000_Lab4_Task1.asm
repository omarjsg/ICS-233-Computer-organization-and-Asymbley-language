#############################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000		#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 04			#####################
#####################	Task: 	 01			#####################
#############################################################################

####################		Data segment		#####################
.data 
promptA: .asciiz "Enter a: " 
evenneg: .asciiz "Your number is a negative even number"
evenpos: .asciiz "Your number is a positive even number"
oddpos: .asciiz "Your number is a positive odd number"
oddneg: .asciiz "Your number is a negative odd number"
eqZero: .asciiz "You entered a zero!"
####################		Code segment		#####################
.text 
#prompt the user message
la $a0, promptA
li $v0, 4
syscall 
#get the value from the user 
li $v0, 5
syscall
# saving the value
move $t0, $v0
andi $t1, $t0, 1
#
beqz $t0, zeroTrue
bgtz $t0, positive
beqz $t1, even1
#Negative odd
la $a0, oddneg
li $v0, 4
syscall
j exit
#Negative even
even1:
la $a0, evenneg
li $v0, 4
syscall
j exit
#
positive:
beqz $t1, even2
#Positive odd
 la $a0, oddpos
li $v0, 4
syscall
j exit
#Positive even
even2:
la $a0, evenpos
li $v0, 4
syscall
j exit
#Zero
zeroTrue:
la $a0, eqZero
li $v0, 4
syscall
j exit
###################		printing 		####################
exit:
li $v0, 10
syscall
