framecount = $ff

    !pseudopc PAYLOADLOC {

        ; Happify CPU ;-)
        sei
        cld
        ldx	#$ff
        txs

        ; we must set data first, then update DDR
        lda #$e7
        sta $01
        lda #$2f
        sta $00

        ; disable irq sources
        lda #$00
        sta $D01A
        lda #$7f
        sta $dc0d
        sta $dd0d
        
        lda #$1b
        sta $d011
        
        lda #$3f
        sta $dd02
        lda #$03
        sta $dd00
        
        lda #$c8
        sta $d016
        
        lda #0
        sta $d021

        lda #$33
        sta $01
        

        ldy #$10
--
        ldx #0
-
        txa
;        and #$07
hb0:    sta+2 $0002,x
        clc
        adc #$10
hb1:    sta $1000,x
        clc
        adc #$10
hb2:    sta $2000,x
        clc
        adc #$10
hb3:    sta $3000,x
        clc
        adc #$10
hb4:    sta $4000,x
        clc
        adc #$10
hb5:    sta $5000,x
        clc
        adc #$10
hb6:    sta $6000,x
        clc
        adc #$10
hb7:    sta $7000,x
        clc
        adc #$10
hb8:    sta $8000,x
        clc
        adc #$10
hb9:    sta $9000,x
        clc
        adc #$10
hba:    sta $a000,x
        clc
        adc #$10
hbb:    sta $b000,x
        clc
        adc #$10
hbc:    sta $c000,x
        clc
        adc #$20
hbe:    sta $e000,x
        clc
        adc #$10
hbf:    sta $f000,x
        inx
        bne -
        
        inc hb0+2
        inc hb1+2
        inc hb2+2
        inc hb3+2
        inc hb4+2
        inc hb5+2
        inc hb6+2
        inc hb7+2
        inc hb8+2
        inc hb9+2
        inc hba+2
        inc hbb+2
        inc hbc+2
        inc hbe+2
        inc hbf+2
        
        dey
        beq +
        jmp --
+
        ; prepare screens
        ldx #0
