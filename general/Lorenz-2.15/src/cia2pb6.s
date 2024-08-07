; this file is part of the C64 Emulator Test Suite. public domain, no copyright

; original file was: cia2pb6.asm
;-------------------------------------------------------------------------------

            .include "common.asm"
            .include "printhb.asm"
            .include "waitborder.asm"
            .include "waitkey.asm"

;-------------------------------------------------------------------------------
thisname .null "cia2pb6"
nextname .null "cia2pb7"
;-------------------------------------------------------------------------------
main:

;---------------------------------------
;old cra 0 start
;    cra 1 pb6out
;    cra 2 pb6toggle
;new cra 0 start
;    cra 1 pb6out
;    cra 2 pb6toggle
;    cra 4 force load

         .block
         jmp start

i        .byte 0
old      .byte 0
new      .byte 0
or       .byte 0
right    .text "----------------"
         .text "0000000000000000"
         .text "----------------"
         .text "1111111111111111"
         .text "----------------"
         .text "0000000000000000"
         .text "----------------"
         .text "1111111111111111"

start
         lda #0
         sta i
loop
         lda #$40
         sta $dd03
         lda #0
         sta $dd01
         sta $dd0e
         sta $dd0f
         lda #127
         sta $dd0d
         bit $dd0d
         lda #$ff
         sta $dd04
         sta $dd05
         lda i
         and #%00000111
         sta $dd0e
         sta old
         lda i
         lsr a
         lsr a
         pha
         and #%00010000
         sta or
         pla
         lsr a
         and #%00000111
         ora or
         sta $dd0e
         sta new
         lda $dd01
         eor #$40
         sta $dd01
         cmp $dd01
         beq minus
         eor #$40
         asl a
         asl a
         lda #"0"/2
         rol a
         jmp nominus
minus
         lda #"-"
nominus
         ldx i
         cmp right,x
         beq ok
         pha
         jsr print
         .byte 13
         .text "old new pb6  "
         .byte 0
         lda old
         jsr printhb
         lda #32
         jsr $ffd2
         lda new
         jsr printhb
         lda #32
         jsr $ffd2
         pla
         jsr $ffd2
         jsr waitkey
ok
         inc i
         bmi end
         jmp loop
end
         .bend

;---------------------------------------
;toggle pb6, cra one shot, start timer
;-> pb6 must be high
;wait until cra has stopped
;-> pb6 must be low
;write cra, write ta low/high, force
;load, pb6on, pb6toggle
;-> pb6 must remain low
;start
;-> pb6 must go high

         .block
         lda #0
         sta $dd0e
         ldx #100
         stx $dd04
         sta $dd05
         sei
         jsr waitborder
         lda #$0f
         sta $dd0e
         lda #$40
         bit $dd01
         bne ok1
         jsr print
         .byte 13
         .null "pb6 is not high"
         jsr waitkey
ok1
         lda #$01
wait
         bit $dd0e
         bne wait
         lda #$40
         bit $dd01
         beq ok2
         jsr print
         .byte 13
         .null "pb6 is not low"
         jsr waitkey
ok2
         lda #$0e
         sta $dd0e
         lda #$40
         bit $dd01
         beq ok3
         jsr print
         .byte 13
         .text "writing cra may "
         .text "not set pb6 high"
         .byte 0
         jsr waitkey
ok3
         lda #100
         sta $dd04
         lda #$40
         bit $dd01
         beq ok4
         jsr print
         .byte 13
         .text "writing ta low may "
         .text "not set pb6 high"
         .byte 0
         jsr waitkey
ok4
         lda #0
         sta $dd05
         lda #$40
         bit $dd01
         beq ok5
         jsr print
         .byte 13
         .text "writing ta high may "
         .text "not set pb6 high"
         .byte 0
         jsr waitkey
ok5
         lda #$1e
         sta $dd0e
         lda #$40
         bit $dd01
         beq ok6
         jsr print
         .byte 13
         .text "force load may "
         .text "not set pb6 high"
         .byte 0
         jsr waitkey
ok6
         lda #%00001010
         sta $dd0e
         lda #%00001110
         sta $dd0e
         lda #$40
         bit $dd01
         beq ok7
         jsr print
         .byte 13
         .text "switching toggle "
         .text "may not set pb6 high"
         .byte 0
         jsr waitkey
ok7
         lda #%00001100
         sta $dd0e
         lda #%00001110
         sta $dd0e
         lda #$40
         bit $dd01
         beq ok8
         jsr print
         .byte 13
         .text "switching pb6on "
         .text "may not set pb6 high"
         .byte 0
         jsr waitkey
ok8
         sei
         jsr waitborder
         lda #%00000111
         sta $dd0e
         lda #$40
         bit $dd01
         bne ok9
         jsr print
         .byte 13
         .text "start must set "
         .text "pb6 high"
         .byte 0
         jsr waitkey
ok9
         lda #$40
         ldx #0
waitlow0
         dex
         beq timeout
         bit $dd01
         bne waitlow0
waithigh0
         dex
         beq timeout
         bit $dd01
         beq waithigh0
waitlow1
         dex
         beq timeout
         bit $dd01
         bne waitlow1
waithigh1
         dex
         beq timeout
         bit $dd01
         beq waithigh1
         jmp ok
timeout
         jsr print
         .byte 13
         .null "pb6 toggle timed out"
         jsr waitkey
ok
         .bend

;---------------------------------------
;cra pb6on/toggle 4 combinations
;wait until underflow
;set both pb6on and toggle
;-> pb6 must be independent from
;   pb6on/toggle state at underflow

         .block
         jmp start

i        .byte 0

start
         lda #3
         sta i
loop
         lda #0
         sta $dd0e
         lda #15
         sta $dd04
         lda #0
         sta $dd05
         sei
         jsr waitborder
         lda i
         sec
         rol a
         sta $dd0e
         ldx #$07
         stx $dd0e
         ldy $dd01
         sta $dd0e
         ldx #$07
         stx $dd0e
         lda $dd01
         and #$40
         bne error
         tya
         and #$40
         bne ok
error
         jsr print
         .byte 13
         .text "toggle state is not "
         .null "independent "
         lda i
         jsr printhb
         jsr waitkey
ok
         dec i
         bpl loop
         .bend

;---------------------------------------
;check pb6 timing

         .block
         jmp start

settab   .byte 7,7,7,7,7,7
         .byte 3,3,3,3,3,3,3,3
loadtab  .byte 7,6,3,2,1,0
         .byte 7,6,5,4,3,2,1,0
comptab  .byte 1,0,0,1,0,0
         .byte 0,1,0,0,0,0,0,1

i        .byte 0

start
         lda #loadtab-settab-1
         sta i
loop
         lda #0
         sta $dd0e
         ldx i
         lda loadtab,x
         sta $dd04
         lda #0
         sta $dd05
         sei
         jsr waitborder
         ldx i
         lda settab,x
         sta $dd0e
         nop
         nop
         lda $dd01
         asl a
         asl a
         lda #0
         rol a
         cmp comptab,x
         beq ok
         jsr print
         .byte 13
         .null "timing error index "
         lda i
         jsr printhb
         jsr waitkey
ok
         dec i
         bpl loop
         .bend

;---------------------------------------

         rts
