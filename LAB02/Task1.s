.text
.globl main
main:
    li x22, 10        #i=10
    li x23, 11        #j=11
    li x20, 50        #g=50
    li x21, 30        #h=30
    
    bne x22, x23, Else    # i!= j
    add x19, x20, x21     # f = g + h
    beq x0, x0, Exit      # unconditional jump

Else: sub x19, x20, x21   # f = g - h

Exit: 

end:
    j  