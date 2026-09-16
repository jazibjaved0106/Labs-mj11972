.text
.globl main
main:
    li x22, 0   #i=0
    li x23, 0   #sum=0
    li x5, 10   #t0=10
    li x24, 0x200  # x24 stores BA for array a


loop1:
    bge x22, x5 , exit1   # if i>=10 goes to exit 1
    addi x6, x22, 0       #t1 gets i
    slli x6, x6, 2        #t1 = i * 4
    add x7, x6, x24       #t2 = BA + (i * 4) / address for a[i]
    sw x22, 0(x7)         #stores i at a[i] / a[i] = i
    addi x22, x22, 1      # i++
    j loop1               #loops again

exit1:
    li x22,0   #resets i=0 for loop2

loop2:
    bge x22, x5, exit2    # if i>=10 goes to exit 1
    addi x6, x22, 0       #t1 gets i
    slli x6, x6, 2        #t1 = i * 4
    add x7, x6, x24       #t2 = BA + (i * 4) / address for a[i]
    lw x28, 0(x7)         #t3 gets value at a[i]
    add x23, x23, x28     #sum = sum + a[i]
    addi x22, x22, 1      # i++
    j loop2               #loops again

exit2: j exit2

