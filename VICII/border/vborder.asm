  processor 6502

; Select the video timing (processor clock cycles per raster line)
;CYCLES = 65     ; 6567R8 and above, NTSC-M
;CYCLES = 64    ; 6567R5 6A, NTSC-M
;CYCLES = 63    ; 6569 (all revisions), PAL-B

cinv = $314
cnmi = $318
raster = 240     ; start of raster interrupt
m = $fb         ; zero page variable

key_delay1_dec = $41
key_delay1_inc = $53
key_delay2_dec = $4b
key_delay2_inc = $4c


  .org $801
basic:
  .word 0$      ; link to next line
  .word 1995    ; line number
  .byte $9E     ; SYS token

; SYS digits

  .if (* + 8) / 10000
  .byte $30 + (* + 8) / 10000
  .endif
  .if (* + 7) / 1000
  .byte $30 + (* + 7) % 10000 / 1000
  .endif
  .if (* + 6) / 100
  .byte $30 + (* + 6) % 1000 / 100
  .endif
  .if (* + 5) / 10
  .byte $30 + (* + 5) % 100 / 10
  .endif
  .byte $30 + (* + 4) % 10

0$:
  .byte 0,0,0   ; end of BASIC program

start:
  jmp install
  jmp deinstall

install:        ; install the raster routine
  jsr restore   ; Disable the Restore key (disable NMI interrupts)
checkirq:
  lda cinv      ; check the original IRQ vector
  ldx cinv+1    ; (to avoid multiple installation)
  cmp #<irq1
  bne irqinit
  cpx #>irq1
  beq skipinit
irqinit:
  sei
  sta oldirq    ; store the old IRQ vector
  stx oldirq+1
  lda #<irq1
  ldx #>irq1
  sta cinv      ; set the new interrupt vector
  stx cinv+1
skipinit:
  lda #$1b
  sta $d011     ; set the raster interrupt location
  lda #raster
  sta $d012
  lda #$7f
  sta $dc0d     ; disable timer interrupts
  sta $dd0d
  ldx #1
  stx $d01a     ; enable raster interrupt
  lda $dc0d     ; acknowledge CIA interrupts
  lsr $d019     ; and video interrupts
  cli
  lda #$20
  sta $fa
  sta $fb
  lda #$55
  sta $3fff
  ldy #$00
instruction:
  lda inst1,y
  sta $0402,y
  lda inst2,y
  sta $042a,y
  lda #$01
  sta $d802,y
  sta $d82a,y
  iny
  cpy #$05
  bne instruction
  jmp gui

inst1: 
 dc.b " ",key_delay1_dec-$40,"-",key_delay1_inc-$40," "
inst2: 
 dc.b " ",key_delay2_dec-$40,"-",key_delay2_inc-$40," "


deinstall:
  sei           ; disable interrupts
  lda #$1b
  sta $d011     ; restore text screen mode
  lda #$81
  sta $dc0d     ; enable Timer A interrupts on CIA 1
  lda #0
  sta $d01a     ; disable video interrupts
  lda oldirq
  sta cinv      ; restore old IRQ vector
  lda oldirq+1
  sta cinv+1
  bit $dd0d     ; re-enable NMI interrupts
  cli
  rts

; Auxiliary raster interrupt (for syncronization)
irq1:
; irq (event)   ; > 7 + at least 2 cycles of last instruction (9 to 16 total)
; pha           ; 3
; txa           ; 2
; pha           ; 3
; tya           ; 2
; pha           ; 3
; tsx           ; 2
; lda $0104,x   ; 4
; and #xx       ; 2
; beq           ; 3
; jmp ($314)    ; 5
                ; ---
                ; 38 to 45 cycles delay at this stage
  lda #<irq2
  sta cinv
  lda #>irq2
  sta cinv+1
  nop           ; waste at least 12 cycles
  nop           ; (up to 64 cycles delay allowed here)
  nop
  nop
  nop
  nop
  inc $d012     ; At this stage, $d012 has already been incremented by one.
  lda #1
  sta $d019     ; acknowledge the first raster interrupt
  cli           ; enable interrupts (the second interrupt can now occur)
  ldy #9
  dey
  bne *-1       ; delay
  nop           ; The second interrupt will occur while executing these
  nop           ; two-cycle instructions.
  nop
  nop
  nop
oldirq = * + 1  ; Placeholder for self-modifying code
  jmp *         ; Return to the original interrupt

; Main raster interrupt
irq2:
; irq (event)   ; 7 + 2 or 3 cycles of last instruction (9 or 10 total)
; pha           ; 3
; txa           ; 2
; pha           ; 3
; tya           ; 2
; pha           ; 3
; tsx           ; 2
; lda $0104,x   ; 4
; and #xx       ; 2
; beq           ; 3
; jmp (cinv)    ; 5
                ; ---
                ; 38 or 39 cycles delay at this stage
  lda #<irq1
  sta cinv
  lda #>irq1
  sta cinv+1
  ldx $d012
  nop
