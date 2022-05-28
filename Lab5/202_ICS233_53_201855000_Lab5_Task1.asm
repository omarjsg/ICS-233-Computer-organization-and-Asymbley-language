################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 05			#####################
#####################	Task: 	 01			#####################
################################################################################

####################		Data segment		#####################
.data 
promptSize: .asciiz "Enter n: "
promptString: .asciiz "Enter string: "
promptE: .asciiz "\nEnter e: "
result: .asciiz "Encrypted String: "
####################		Code segment		#####################
.text 
la $a0, promptSize #Prompt the size of the string to the user.
li $v0, 4
syscall 
li $v0, 5 #Read the string size from the user.
syscall
addi $t0, $v0, 1 # Store n+1 to $t0.
la $a0, promptString #Prompt the string to the user.
li $v0, 4
syscall
move $a0, $t0 #Allocate n+1 in the heap.
li $v0, 9
syscall
move $t1, $v0 #Store the allocated adress to $t1.
la $a0 , ($t1) #To read the string and store it at the begining of $t1.
move $a1, $t0 #To specify the size of the strng readed.
li $v0, 8 #Reading the string from the user.
syscall
li $v0, 4
la $a0, promptE #Prompt the encryption code to the user.
syscall
li $v0, 5 #Reading the encryption code.
syscall
move $s0, $v0 #Storing the encryption code to $s0.
li $s1, 0 #Initializing the first index (i).
addi $t0, $t0, -1 #To determine the loop repetions to n.
la $a0, result #To print the result label.
li $v0, 4
syscall
loop: bge $s1, $t0, endLoop #for (int i; i < n;)
lb $a0, 0($t1) #To load the byte from the adress to $a0.
blt $a0, 0x41, endEncrypting #if($a0 > A) then
bgt $a0, 0x5A, isLower #if($a0 <= Z) then
add $a0, $a0, $s0 #Encrypting $a0.
ifUpper: 
ble $a0, 0x5A, isLower #if($a0 > z) then
sub $a0, $a0, 26 #Subtracting 26 from ASCII table.
j endEncrypting #Skip until endEncrypting.
isLower: 
blt $a0, 0x61, endEncrypting #if($a0 >= a) then
add $a0, $a0, $s0 #Encrypting $a0.
ble $a0, 0x7A, endEncrypting #if($a0 > z) then.
sub $a0, $a0, 26 #Subtracting 26 from ASCII table.
endEncrypting:
li $v0, 11 #Printing character from $t1.
syscall
addi $s1, $s1, 1 #incrementing i => i++.
addi $t1, $t1, 1 #moving to the next adress.
j loop #return to loop if i < n.
endLoop:
li $v0, 10 # Termenating the program.
syscall
