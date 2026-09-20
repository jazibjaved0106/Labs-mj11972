.text
.globl main
main:
    li x10, 25   # g = 25
    li x11, 30   # h = 30
    li x12, 10   # i = 10
    li x13, 15   # j = 15
    jal x1, leaf_example   # calls function leaf_example

    addi x11, x10, 0       # stores return value in x11
    li x10, 1              # print int ecall
    ecall
    j end

leaf_example:
    addi sp, sp, -48     # reserves 48 bytes of stack space for x18,x19,x20
    sw x18, 32(sp)       # stores x18
    sw x19, 16(sp)       # stores x19
    sw x20, 0(sp)        # stores x20

    add x18, x10, x11    # x18 = g + h
    add x19, x12, x13    # x19 = i + j
    sub x20, x18, x19    # f = (g + h) - (i + j)

    addi x10, x20, 0     # x10 gets return value f 

    lw x20, 0(sp)        # restores x20
    lw x19, 16(sp)       # restores x19
    lw x18, 32(sp)       # restores x18
    addi sp, sp, 48      # restores sp

    jalr x0, 0(x1)       # return 

end: j end