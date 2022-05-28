lui 1
srli $2, $1, 1 #$2 = 16
lui 7
ori $3, $1, 7 #$3 =0000 0000 0111 0111
addi $1, $0, 1 #i = 1
addi $5, $0, 1 # indicator of 1's
loop:	bge $1, $2, end #if(i >= 16) then end
		andi $6, $3, 1 #checks if the first digit of $3 has a 1 or not.
		srli $3, $3, 1 #zero-shifts $3 to the right by 1 to iterate the process of counting 1s
		addi $1, $1, 1 #i = i + 1
		bne $5, $6, loop #if $6 is not a 1, then go back to loop
		addi $4, $4, 1 #else, add to the counter of 1s by 1
		j loop #jump to loop
end: #end of program