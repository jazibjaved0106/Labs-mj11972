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

    li x7, -1

    beq x10, x7, done  #if a == NULL go to done
    beq x11, x0, done  #if len == 0 go to done

bubble_sort:
    li x5, 0            # i = 0  
outer_loop:
    bge x5, x11, done         # if i >= len  go to done
    addi x6, x5, 0            # j = i
inner_loop:
    bge x6, x11, outer_next  # if j >= len go to outer_next
    slli x28, x6, 2          # offset = j * 4
    add x28, x28, x10        # x28 gets address of a[j]
    slli x29, x5, 2          # offset = i * 4
    add x29, x29, x10        # x29 gets address of a[i]
    lw x30, 0(x28)           # x30 = a[j] = temp1
    lw x31, 0(x29)           # x31 = a[i] = temp2
    bge x31, x30, no_swap    # if a[i] >= a[j] go to no_swap
    sw x31, 0(x28)           # a[i] = temp1
    sw x30, 0(x29)           # a[j] = temp2
no_swap:
    addi x6, x6, 1           # j++
    j inner_loop             # repeats inner loop
outer_next:
    addi x5, x5, 1           # i++
    j outer_loop             # repeats outer loop

done: j done


