.text
.globl main
main:
    li x10, 0x78786464
    li x11, 0xA8A81919
    li x20, 0x100
    li x21, 0x1F0

    
    sw x10, 0(x20)
    sw x11, 0(x21)
    lhu x12, 0(x20)
    lh x13, 0(x21)
    lb x14, 0(x21)

end:
    j end