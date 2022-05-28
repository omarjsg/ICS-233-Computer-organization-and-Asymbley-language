#############################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000		#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 02			#####################
#####################	Task: 	 01			#####################
#############################################################################

####################		Data segment		#####################
.data 
promptA: .asciiz "Enter a:" 
promptB: .asciiz "Enter b:"
promptC: .asciiz "Enter c:"
result: .asciiz "z = "
####################		Code segment		#####################
.text 
####################		"3a" value segment	#####################
la $a0, promptA #to load promptA to $a0.
li $v0, 4 #to print the value of $a0.
syscall 
li $v0, 5 #to read an integer from the user.
syscall 
move  $t0, $v0 #to assign the value of $v0 to $t0. -> $t0 = a
# to add the value of $t0 3 times "3a"
add $s0, $t0, $t0 # -> 2a
add $t0, $t0, $s0 # -> 3a
####################		"4b" value segment	#####################
la $a0, promptB #to load promptB to $a0
li $v0, 4 #to print the value of $a0.
syscall
li $v0, 5 #to read an integer from the user.
syscall 
move  $t1, $v0 #to assign the value of $v0 to $t1. -> $t1 = b
# to add the value of $t1 4 times "4b"
add $s0, $t1, $t1 # -> 2b
add $s1, $t1, $s0 # -> 3b
add $t1, $t1, $s1 # -> 4b
####################		"4c" value segment	#####################
la $a0, promptC #to load promptC to $a0
li $v0, 4 #to print the value of $a0.
syscall
li $v0, 5 #to read an integer from the user.
syscall
move  $t2, $v0 #to assign the value of $v0 to $t2. -> $t2 = c
# to add the value of $t2 4 times "4c"
add $s0, $t2, $t2 # -> 2c
add $s1, $t2, $s0 # -> 3c
add $t2, $t2, $s1 # -> 4c
####################	 Calculating "z" segment	 #####################
la $a0, result #to load result to $a0.
li $v0, 4 #to print the value of $a0.
syscall 
sub $s0, $t0, $t1 #$s0 = 3a - 4b
subi $s1, $t2, 40 #$s1 = 4c - 40
sub $s2, $s0, $s1 #$s2 = (3a - 4b) - (4c - 40)
move $a0, $s2 # $a0 = $s2
li $v0, 1 #printing z
syscall
li $v0, 10 #termenating the program
syscall
