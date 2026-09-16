.text
.globl main
main:
    li x5, 5        # a = 5   (assumed)
    li x6, 5        # b = 5   (assumed)
    li x10, 0x100   # BA of array D (assumed)
    li x7, 0        # i = 0
    
loop1: 
    bge x7, x5, exit1  # if i>=a go to exit 1
    li x29, 0          # j = 0

loop2:
    bge x29, x6, exit2  # if j>=b go to exit 2
    add x30, x7, x29    # temporary register x30 gets i + j
    slli x31, x29, 4    # x31 = (j*4)*4     (to calculate byte offset for j*4) 
    add x31, x31, x10   # x31 = BA + (j*4)*4  (address of D[4*j])
    sw x30, 0(x31)      # D[4*j] = i + j
    addi x29, x29, 1    # j++
    j loop2             # loops again

exit2:
    addi x7, x7, 1      # i++
    j loop1             # loops again

exit1: j exit1

