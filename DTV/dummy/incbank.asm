
; #2148 Wrong Bank for RMW Instructions in C64DTV

        !to "bug.prg",cbm
        !cpu c64dtv2
        * = $0801

        !by $0b,$08,$00,$00,$9e,$32,$30,$36,$31,$00,$00,$00

        sei
        ;copy "code4000" to bank 1
        ldx #$00
-       lda code4000,x
        sta $4000,x
        inx
        bne -
        jmp $4000

testcode:
        ldy #$ff
        sty $0800

        ;here is the bug:
        ;inc first write (Value $ff) goes into wrong bank (bank 0)!!!

        inc $0800
        rts

code4000:
!pseudopc $4000 {
        ;copy code to bank 1

        ldx #$00
-       lda $0800,x
        sta $4100,x
        inx
        bne -

        ;switch bank 0 to segment $7f
        sac #$cc
        lda #$7f
        sac #$00

        ;copy back the code, but now in the segment at $7f
-       lda $4100,x
        sta $0800,x
        inx
        bne -

        ;call the test code in bank $7f
        jsr testcode

        ;set segment 0 to bank 0
        sac #$cc
        lda #$00
        sac #$00

        ;check if bank 0 was modified -> error
        ldx #5
        ldy #$00        ;success

        lda $0800
        beq no_error
        ldx #10
        ldy #$ff        ; failure
no_error:
        stx $d020
        sty $d7ff
        rts
}