#if CYCLES - 63
#if CYCLES - 64
  nop           ; 6567R8, 65 cycles/line
  bit $24
#else
  nop           ; 6567R56A, 64 cycles/line
  nop
#endif
#else
  bit $24       ; 6569, 63 cycles/line
#endif
  cpx $d012     ; The comparison cycle is executed CYCLES or CYCLES+1 cycles
                ; after the interrupt has occurred.
  beq *+2       ; Delay by one cycle if $d012 hadn't changed.
                ; Now exactly CYCLES+3 cycles have passed since the interrupt.
  dex
  dex
  stx $d012     ; restore original raster interrupt position
  ldx #1
  stx $d019     ; acknowledge the raster interrupt


; start action here

  ldx #$18
loop1:
  dex
  bne loop1

  inc $d021
  dec $d021
  inc $d020
  dec $d020
  
  lda $fa
  jsr delay

  inc $d021
  dec $d021
  inc $d020
  dec $d020

  lda #$13
  sta $d011

  lda #$00
  jsr delay
  lda #$00
  jsr delay
  
  lda $fb
  jsr delay

  inc $d021
  dec $d021
  inc $d020
  dec $d020

  lda #$1b
  sta $d011

  jmp $ea81

  ldx #$13
  lda #$ff
waitfor255:  
  cmp $d012
  bne waitfor255
  stx $d011


  jmp $ea81     ; return to the auxiliary raster interrupt

restore:        ; disable the Restore key
  lda cnmi
  ldy cnmi+1
  pha
  lda #<nmi     ; Set the NMI vector
  sta cnmi
  lda #>nmi
  sta cnmi+1
  ldx #$81
  stx $dd0d     ; Enable CIA 2 Timer A interrupt
  ldx #0
  stx $dd05
  inx
  stx $dd04     ; Prepare Timer A to count from 1 to 0.
  ldx #$dd
  stx $dd0e     ; Cause an interrupt.
nmi = * + 1
  lda #$40      ; RTI placeholder
  pla
  sta cnmi
  sty cnmi+1    ; restore original NMI vector (although it won't be used)
  rts

gui:
  sec
  lda #$40
  sbc $fa
  ldy #$01
  jsr printhex
  sec
  lda #$40
  sbc $fb
  ldy #$29
  jsr printhex

  jsr $ffe4
  beq gui
  
  cmp  #key_delay1_dec
  bne testdelay1inc
  inc $fa
  lda $fa
  cmp #$41
  bne gui
  dec $fa
  jmp gui

testdelay1inc:
  cmp  #key_delay1_inc
  bne testdelay2dec
  dec $fa
  bpl gui
  inc $fa
  jmp gui
  
testdelay2dec:
  cmp  #key_delay2_dec
  bne testdelay2inc
  inc $fb
  lda $fb
  cmp #$41
  bne gui
  dec $fb
  jmp gui

testdelay2inc:
  cmp  #key_delay2_inc
  bne gui
  dec $fb
  bpl gui
  inc $fb
  jmp gui

printhex:
    pha
    ; mask lower
    and #$0f
    ; lookup
    tax
    lda hex_lut,x
    ; print
    sta $0400,y
    lda #$01
    sta $d800,y
    ; lsr x4
    pla
    lsr
    lsr
    lsr
    lsr
    ; lookup
    tax
    lda hex_lut,x
    ; print
    dey
    sta $0400,y
    lda #$01
    sta $d800,y
    rts

; hex lookup table
hex_lut: 
 dc.b "0123456789",1,2,3,4,5,6


 .org  $1000
delay:              ;delay 80-accu cycles, 0<=accu<=64
    lsr             ;2 cycles akku=akku/2 carry=1 if accu was odd, 0 otherwise
    bcc waste1cycle ;2/3 cycles, depending on lowest bit, same operation for both
waste1cycle:
    sta smod+1      ;4 cycles selfmodifies the argument of branch
    clc             ;2 cycles
;now we have burned 10/11 cycles.. and jumping into a nopfield 
smod:
    bcc *+10
 .byte $EA,$EA,$EA,$EA,$EA,$EA,$EA,$EA
 .byte $EA,$EA,$EA,$EA,$EA,$EA,$EA,$EA
 .byte $EA,$EA,$EA,$EA,$EA,$EA,$EA,$EA
 .byte $EA,$EA,$EA,$EA,$EA,$EA,$EA,$EA
    rts             ;6 cycles
