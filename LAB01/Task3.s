.text
.globl main
main:
    li x20, 5  # a=5
    li x21, 0  # b=0
    li x24, 5  #stores 5 

    addi x20, x21 , 32 # a=b+32
    add x22, x20, x21  #a+b
    sub x23, x22, x24 # d= (a+b)-5
    sub x25, x20, x23  # a-d
    sub x26, x21, x20  #b-a
    add x27, x25, x26 # ((a-d)+(b-a)) 
    add x28, x27, x23 # e=(((a-d)+(b-a))+d)

    add x28, x28, x20  # e+a
    add x28, x28, x21  # e+b
    add x28, x28, x23  #e+d

end:
    j end 