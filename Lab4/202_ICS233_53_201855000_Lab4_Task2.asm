#############################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000		#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 04			#####################
#####################	Task: 	 02			#####################
#############################################################################

####################		Data segment		#####################
.data 
promptN1: .asciiz "Enter integer n1: "
promptN2: .asciiz "Enter integer n2: "
sum: .asciiz "Sum= "
####################		Code segment		#####################
.text 
###################		initializing data	###################
la $a0, promptN1
li $v0, 4
syscall 
li $v0, 5
syscall
move $t0, $v0 
la $a0, promptN2
li $v0, 4
syscall
li $v0, 5
syscall 
move $t1, $v0 
################### 		calculations		###################
loop: bgt $t0,$t1 result 
add $s0, $t0, $s0  #addition of n1 and its previous value
addi $t0, $t0, 1 #incrementing n1 by 1
j loop
###################		printing 		####################
result:
la $a0, sum 
li $v0, 4 #print the sum message
syscall
move $a0, $s0
li $v0, 1 #print the sum value
syscall
exit:
li $v0, 10
syscall