-
        txa
        tay
        and #7
        clc
        adc #$40
        sta $0002+(0*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $0402+(1*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $0802+(2*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $0c02+(3*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $1002+(4*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $1402+(5*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $1802+(6*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $1c02+(7*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $2002+(8*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $2402+(9*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $2802+(10*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $2c02+(11*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $3002+(12*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $3402+(13*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $3802+(14*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        sta $3c02+(15*40),x
        iny
        tya
        and #7
        clc
        adc #$40
        inx
        cpx #40-2
        beq +
        jmp -
+

        ; prepare some chars
        ldx #0
-
        lda chars,x
        sta $0000 + ($40 * 8),x
        sta $0800 + ($40 * 8),x
        sta $1000 + ($40 * 8),x
        sta $1800 + ($40 * 8),x
        sta $2000 + ($40 * 8),x
        sta $2800 + ($40 * 8),x
        sta $3000 + ($40 * 8),x
        sta $3800 + ($40 * 8),x
        inx
        cpx #8*8
        bne -

        lda #$35
        sta $01

        lda #$00
        ldx #0
-
        sta $d800,x
        sta $d900,x
        sta $da00,x
        sta $db00,x
        inx
        bne -

        ldx #2
-
        lda #1
        sta $d800,x
        lda #12
        sta $d800+(1*40),x
        lda #3
        sta $d800+(2*40),x
        lda #15
        sta $d800+(3*40),x

        lda #11
        sta $d800+(4*40),x
        lda #12
        sta $d800+(5*40),x
        lda #11
        sta $d800+(6*40),x
        lda #12
        sta $d800+(7*40),x
        lda #11
        sta $d800+(8*40),x
        lda #12
        sta $d800+(9*40),x
        lda #11
        sta $d800+(10*40),x
        lda #12
        sta $d800+(11*40),x

        lda #1 
        sta $d800+(12*40),x
        lda #12
        sta $d800+(13*40),x
        lda #3 
        sta $d800+(14*40),x
        lda #15
        sta $d800+(15*40),x
        inx
        cpx #40
        bne -

        lda #0
        sta $d020
        
        lda #5
        sta framecount

        jmp freezestart
        
        !align 255,0,0
freezestart:
        
loop:

-       lda $d011
        bpl -
-       lda $d011
        bmi -

        ldy #3
        sty $dd00

        ldx #$00        ; screen $0000 char $0000
        stx $d018

        lda #$34
-       cmp $d012
        bne -
        ldx #$10        ; screen $0400 char $0000
        stx $d018

        ;inc $d020

        ldx #$11        ; screen $0400 char $0000
        lda #$3a
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(1*8)
-       cmp $d012
        bne -
        ldx #$21        ; screen $0800 char $0000
        stx $d018

        ;inc $d020

        ldx #$22        ; screen $0800 char $0800
        lda #$3a+(1*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(2*8)
-       cmp $d012
        bne -
        ldx #$32        ; screen $0800 char $0000
        stx $d018

        ;inc $d020

        ldx #$33        ; screen $0c00 char $0800
        lda #$3a+(2*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(3*8)
-       cmp $d012
        bne -
        ldx #$43        ; screen $1000 char $0800
        stx $d018

        ;inc $d020

        ldx #$44        ; screen $1000 char $1000
        lda #$3a+(3*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(4*8)
-       cmp $d012
        bne -
        ldx #$54        ; screen $1400 char $1000
        stx $d018

        ;inc $d020

        ldx #$55        ; screen $1400 char $1000
        lda #$3a+(4*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(5*8)
-       cmp $d012
        bne -
        ldx #$65        ; screen $1800 char $1000
        stx $d018

        ;inc $d020

        ldx #$66        ; screen $1800 char $1800
        lda #$3a+(5*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(6*8)
-       cmp $d012
        bne -
        ldx #$76        ; screen $1c00 char $1800
        stx $d018

        ;inc $d020

        ldx #$77        ; screen $1c00 char $1800
        lda #$3a+(6*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(7*8)
-       cmp $d012
        bne -
        ldx #$87        ; screen $2000 char $1800
        stx $d018

        ;inc $d020


        ldx #$88        ; screen $2000 char $2000
        lda #$3a+(7*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(8*8)
-       cmp $d012
        bne -
        ldx #$98        ; screen $2300 char $2000
        stx $d018

        ;inc $d020


        ldx #$99        ; screen $2400 char $2000
        lda #$3a+(8*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(9*8)
-       cmp $d012
        bne -
        ldx #$a9        ; screen $2800 char $2000
        stx $d018

        ;inc $d020


        ldx #$aa        ; screen $2800 char $2800
        lda #$3a+(9*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(10*8)
-       cmp $d012
        bne -
        ldx #$ba        ; screen $2c00 char $2800
        stx $d018

        ;inc $d020


        ldx #$bb        ; screen $2c00 char $2800
        lda #$3a+(10*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(11*8)
-       cmp $d012
        bne -
        ldx #$cb        ; screen $3000 char $2800
        stx $d018

        ;inc $d020


        ldx #$cc        ; screen $3000 char $3000 (cartridge ROM)
        lda #$3a+(11*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(12*8)
-       cmp $d012
        bne -
        ldx #$dc        ; screen $3400 char $3000
        stx $d018

        ;inc $d020


        ldx #$dd        ; screen $3400 char $3000 (cartridge ROM)
        lda #$3a+(12*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(13*8)
-       cmp $d012
        bne -
        ldx #$ed        ; screen $3800 char $3000
        stx $d018

        ;inc $d020


        ldx #$ee        ; screen $3800 char $3800 (cartridge ROM)
        lda #$3a+(13*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #$34+(14*8)
-       cmp $d012
        bne -
        ldx #$fe        ; screen $3c00 char $3800
        stx $d018

        ;inc $d020


        ldx #$ff        ; screen $3c00 char $3800 (cartridge ROM)
        lda #$3a+(14*8)
-       cmp $d012
        bne -
-       cmp $d012
        beq -
        stx $d018

        lda #0
        sta $d020

        dec framecount
        bne +
        lda #0
        sta $d7ff
+
        jmp loop

chars:
        !byte %11111111
        !byte %11000011
        !byte %11011011
        !byte %11011011
        !byte %11011011
        !byte %11011011
        !byte %11000011
        !byte %11111111

        !byte %11111111
        !byte %11101111
        !byte %11101111
        !byte %11101111
        !byte %11101111
        !byte %11101111
        !byte %11101111
        !byte %11111111

        !byte %11111111
        !byte %11000011
        !byte %11111011
        !byte %11000011
        !byte %11011111
        !byte %11011111
        !byte %11000011
        !byte %11111111

        !byte %11111111
        !byte %11000011
        !byte %11111011
        !byte %11100011
        !byte %11111011
        !byte %11111011
        !byte %11000011
        !byte %11111111

        !byte %11111111
        !byte %11011011
        !byte %11011011
        !byte %11000011
        !byte %11111011
        !byte %11111011
        !byte %11111011
        !byte %11111111

        !byte %11111111
        !byte %11000011
        !byte %11011111
        !byte %11000011
        !byte %11111011
        !byte %11111011
        !byte %11000011
        !byte %11111111

        !byte %11111111
        !byte %11000011
        !byte %11011111
        !byte %11000011
        !byte %11011011
        !byte %11011011
        !byte %11000011
        !byte %11111111

        !byte %11111111
        !byte %11000011
        !byte %11111011
        !byte %11110011
        !byte %11111011
        !byte %11111011
        !byte %11111011
        !byte %11111111

}
