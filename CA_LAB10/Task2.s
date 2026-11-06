.text
.globl main

# Register setup from our memory map:
# s0 = 768 (switches), s1 = 512 (LEDs), s2 = 1020 (reset button)

start:
    addi sp, x0, 512             # stack starts at the top of data memory
    addi s0, x0, 768             # s0 holds the switch address
    addi s1, x0, 512             # s1 holds the LED address
    addi s2, x0, 1020            # s2 holds the reset button address

wait_input:                      # STATE 0: waiting for a switch input
    sw   x0, 0(s1)               # LEDs = 0 (Turn all LEDs off)
    lw   t0, 0(s2)               # Checking if reset button is pressed
    beq  t0, x0, chk_sw          # reset not pressed so now check switches
    beq  x0, x0, wait_input      # reset held -> stay
chk_sw:
    lw   a0, 0(s0)               # reading the switches, a0 is the starting count
    beq  a0, x0, wait_input      # all switches off, so keep waiting

    # Call countdown. We push return ID 1 so it knows where to come back to bypassing use of Jal
    addi sp, sp, -4
    addi t0, x0, 1               # return ID 1: go back to main
    sw   t0, 0(sp)               # push the return ID on the stack
    beq  x0, x0, countdown       # jump to countdown
ret_main:                        # countdown 
    beq  x0, x0, wait_input      # countdown done so go back to state 0

countdown:                       # STATE 1: a0 gets the starting count
    addi sp, sp, -4
    sw   s3, 0(sp)               # pushing s3 onto the stack so we restore it later
    addi s3, a0, 0               # s3 = counter (starting at a0)
cd_loop:
    sw   s3, 0(s1)               # LEDs = counter  (Showing the counter on the leds)
    beq  s3, x0, cd_done         # counter hit 0, so we're finished

    # CALL delay_1s (push return ID = 1)
    addi sp, sp, -4
    addi t0, x0, 1               # return ID 1 : go back to countdown
    sw   t0, 0(sp)               # push return ID
    beq  x0, x0, delay_1s        # jump to the delay
ret_cd:                          # delay_1s returns here
    beq  a0, x0, cd_next         # a0 = 0 : no reset (delay finished normally)
    beq  x0, x0, cd_reset        # a0 = 1 : reset was pressed
cd_next:
    addi s3, s3, -1              # counter goes down by 1
    beq  x0, x0, cd_loop         # show the new value on LEDs and repeat
cd_reset:
    sw   x0, 0(s1)               # reset is pressed so clear LEDs
cd_done:
    lw   s3, 0(sp)               # restore s3
    addi sp, sp, 4
    lw   t0, 0(sp)               # pop return ID
    addi sp, sp, 4
    addi t0, t0, -1              # subtract 1: ID 1 becomes 0
    beq  t0, x0, ret_main        # RETURN: ID was 1, so "return" to main
    beq  x0, x0, wait_input      # safety: unknown ID so restart

delay_1s:                        # wait about 1s,  returns a0 = 0 (done) or 1 (reset)
    addi sp, sp, -12
    sw   t1, 8(sp)               # save t1
    sw   t2, 4(sp)               # save t2
    sw   t3, 0(sp)               # save t3
    addi t3, x0, 2000            # outer count : outer loop runs 2000 times
d_outer:
    addi t1, x0, 1000            # inner count : inner loop runs 1000 times
d_inner:
    lw   t2, 0(s2)               # check reset on every iteration
    beq  t2, x0, d_ok            # reset not pressed so keep counting
    beq  x0, x0, d_reset         # reset pressed so stop the delay early
d_ok:
    addi t1, t1, -1              # inner count down by 1
    beq  t1, x0, d_inner_done    # inner loop finished
    beq  x0, x0, d_inner         # otherwise keep looping
d_inner_done:
    addi t3, t3, -1              # outer count down by 1
    beq  t3, x0, d_finish        # outer loop finished, 1 second is up
    beq  x0, x0, d_outer         # otherwise start the inner loop again
d_finish:
    addi a0, x0, 0               # a0 = 0, delay completed normally
    beq  x0, x0, d_exit
d_reset:
    addi a0, x0, 1               # a0 = 1, tells countdown reset was pressed
d_exit:
    lw   t3, 0(sp)               # restore t1,t2,t3
    lw   t2, 4(sp)
    lw   t1, 8(sp)
    addi sp, sp, 12
    lw   t0, 0(sp)               # pop return ID
    addi sp, sp, 4
    addi t0, t0, -1
    beq  t0, x0, ret_cd          # RETURN
    beq  x0, x0, wait_input      # safety: unknown ID