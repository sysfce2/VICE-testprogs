; taken from http://www.6502.org/tutorials/decimal_mode.html

videoram = $0400
colorram = $d800

;-------------------------------------------------------------------------------
            *=$07ff
            !word $0801
            !word bend
            !word 10
            !byte $9e
            !text "2061", 0
bend:       !word 0
;-------------------------------------------------------------------------------

AR    = $10
CF    = $11
DA    = $12
DNVZC = $13
ERROR = $14
HA    = $15
HNVZC = $16
N1    = $17
N1H   = $18
N1L   = $19
N2    = $1a
N2L   = $1b
NF    = $1c
VF    = $1d
ZF    = $1e

N2H   = $1f     ; 2 bytes


            sei
            lda #$17
            sta $d018
            lda #$35
            sta $01
            lda #$7f
            sta $dc0d
            sta $dd0d
            lda $dc0d
            lda $dd0d
            ldx #0
-
            lda #$20
            sta videoram,x
            sta videoram+$0100,x
            sta videoram+$0200,x
            sta videoram+$0300,x
            lda #1
            sta colorram,x
            sta colorram+$0100,x
            sta colorram+$0200,x
            sta colorram+$0300,x
            inx
            bne -

            jsr TEST

            lda ERROR
            sta $0400
            bne fail

            lda #5
            sta $d020
            jmp *
fail
            lda #10
            sta $d020
            jmp *

;-------------------------------------------------------------------------------

; Verify decimal mode behavior
;
; Returns:
;   ERROR = 0 if the test passed
;   ERROR = 1 if the test failed
;
; This routine requires 17 bytes of RAM -- 1 byte each for:
;   AR, CF, DA, DNVZC, ERROR, HA, HNVZC, N1, N1H, N1L, N2, N2L, NF, VF, and ZF
; and 2 bytes for N2H
;
; Variables:
;   N1 and N2 are the two numbers to be added or subtracted
;   N1H, N1L, N2H, and N2L are the upper 4 bits and lower 4 bits of N1 and N2
;   DA and DNVZC are the actual accumulator and flag results in decimal mode
;   HA and HNVZC are the accumulator and flag results when N1 and N2 are
;     added or subtracted using binary arithmetic
;   AR, NF, VF, ZF, and CF are the predicted decimal mode accumulator and
;     flag results, calculated using binary arithmetic
;
; This program takes approximately 1 minute at 1 MHz (a few seconds more on
; a 65C02 than a 6502 or 65816)
;
TEST    LDY #1    ; initialize Y (used to loop through carry flag values)
        STY ERROR ; store 1 in ERROR until the test passes
        LDA #0    ; initialize N1 and N2
        STA N1
        STA N2
LOOP1   LDA N2    ; N2L = N2 & $0F
        AND #$0F  ; [1] see text
        STA N2L
        LDA N2    ; N2H = N2 & $F0
        AND #$F0  ; [2] see text
        STA N2H
        ORA #$0F  ; N2H+1 = (N2 & $F0) + $0F
        STA N2H+1
LOOP2   LDA N1    ; N1L = N1 & $0F
        AND #$0F  ; [3] see text
        STA N1L
        LDA N1    ; N1H = N1 & $F0
        AND #$F0  ; [4] see text
        STA N1H
        JSR ADD
        JSR A6502
        JSR COMPARE
        BNE DONE
        JSR SUB
        JSR S6502
        JSR COMPARE
        BNE DONE
        INC N1    ; [5] see text
        BNE LOOP2 ; loop through all 256 values of N1
        INC N2    ; [6] see text
        BNE LOOP1 ; loop through all 256 values of N2
        DEY
        BPL LOOP1 ; loop through both values of the carry flag
        LDA #0    ; test passed, so store 0 in ERROR
        STA ERROR
DONE    RTS

; Calculate the actual decimal mode accumulator and flags, the accumulator
; and flag results when N1 is added to N2 using binary arithmetic, the
; predicted accumulator result, the predicted carry flag, and the predicted
; V flag
;
ADD     SED       ; decimal mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        ADC N2
        STA DA    ; actual accumulator result in decimal mode
        PHP
        PLA
        STA DNVZC ; actual flags result in decimal mode
        CLD       ; binary mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        ADC N2
        STA HA    ; accumulator result of N1+N2 using binary arithmetic

        PHP
        PLA
        STA HNVZC ; flags result of N1+N2 using binary arithmetic
        CPY #1
        LDA N1L
        ADC N2L
        CMP #$0A
        LDX #0
        BCC A1
        INX
        ADC #5    ; add 6 (carry is set)
        AND #$0F
        SEC
