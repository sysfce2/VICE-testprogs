srcbuffer = $03ff
checkbuffer = $0400

result = $10

    * = $0801
    !byte $0c, $08, $00, $00, $9e, $20, $34, $30, $39, $36
    !byte 0,0,0

    * = $1000

    sei
    lda #1
    sta $0286
    lda #$93
    jsr $ffd2

    ldx #0
-
    lda #$20
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    lda #$01
    sta $d800,x
    sta $da00,x
    lda #$0c
    sta $d900,x
    sta $db00,x
    inx
    bne -

    ; write a 0 to the first byte in bank 7

    LDA #<$0001
    STA $07
    LDA #>$0001
    STA $08

    LDA #>srcbuffer
    STA $03
    LDA #<srcbuffer
    STA $02

    LDA #$00
    STA $04
    STA $05
    
    lda #7
    STA $06        ; bank

    lda #0
    sta srcbuffer  ; value

    JSR copyC64toREU

    ; repeatedly read back the floating value

    LDA #<$0080
    STA $07
    LDA #>$0080
    STA $08

    ; REU -> screen
    LDA #>checkbuffer
    STA $03
    LDA #<checkbuffer
    STA $02

    ldx #$08
-
    JSR copyREUtoC64
    
    lda $02
    clc
    adc #$80
    sta $02
    bcc +
    inc $03
+
    dex
    bne -

    ; check some values. we have to skip the values in the middle because
    ; decay time varies

    ; first few should be 0s
    
    ldy #13 ; green
    sty fail
    ldx #0
-
    lda checkbuffer,x
    beq +
    ldy #10 ; red
    sty fail
+
    tya
    sta $d800,x
    inx
    cpx #$80
    bne -

    ; values at the end should be $ff
    ldy #13 ; green
    ldx #0
-
    lda checkbuffer+$200,x
    cmp #$ff
    beq +
    ldy #10 ; red
    sty fail
+
    tya
    sta $d800+$200,x
    inx
    bne -

fail=*+1
    lda #13
    sta $d020

    ldy #0
    cmp #10 ; red
    bne +
    ldy #$ff
+
    sty $d7ff
    jmp *

;------------------------------------------------------------------------------

copyREUtoC64:                  ; REU -> C64
    LDY #$91
copyC64toREU = * + 1           ; C64 -> REU
    BIT $90A0

    ; C64 addr
    LDA $03
    STA $DF03
    LDA $02
    STA $DF02

    ; REU addr
    LDA $05
    STA $DF05
    LDA $04
    STA $DF04
    LDA $06
    STA $DF06

    ; length
    LDA $08
    STA $DF08
    LDA $07
    STA $DF07

    LDA #$00
    STA $DF09   ; IMR
    STA $DF0A   ; ACR
    STY $DF01   ; Command
    RTS




