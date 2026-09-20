.text
.globl main
main:
    li x10, 5    #n=5
    li x29, 0    #counter=0

fact:
    li x28, 1  #acc=1

while: 
    beq x10, x0, exit
    addi sp, sp, -4
    sw x10, 0(sp)
    addi x10, x10, -1 
    j while

loop: beq x29,x0, exit



exit: 
    addi x10,x28,0
    addi x11,x10,0
    li x10, 1
    ecall

end: j end

    