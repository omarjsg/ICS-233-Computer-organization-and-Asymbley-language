#############################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000		#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 02			#####################
#####################	Task: 	 02			#####################
#############################################################################

####################		Data segment		#####################
.data 
promptName: .asciiz "Enter your name: "
userName: .space 20 #to save the string.
message: .asciiz "Stay Home, Stay Safe, "
####################		Code segment		#####################
.text 
la $a0, promptName #to load the question.
li $v0, 4 #to ask the user about his/her name.
syscall 
li $v0, 8 #to read the string from the user.
la $a0, userName #to save the string value.
li $a1, 20
syscall
la $a0, message #to load the message.
li $v0, 4 #to print the message.
syscall
li $v0, 4 #to print the user name.
la $a0, userName 
syscall
li $v0, 10 #to term
syscall
