.text
.globl main
main:
    addi x10,x0, 5 #x=5
    li x28, 1 # x28 = 1
    jal x1, nitri


    addi x11,x10,0    
    li x10, 1         # print int ecall
    ecall
    j end
    


nitri:
    addi sp, sp,-8 # adjust stack for 2 items
    sw x1, 4(sp) # save return address
    sw x10, 0(sp) # save argument num

    blt x28, x10, L1 # if 1 < num, go to L1

    addi x10, x0, 1 # return 1
    addi sp, sp, 8 # pop stack
    jalr x0, 0(x1) # return

L1:
    addi x10, x10,-1 # argument = num-1
    jal x1, nitri # recursive call

    addi x6, x10, 0 # save result of nitri(num-1)
    lw x10, 0(sp) # restore original num
    lw x1, 4(sp) # restore return address
    addi sp, sp, 8 # pop stack

    add x10, x10, x6 # num + nitri(num-1)
    jalr x0, 0(x1) # return

end: j end


