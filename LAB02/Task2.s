.text
.globl main
main:
    li x22,20  #b=20
    li x23,10  #c=10
    li x20,4   #x=4
    li x5,1    #t0=1
    li x6,2    #t1=2
    li x7,3    #t2=3
    li x28,4   #t3=4

case1: 
    bne x20,x5,case2   # if x!=1 goes to case2
    add x21,x22,x23    # a = b + c
    j end              # break

case2: 
    bne x20,x6,case3   # if x!=2 goes to case3
    sub x21,x22,x23    # a = b - c
    j end              # break

case3: 
    bne x20,x7,case4   # if x!=3 goes to case4
    slli x21,x22,1     # a = b*2
    j end              # break

case4: 
    bne x20,x28,default # if x!=4 goes to default
    srli x21,x22,1      # a = b/2
    j end               # break

default: 
    addi x21,x0,0      # a = 0 
    j end              # break

end: j end
    

