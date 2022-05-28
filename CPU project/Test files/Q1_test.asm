addi $1,$0,1
addi $2,$0,1
xor $3,$1,$2 #0
or $3,$1,$2 #1
and $3,$1,$2 #1
sll $3,$1,$2 #2
srl $3,$1,$2 #0
sra $3,$1,$2 #0
add $3,$1,$2 #2
sub $3,$1,$2 #0
addi $2,$0,0
slt $3,$2,$1 #1
sltu $3,$2,$1 #1
slti $3,$2,1 #1
sltiu $3,$2,1 #1
xori $3,$1,1 #0
ori $3,$1,1 #1
andi $3,$1,1 #1
slli $3,$1,1 #2
srli $3,$1,1 #0
srai $3,$1,1 #0
sw $1,0($4)
lw $5,0($4) #$5=1
addi $2,$0,1
beq $1,$2,bne
j end
bne:
addi $2,$0,3
bne $1,$2,blt
j end
blt:
addi $2,$0,3
blt $1,$2,bge
j end
bge:
addi $2,$0,3
bge $2,$1,bltu
j end
bltu:
addi $2,$0,3
bltu $1,$2,bgeu
j end
bgeu:
addi $2,$0,3
bgeu $2,$1,end
j end
end:
lui 5 #$1=160
j testj
testj:
addi $1,$0,1
addi $2,$0,1
jal testjal
testjal:
jalr $0,$7,0


