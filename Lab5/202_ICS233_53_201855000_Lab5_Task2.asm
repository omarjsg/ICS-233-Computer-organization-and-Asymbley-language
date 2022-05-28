################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 05			#####################
#####################	Task: 	 02			#####################
################################################################################

####################		Data segment		#####################
.data 
promptFileName: .asciiz "Enter filename: "
filename: .space 50
filecontents: .space 100
array_int: .word 0:20
result_msg: .asciiz "Integer array reversed: "
error_msg: .asciiz "Error: Wrong file name entered."
####################		Code segment		#####################
.text 
la $a0, promptFileName #Prompt the file name to the user.
li $v0, 4 
syscall
la $a0, filename #Saving the String value into filename.
li $a1, 51 #Specifying the maximum space of the string.
li $v0, 8 #Taking the String from the user.
syscall
move $s1, $a0 #Saving the String into $s1.
nameLoop: 
lb $t0, 0($s1)  #loading the first byte of the file name into $t0.
addi $s1, $s1, 1 #Incrementing the address by 1 to read the next byte.
bnez  $t0, nameLoop #If the byte is not equal to zero it will return to the begining of the loop. if( $t0 == 0) then continue.
beq $s1, $a1, endNameLoop #If the counter became equal to $a1 it will exit the loop. if($s1 != $a1) then break.
subi $s1, $s1, 2 #The name pointer will return 2 steps backwards to reach 'n'.
sb $0, 0($s1)  #Replace 'n' with '0'.
endNameLoop:
li $v0, 13 #Open the file.
la $a0, filename #Address of the filename String.
li $a1, 0 # flag for reading
syscall
move $s0, $v0  # save the file descriptor 
bgtz $a0, continue #if($a0 <= 0) then error message.
la $a0, error_msg #Display error message.
li $v0, 4
syscall
j Termentate 
continue:
la $a0, result_msg
li $v0, 4
syscall
li $v0, 14 #Read the file
la $a1, filecontents #Address of the input.
move $a0, $s0 #Reading the file descriptor.
li $a2, 101 #Maximum bytes reading.
syscall
li $t4, 0 #Initilizing the content reader counter => i = 0.
li, $s2, 0 #Initilizing the array index = > Array_int(0).
arraysettingLoop:
lb $t6, 0($a1) #Loading the first byte of the file.
addi $t4, $t4, 1 #increment $t4 by 1 (i++).
beq $t4, $a2, EndArraysettingLoop #If(i < 100) then break.
addi $a1, $a1, 1 #Increment the address by 1.
blt $t6, 0x30, arraysettingLoop #if ($t6 > 0 && $t6 < 9) then excute.
bgt $t6, 0x39, arraysettingLoop
subi $t6, $t6, 48 #Convert the character to integer.
sw $t6, array_int($s2) #Save the integer into the array cell.
addi $s2, $s2, 4 #Move to the next array cell.
j arraysettingLoop #continue the loop.
EndArraysettingLoop:
printingArray:
subi $s2, $s2, 4 #Starting printing with the last saved integer then move to the previous cell.
bltz $s2, end #if( index of the array < 0) then break.
lw $a0, array_int($s2) #Load the integer from array(Index) to $a0 to print it.
li $v0, 1 #Print the integer.
syscall
li $a0, ' ' #Print white spaces between integers
li $v0, 11 
syscall
j printingArray #Continue the loop.
end:
li $v0, 16 #Closing the file.
move $a0, $s0 #file descriptor
syscall
Termentate:
li $v0, 10 #exit the program.
syscall