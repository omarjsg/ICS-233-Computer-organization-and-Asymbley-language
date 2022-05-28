addi $3, $0, 0	#i = 0
addi $2, $0, 8	#max entry n = 8
lui 440
ori $4, $1, 10
entryLoop:	bge $3, $2, endEntry	#if(i >= n) end loop
				addi $4, $4, -8			#$4 =$4 - 8
				sw $4, 0($3)				#Store $4 in a[]
				addi $3, $3, 1			#i = i + 1
				j entryLoop				# back to the begin of the loop.
endEntry:
jal sort
j end
sort:
addi $3, $0, 0	#i = 0
firstLoop:
		bge $3, $2, endFirst	#if(i >= n) exit the first loop
		addi $4, $0, 0	#j =0
		secondLoop:
			addi $1, $3, 1		#$1 = i + 1
			sub $6, $2, $1	#$6 = n - (i + 1)
			bge $4, $6, endSecond		#if(j >= n - (i + 1)) exit the second loop
			lw $1, 0($4)					#$1 =a[j] 
			lw $6, 1($4)					#$6 = a[j+1]
			blt $1, $6, noSwap			#if(a[j] < a[j + 1]) no swap
	Swapping:
			#add $5, $0, $1				#temp = a[j]			
			sw $1, 1($4)					#a[j + 1] = a[j]
			sw $6, 0($4)					#a[j] = a[j + 1]
		noSwap:
				addi $4, $4, 1			# j = j +1
				j secondLoop				#Continue second loop
	endSecond:
		addi $3, $3, 1			#i = i +1
		j firstLoop				#Continue first loop
endFirst:
jalr $0, $7, 0		#return
end:
