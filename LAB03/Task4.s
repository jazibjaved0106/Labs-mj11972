.text
.globl main
main:
    li x10, 0x100  #Base Address of char x[]
    li x11, 0x300  #Base Address of char y[]

    # string y = "jazib"
    li x5, 'j'       
    sb x5, 0(x11)   # y[0]='j'
    li x5, 'a'
    sb x5, 1(x11)   # y[1]='a'
    li x5, 'z'
    sb x5, 2(x11)   # y[2]='z'
    li x5, 'i'
    sb x5, 3(x11)   # y[3]='i'
    li x5, 'b'
    sb x5, 4(x11)   # y[4]='b'
    sb x0, 5(x11)   # y[5]='\0' (0)

    # caller saves the temporary registers used in the procedure to be called 
    addi sp, sp, -48  # reserves 48 bytes of stack space for x6,x28,x29
    sw x6, 32(sp)     # stores x6
    sw x28, 16(sp)     # stores x28
    sw x29, 0(sp)      # stores x29

    jal x1, strcpy    # calls function strcpy 

     # caller restores temporary register values after procedure is executed
    lw x29, 0(sp)     # restores x29
    lw x28, 16(sp)    # restores x28
    lw x6, 32(sp)    # restores x6
    addi sp, sp, 48  # restores sp

    j end 


strcpy:

    addi sp, sp, -16   # reserves 16 bytes of stack space for x19 (i)
    sw x19, 0(sp)      # stores x19

    li x19, 0          # i = 0

while:
    add x28, x19, x11   # x28 gets address of y[i]
    lb x6, 0(x28)       # temporary register x6 stores y[i]
    add x29, x19, x10   # temporary register x29 gets address of x[i]
    sb x6, 0(x29)       # x[i] = y[i]
    beq x6,x0, done     # checks if x[i]=y[i] = '/0'
    addi x19, x19, 1    #i++
    j while             #loops again

done:
    lw x19, 0(sp)       # restores i
    addi sp, sp, +16    # restores sp
    jalr x0, 0(x1)      # return




end: j end