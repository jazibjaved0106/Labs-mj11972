.text
.globl main
main:
    li x10, 5    #n=5
    li x29, 0    #counter=0

fact:
    li x28, 1  #acc=1

while: 
    beq x10, x0, loop   #check if n == 0
    addi sp, sp, -4     # makes space for n on stack
    sw x10, 0(sp)       # stores n on stack
    addi x10, x10, -1   # n = n - 1
    addi x29, x29, 1    # counter +=1
    j while             # loops again

loop: 
    beq x29,x0, exit    # checks if counter == 0
    lw x30, 0(sp)       # gets last stored n value on the stack
    addi sp, sp, 4      # pops stack
    mul x28, x28, x30   # acc = acc * n
    addi x29, x29, -1   # counter -= 1
    j loop              # loops again



exit: 
    addi x10,x28,0     # x10 gets acc
    addi x11,x10,0     # x11 gets acc
    li x10, 1          # print int ecall 
    ecall

end: j end

    