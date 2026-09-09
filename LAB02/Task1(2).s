.text
.globl main
main:
    li x22, 0      # i = 0
    li x24, 10     # k = 10
    li x25, 0x1000  #base address of Save = 1000
    li x26, 10
    li x27, 20
    li x28, 30

    sw x26, 0(x25)  #Save=[10,
    sw x26, 4(x25)  #Save=[10,10
    sw x26, 8(x25)  #Save=[10,10,10
    sw x27, 12(x25) #Save=[10,10,10,20
    sw x28, 16(x25) #Save=[10,10,10,20,30]

Loop: slli x10, x22, 2   # Temp reg x10= i * 4
    add x10, x10, x25    # x10 = address of Save[i]
    lw x9, 0(x10)        # Temp reg x9 = Save[i]
    bne x9, x24, Exit    # go to Exit if Save[i] != k
    addi x22, x22, 1     # i = i + 1
    beq x0, x0, Loop     # go to Loop

Exit: j Exit
