.text
.globl main
main:
    li x10, 0x100    # Base address of v[]
    li x11, 10       # k = 10
    li x28, 20       # temporary register x28 gets 20
    li x29, 30       # temporary register x29 gets 30
    sw x28, 40(x10)  # stores 20 in v[k]
    sw x29, 44(x10)  # stores 30 in v[k+1]

    # caller saves the temporary registers used in the procedure to be called 
    addi sp, sp, -48  # reserves 48 bytes of stack space for x5,x6,x7
    sw x5, 32(sp)     # stores x5
    sw x6, 16(sp)     # stores x6
    sw x7, 0(sp)      # stores x7

    jal x1, swap    # calls function swap

    # caller restores temporary register values after procedure is executed
    lw x7, 0(sp)     # restores x7
    lw x6, 16(sp)    # restores x6
    lw x5, 32(sp)    # restores x5
    addi sp, sp, 48  # restores sp

    j end


swap:
    addi x7, x11, 0  # temporary register x7 gets k
    slli x7, x7, 2   # x7 = k * 4
    add x7, x10, x7  # x7 = BA + (k * 4) / Address of v[k]
    lw x5, 0(x7)     # temp = v[k]
    lw x6, 4(x7)     # temporary register x6 gets v[k+1]
    sw x6, 0(x7)     # v[k] = v[k+1]
    sw x5, 4(x7)     # v[k+1] = temp
    jalr x0, 0(x1)   # return 


end: j end