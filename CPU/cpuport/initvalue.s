
    * = $8000

    !word copycode
    !word copycode
    !byte $c3, $c2, $cd, $38, $30
		 
		 
copycode:
            sei

            lda #$01
            sta $d020
            lda #0
            sta $d021
            lda #$1b
            sta $d011
            lda #3
            sta $dd00
            lda #$15
            sta $d018
            lda #$c8
            sta $d016
            
            ldx #0
-
            lda #$20
            sta $0400,x
            sta $0500,x
            sta $0600,x
            sta $0700,x
            lda #$01
            sta $d800,x
            sta $d900,x
            sta $da00,x
            sta $db00,x
            inx
            bne -
            
            ldx #0
-
            lda ramcode,x
            sta $0800,x
            lda ramcode+$100,x
            sta $0800+$100,x
            inx
            bne -
            
            jmp $0800

ramcode:
!pseudopc $0800 {
            lda $00
            sta $0400
            ldy #5
            jsr hexout
            
            lda $01
            sta $0401
            ldy #8
            jsr hexout
            
            tsx
            stx $0402
            txa
            ldy #11
            jsr hexout
            
-           lda $d011
            bpl -
-           lda $d011
            bmi -
-           lda $d011
            bpl -
-           lda $d011
            bmi -

            lda #$ff
            sta $00
            
            lda $01
            sta $0403
            ldy #15
            jsr hexout

            lda #$00
            sta $00
            
            lda $0400
            cmp #$00
            bne failed
            lda $0401
            cmp #$17
            bne failed
            lda $0402
            cmp #$ff
            bne failed
            lda $0403
            cmp #$00
            bne failed
            
            lda #5
            sta $d020
            lda #$00        ; ok
            sta $d7ff
            jmp *

failed:
            lda #2
            sta $d020
            lda #$ff        ; failure
            sta $d7ff
            jmp *

hexout:
            pha
            lsr
            lsr
            lsr
            lsr
            tax
            lda hextab,x
            sta $0400,y

            pla
            and #$0f
            tax
            lda hextab,x
            sta $0401,y
            rts
hextab:
            !scr "0123456789abcdef"
}

            * = $a000-1
            !byte 0
