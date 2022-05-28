#############################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000		#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 03			#####################
#####################	Task: 	 01			#####################
#############################################################################

####################		Data segment		#####################
.data 
promptx: .asciiz "Enter x:" 
result: .asciiz "y = "
####################		Code segment		#####################
.text 
la $a0, promptx
li $v0, 4 
syscall 
li $v0, 5
syscall
add $t0, $0, $v0
sll $t1, $t0, 5 # multiplying x by 32
sll $t2, $t0, 2 # multiplying x by 4
srl $t3, $t0, 2 # multiplying x by 0.25
####################	adding results together		#####################
add $s0, $t0, $t1
add $s0, $s0, $t2
add $s0, $s0, $t3
###################		printing 		####################
la $a0, result
li $v0, 4
syscall
add $a0, $zero, $s0
li $v0, 1
syscall
li $v0, 10
syscall