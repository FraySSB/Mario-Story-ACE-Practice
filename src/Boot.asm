// @ Description
// This file contains functions that run on boot.
print "included Boot.asm\n"

scope Boot {
    scope init: {
        // Hook into original boot routine
        OS.patch_start(0x00025E2C, 0x8004AA2C)
        // DMA our files into expansion ram
        lui     a0, 0x0280                  // begin (0x02800000)
        li      a1, DMA_END - 0x80400000 + 0x02800000 // end
        jal     0x800296FC                  // dma function
        lui     a2, 0x8040                  // ram address (0x80400000)
        jal     init                        // modified boot routine
        nop
        OS.patch_end()

        clear_memory:
        // clear the rest of expansion ram
        li      t0, DMA_END                 // t0 = begin address
        lui     t1, 0x8080                  // t1 = end address

        loop:
        sd      r0, 0x0000(t0)              // clear memory
        addiu   t0, t0, 0x0008              // increment t0
        bne     t0, t1, loop                // loop if end address hasn't been reached
        nop

        lui     t0, 0x807C                  // t0 = 0x807C0000
        li      t1, 0x0801DE67              // t1 = jal to file names
        sw      t1, 0x0000(t0)              // store jal at 0x807C0000 (OoT would normally do this)

        end:
        // run the original instructions we replaced and return
        lui   s0, 0x800A
        addiu s0, s0, 0xED68
        daddu a0, s0, r0
        addiu a1, r0, 0x0003
        lui   a2, 0x8005
        addiu a2, a2, 0xAAB8
        jr    ra
        lui   v0, 0x800A
    }

}