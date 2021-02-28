// @ Description
// This file contains hacks for displaying useful information on the c-up menu.
print "included Display.asm\n"

scope Display {
    // Max HP displays the current effects count.
    scope effects_count: {
        OS.patch_start(0x81C24, 0x800E8774)
        jal     effects_count
        nop
        OS.patch_end()

        lui     t1, 0x800B              // a1 = effects table base
        ori     t2, t1, 0x017C          // a2 = loop end
        or      v0, r0, r0              // v0 = effects count
        loop:
        lw      t0, 0x4378(t1)          // t0 = effect from table
        bnel    t0, r0, loop_end        // branch if effect pointer != 0...
        addiu   v0, v0, 0x0001          // ...and increment effects count
        loop_end:
        bne     t1, t2, loop            // loop if table end hasn't been reached
        addiu   t1, t1, 0x0004          // increment base address

        end:
        jr      ra                      // return
        nop
    }

    // Max FP displays the bottom byte of player flags.
    scope jump_flag: {
        OS.patch_start(0x81D00, 0x800E8850)
        lbu     v0, 0xF18B(v0)          // v0 = bottom byte of player flags
        OS.patch_end()
    }

    // Star Points and Coin count display the AFK timer.
    scope afk_timer: {
        // Lock the coin blinking timer.
        OS.patch_start(0x81E38, 0x800E8988)
        sb      r0, 0x0055(s3)          // always store 0
        OS.patch_end()

        // Coin count always displays AFK timer, c-up menu is always shown.
        OS.patch_start(0x815A0, 0x800E80F0)
        lbu     v1, 0xF191(v1)          // v1 = bottom byte of AFK timer.
        OS.patch_end()
        OS.patch_start(0x815BC, 0x800E810C)
        lbu     v1, 0xF191(v1)          // v1 = bottom byte of AFK timer.
        OS.patch_end()
        OS.patch_start(0x815F8, 0x800E8148)
        lui     v0, 0x8011              // ~
        lbu     v0, 0xF191(v0)          // v0 = bottom byte of AFK timer.
        or      a0, r0, r0              // a0 = 0 (always shows c-up menu?)
        lui     v1, 0x8011              // ~
        lb      v1, 0xF452(v1)          // original logic
        OS.patch_end()

        // Star Points always display AFK timer.
        OS.patch_start(0x81DCC, 0x800E891C)
        lbu     a3, 0xF190(a3)          // a3 = top byte of AFK timer.
        OS.patch_end()
    }
}