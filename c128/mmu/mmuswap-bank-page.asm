; When the zero page is relocated to a regular page in bank 1,
; the page in bank 0 is not swapped, and only the page in bank 1
; is swapped.
;
; test not yet confirmed on real hardware
;
; Test made by Marco van den Heuvel


start=$2400

basicHeader=1 

!ifdef basicHeader {
; 10 SYS7181
*=$1c01  
	!byte  $0c,$08,$0a,$00,$9e,$37,$31,$38,$31,$00,$00,$00
*=$1c0d 
	jmp start
}
*=start
	sei
	ldy $d507
	ldx $d508
	lda $d506
	pha
	and #$f0
	ora #$07  ; bottom 16k shared
	sta $d506
	lda $ff00
	pha
	lda #$3f  ; bank 0 all ram
	sta $ff00
	lda #$aa
	sta $80   ; store in real zero page
	lda #$55
	sta $5080 ; store in 'soon to become zero page' in bank 0
	lda #$7f  ; bank 1 all ram
	sta $ff00
	lda #$33
	sta $5080 ; store in 'soon to become zero page' in bank 1
	lda #$00  ; bank 0 I/O mapped in
	sta $ff00
	lda #$01
	sta $d508 ; relocate zero page bank to bank 1
	lda #$50
	sta $d507 ; relocate zero page to $50xx
	lda #$3f  ; bank 0 all ram
	sta $ff00
	lda $80
	cmp #$33  ; expecting $33
	bne failed
	lda $5080
	cmp #$55  ; expecting $55
	bne failed
	lda #$7f  ; bank 1 all ram
	sta $ff00
	lda $5080
	cmp #$aa  ; expecting $aa
	bne failed

passed:
	pla
	sta $ff00
	pla
	sta $d506
	stx $d508
	sty $d507
	ldx #0	
-	
	lda ok_msg,x
	beq +
	sta $402,x
	inx
	jmp -
+
	lda #5
	sta $d020
	lda #$00
	sta $d7ff
	jmp *

failed:
	pla
	sta $ff00
	pla
	sta $d506
	stx $d508
	sty $d507
	ldy #0	
-	
	lda error_msg,y
	beq +
	sta $402,y
	iny
	jmp -
+
	lda #10
	sta $d020
	lda #$ff
	sta $d7ff
	jmp *	

error_msg:
	!scr "test failed" 
	!byte 0
ok_msg:	
	!scr "test passed" 
	!byte 0
