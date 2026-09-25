.text
.globl main
main:
    li x11, 5        # len = 5
    li x10, 0x100    # Base address of a 
    #Building array a:
    li x5, 3
    sw x5, 0(x10)
    li x5, 7
    sw x5, 4(x10)
    li x5, 1
    sw x5, 8(x10) 
    li x5, 5
    sw x5, 12(x10) 
    li x5, 9
    sw x5, 16(x10)   # a = [3,7,1,5,9]


    jal x1, find_max

    addi x11,x10,0
    li x10, 1
    ecall
    j end


find_max:
    lw x5, 0(x10)          # x5 = a[0] = current maximum
    li x6, 1               # i = 1

loop:
    bge x6, x11, return    # if i >= len go to return

    slli x28, x6, 2        # offset = i * 4
    add x28, x28, x10      # x28 = address of a[i]

    lw x29, 0(x28)         # x29 = a[i]

    bge x5, x29, no_update # if max >= a[i] go to no_update

    addi x5, x29, 0        # max = a[i]

no_update:
    addi x6, x6, 1         # i++
    j loop                 # repeat loop

return:
    addi x10, x5, 0        # return maximum in x10
    jalr x0, 0(x1)         # return

end: j end