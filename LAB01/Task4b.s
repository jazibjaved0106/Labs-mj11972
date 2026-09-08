.text
.globl main
main:
    li x20, 0x100   #base address for char array a
    li x21, 0x200   #base address for short array b
    li x22, 0x300   #base address for unsigned integer array c
    

    #for i=0
    lb x10, 0(x20)      #x10 gets value from a[i]
    lh x11, 0(x21)      #x11 gets value from b[i]
    add x12, x10, x11   #temp reg x12 stores value of a[i]+b[i]
    sw  x12, 0(x22)     #value from x12 gets tranferred to memory to c[i]

    #for i=1
    lb x10, 1(x20)
    lh x11, 2(x21)
    add x12, x10, x11
    sw  x12, 4(x22)

    #for i=2
    lb x10, 2(x20)
    lh x11, 4(x21)
    add x12, x10, x11
    sw  x12, 8(x22)

    #for i=3
    lb x10, 3(x20)
    lh x11, 6(x21)
    add x12, x10, x11
    sw  x12, 12(x22)

end:
    j end
