################################################################################
#####################	Name: OMAR J. ALGHAMDI		#####################
#####################	ID:   S201855000			#####################
#####################	Section: 53 			#####################
#####################	Lab: 	 09			#####################
#####################	Task: 	 02			#####################
################################################################################

####################		Data segment		#####################
.data 
promptGrade_pt1: .asciiz "Enter grade "
promptGrade_pt2: .asciiz ": "
result_msg_pt1: .asciiz "The average of "
result_msg_pt2: .asciiz " grades is: "
####################		Text segment		#####################
.text 
li $t0, 12		# Number of grades
mtc1 $t0, $f4	# Move integer(Number of grades) to Coprossor and store it into $f4.
cvt.s.w $f4, $f4	# Convert integer(Number of grades) to double(Number of grades.0) and store it into $f12.
li $t1, 0		# i = 0;
loop:
	bge $t1, $t0, endLoop		# if( i >= Number of grades) exit the loop, else continue;
	la $a0, promptGrade_pt1	# Prompt the user to enter the grade.
	li $v0, 4
	syscall
	move $a0, $t1		# Grade order
	li $v0, 1
	syscall
	la $a0, promptGrade_pt2
	li $v0, 4
	syscall
	li $v0, 6		#Get the grade value and store it into $f0.
	syscall
	add.s $f6, $f6, $f0	# Add $f0 (a grade) to the $f6 (total grades) in every itteration.
	addiu $t1, $t1, 1	# i ++;
	j loop		# continue;
endLoop:
div.s $f12, $f6, $f4		# $f12 (Average) = $f6 (sum) / $f4 (Number of grades)
la $a0, result_msg_pt1
li $v0, 4
syscall
move $a0, $t0
li $v0, 1
syscall
la $a0, result_msg_pt2
li $v0, 4
syscall
li $v0, 2		#Print the result from $f12.
syscall
li $v0, 10		# Terminate. . .
syscall