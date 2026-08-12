
;CARTTYPE = 0    ; Ultimax

;PAYLOADLOC = $0600

!macro chars {
    !byte %11111111
    !byte %11000011
    !byte %11011011
    !byte %11000011
    !byte %11011011
    !byte %11011011
    !byte %11011011
    !byte %11111111

    !byte %11111111
    !byte %11000111
    !byte %11011011
    !byte %11000111
    !byte %11011011
    !byte %11011011
    !byte %11000111
    !byte %11111111

    !byte %11111111
    !byte %11000011
    !byte %11011111
    !byte %11011111
    !byte %11011111
    !byte %11011111
    !byte %11000011
    !byte %11111111

    !byte %11111111
    !byte %11000111
    !byte %11011011
    !byte %11011011
    !byte %11011011
    !byte %11011011
    !byte %11000111
    !byte %11111111

    !byte %11111111
    !byte %11000011
    !byte %11011111
    !byte %11000111
    !byte %11011111
    !byte %11011111
    !byte %11000011
    !byte %11111111

    !byte %11111111
    !byte %11000011
    !byte %11011111
    !byte %11000111
    !byte %11011111
    !byte %11011111
    !byte %11011111
    !byte %11111111

    !byte %11111111
    !byte %11000011
    !byte %11011111
    !byte %11010011
    !byte %11011011
    !byte %11011011
    !byte %11000011
    !byte %11111111

    !byte %11111111
    !byte %11011011
    !byte %11011011
    !byte %11000011
    !byte %11011011
    !byte %11011011
    !byte %11011011
    !byte %11111111
}

    * = $0000

    ; ROML bank

    !fill $0400, %11000101
    !fill $0400, %10101001
    !fill $0400, %01110101
    !fill $0400, %11111101
    !fill $0400, %11010001
    !fill $0400, %10101001
    !fill $0400, %01010101
    !fill $0400, %11111111

    ;-------------------------------------------------------------------------

    !pseudopc $e000 {

start:
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

        !if (CARTTYPE=4) {
        ; MultiMAX (disable register latch, enable 2k external ram)
        sta $de80
        sta $0880
        }

        ; disable irq sources
        lda #$00
        sta $D01A
        lda #$1F
        sta $DC0D
        sta $DD0D


    ldx #0
-
    txa
    and #$0f
    sta $0002,x
    sta $0100,x
    sta $0200,x
    sta $0300,x
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    sta $0800,x
    sta $0900,x
    sta $0a00,x
    sta $0b00,x
    sta $0c00,x
    sta $0d00,x
    sta $0e00,x
    sta $0f00,x
    inx
    bne -

;     ldx #0
; -
;     lda payload,x
;     sta PAYLOADLOC,x
;     lda payload+$100,x
;     sta PAYLOADLOC+$100,x
;     lda payload+$200,x
;     sta PAYLOADLOC+$200,x
;     lda payload+$300,x
;     sta PAYLOADLOC+$300,x
;     inx
;     bne -
;
     jmp PAYLOADLOC
     !align 255,0
PAYLOADLOC=*
    !src "ultimax-vic.asm"

    }

    ;!fill $0800, %11000000
;    !fill $0400, %01110111
    * = $2800
    ; $e800     (screen, char)
    !fill 40*10, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 2) & 7)
    }

    * = $2800+($00*8)
    +chars
    ; $ec00     (screen)
    * = $3400
    !fill 40*11, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 3) & 7)
    }

    ; $f000     (screen, char)
    * = $3000
    !fill 40*12, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 4) & 7)
    }

    * = $3000+($00*8)
    +chars

    ; $fc00     (screen)
    * = $3400
    !fill 40*13, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 5) & 7)
    }

    ; $f800     (screen, char)
    * = $3800
    !fill 40*14, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 6) & 7)
    }
;    !fill $0200 - (40*15), %11111111
    * = $3800+($00*8)
    +chars
;    !fill $0200 - 64, %11111111
    ; $fc00     (screen)
    * = $3c00
    !fill 40*15, 0
    !for n, 0, 39 {
        !byte $00 + ((n + 6 + 7) & 7)
    }
;    !fill $0200 - (40*16), %11111111
;    * = $3c00+($40*8)
;    +chars
;    !fill $0200 - 64, %11111111

    * = $3ffa
    !word start
    !word start
    !word start

