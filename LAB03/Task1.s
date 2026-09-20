.text
.globl main
main:
    addi x10, x0, 12  # a = 12
    addi x11, x0, 12  # b = 12
    jal x1, sum       # calls function sum
    
    addi x11, x10, 0  #stores return value from sum in x11
    li x10, 1         #print int ecall
    ecall             
    j exit

sum:                  # function sum definition
    add x10, x10, x11 #x10=a+b
    jalr x0, 0(x1)    #return

exit: j exit