A1      ORA N1H
;
; if N1L + N2L <  $0A, then add N2 & $F0
; if N1L + N2L >= $0A, then add (N2 & $F0) + $0F + 1 (carry is set)
;
        ADC N2H,X
        PHP
        BCS A2
        CMP #$A0
        BCC A3
A2      ADC #$5F  ; add $60 (carry is set)
        SEC
A3      STA AR    ; predicted accumulator result
        PHP
        PLA
        STA CF    ; predicted carry result
        PLA
;
; note that all 8 bits of the P register are stored in VF
;
        STA VF    ; predicted V flags
        RTS

; Calculate the actual decimal mode accumulator and flags, and the
; accumulator and flag results when N2 is subtracted from N1 using binary
; arithmetic
;
SUB     SED       ; decimal mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        SBC N2
        STA DA    ; actual accumulator result in decimal mode
        PHP
        PLA
        STA DNVZC ; actual flags result in decimal mode
        CLD       ; binary mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        SBC N2
        STA HA    ; accumulator result of N1-N2 using binary arithmetic

        PHP
        PLA
        STA HNVZC ; flags result of N1-N2 using binary arithmetic
        RTS

; Calculate the predicted SBC accumulator result for the 6502 and 65816

;
SUB1    CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1L
        SBC N2L
        LDX #0
        BCS S11
        INX
        SBC #5    ; subtract 6 (carry is clear)
        AND #$0F
        CLC
S11     ORA N1H
;
; if N1L - N2L >= 0, then subtract N2 & $F0
; if N1L - N2L <  0, then subtract (N2 & $F0) + $0F + 1 (carry is clear)
;
        SBC N2H,X
        BCS S12
        SBC #$5F  ; subtract $60 (carry is clear)
S12     STA AR
        RTS

; Calculate the predicted SBC accumulator result for the 6502 and 65C02

;
SUB2    CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1L
        SBC N2L
        LDX #0
        BCS S21
        INX
        AND #$0F
        CLC
S21     ORA N1H
;
; if N1L - N2L >= 0, then subtract N2 & $F0
; if N1L - N2L <  0, then subtract (N2 & $F0) + $0F + 1 (carry is clear)
;
        SBC N2H,X
        BCS S22
        SBC #$5F   ; subtract $60 (carry is clear)
S22     CPX #0
        BEQ S23
        SBC #6
S23     STA AR     ; predicted accumulator result
        RTS

; Compare accumulator actual results to predicted results
;
; Return:
;   Z flag = 1 (BEQ branch) if same
;   Z flag = 0 (BNE branch) if different
;
COMPARE LDA DA
        CMP AR
        BNE C1
        LDA DNVZC ; [7] see text
        EOR NF
        AND #$80  ; mask off N flag
        BNE C1
        LDA DNVZC ; [8] see text
        EOR VF
        AND #$40  ; mask off V flag
        BNE C1    ; [9] see text
        LDA DNVZC
        EOR ZF    ; mask off Z flag
        AND #2
        BNE C1    ; [10] see text
        LDA DNVZC
        EOR CF
        AND #1    ; mask off C flag
C1      RTS

; These routines store the predicted values for ADC and SBC for the 6502,
; 65C02, and 65816 in AR, CF, NF, VF, and ZF

A6502   LDA VF
;
; since all 8 bits of the P register were stored in VF, bit 7 of VF contains
; the N flag for NF
;
        STA NF
        LDA HNVZC
        STA ZF
        RTS

S6502   JSR SUB1
        LDA HNVZC
        STA NF
        STA VF
        STA ZF
        STA CF
        RTS

A65C02  LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        RTS

S65C02  JSR SUB2
        LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        LDA HNVZC
        STA VF
        STA CF
        RTS

A65816  LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        RTS

S65816  JSR SUB1
        LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        LDA HNVZC
        STA VF
        STA CF
        RTS 
