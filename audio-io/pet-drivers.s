;
; Marco van den Heuvel, 28.01.2016
;
; void __fastcall__ set_sid_addr(unsigned addr);
;
; void __fastcall__ sampler_2bit_hummer_input_init(void);
; unsigned char __fastcall__ sampler_2bit_hummer_input(void);
; void __fastcall__ sampler_4bit_hummer_input_init(void);
; unsigned char __fastcall__ sampler_4bit_hummer_input(void);
; void __fastcall__ sampler_2bit_spt_input_init(void);
; unsigned char __fastcall__ sampler_2bit_spt_input(void);
; void __fastcall__ sampler_4bit_spt_input_init(void);
; unsigned char __fastcall__ sampler_4bit_spt_input(void);
; void __fastcall__ sampler_2bit_pet1_input_init(void);
; unsigned char __fastcall__ sampler_2bit_pet1_input(void);
; void __fastcall__ sampler_4bit_pet1_input_init(void);
; unsigned char __fastcall__ sampler_4bit_pet1_input(void);
; void __fastcall__ sampler_2bit_syn1_input_init(void);
; unsigned char __fastcall__ sampler_2bit_syn1_input(void);
; void __fastcall__ sampler_4bit_syn1_input_init(void);
; unsigned char __fastcall__ sampler_4bit_syn1_input(void);
; void __fastcall__ sampler_2bit_syn2_input_init(void);
; unsigned char __fastcall__ sampler_2bit_syn2_input(void);
; void __fastcall__ sampler_4bit_syn2_input_init(void);
; unsigned char __fastcall__ sampler_4bit_syn2_input(void);
; void __fastcall__ sampler_2bit_syn3_input_init(void);
; unsigned char __fastcall__ sampler_2bit_syn3_input(void);
; void __fastcall__ sampler_4bit_syn3_input_init(void);
; unsigned char __fastcall__ sampler_4bit_syn3_input(void);
; void __fastcall__ sampler_2bit_woj1_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj1_input(void);
; void __fastcall__ sampler_4bit_woj1_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj1_input(void);
; void __fastcall__ sampler_2bit_woj2_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj2_input(void);
; void __fastcall__ sampler_4bit_woj2_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj2_input(void);
; void __fastcall__ sampler_2bit_woj3_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj3_input(void);
; void __fastcall__ sampler_4bit_woj3_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj3_input(void);
; void __fastcall__ sampler_2bit_woj4_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj4_input(void);
; void __fastcall__ sampler_4bit_woj4_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj4_input(void);
; void __fastcall__ sampler_2bit_woj5_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj5_input(void);
; void __fastcall__ sampler_4bit_woj5_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj5_input(void);
; void __fastcall__ sampler_2bit_woj6_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj6_input(void);
; void __fastcall__ sampler_4bit_woj6_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj6_input(void);
; void __fastcall__ sampler_2bit_woj7_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj7_input(void);
; void __fastcall__ sampler_4bit_woj7_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj7_input(void);
; void __fastcall__ sampler_2bit_woj8_input_init(void);
; unsigned char __fastcall__ sampler_2bit_woj8_input(void);
; void __fastcall__ sampler_4bit_woj8_input_init(void);
; unsigned char __fastcall__ sampler_4bit_woj8_input(void);
; void __fastcall__ sampler_2bit_pet2_input_init(void);
; unsigned char __fastcall__ sampler_2bit_pet2_input(void);
; void __fastcall__ sampler_4bit_pet2_input_init(void);
; unsigned char __fastcall__ sampler_4bit_pet2_input(void);
; void __fastcall__ sampler_2bit_cga1_input_init(void);
; unsigned char __fastcall__ sampler_2bit_cga1_input(void);
; void __fastcall__ sampler_4bit_cga1_input_init(void);
; unsigned char __fastcall__ sampler_4bit_cga1_input(void);
; void __fastcall__ sampler_2bit_cga2_input_init(void);
; unsigned char __fastcall__ sampler_2bit_cga2_input(void);
; void __fastcall__ sampler_4bit_cga2_input_init(void);
; unsigned char __fastcall__ sampler_4bit_cga2_input(void);
;
; void __fastcall__ sid_output_init(void);
; void __fastcall__ sid_output(unsigned char sample);
; void __fastcall__ userport_dac_output_init(void);
; void __fastcall__ userport_dac_output(unsigned char sample);
;
; void __fastcall__ show_sample(unsigned char sample);
;

        .export  _sampler_2bit_hummer_input_init, _sampler_2bit_hummer_input
        .export  _sampler_4bit_hummer_input_init, _sampler_4bit_hummer_input
        .export  _sampler_2bit_spt_input_init, _sampler_2bit_spt_input
        .export  _sampler_4bit_spt_input_init, _sampler_4bit_spt_input
        .export  _sampler_2bit_pet1_input_init, _sampler_2bit_pet1_input
        .export  _sampler_4bit_pet1_input_init, _sampler_4bit_pet1_input
        .export  _sampler_2bit_syn1_input_init, _sampler_2bit_syn1_input
        .export  _sampler_4bit_syn1_input_init, _sampler_4bit_syn1_input
        .export  _sampler_2bit_syn2_input_init, _sampler_2bit_syn2_input
        .export  _sampler_4bit_syn2_input_init, _sampler_4bit_syn2_input
        .export  _sampler_2bit_syn3_input_init, _sampler_2bit_syn3_input
        .export  _sampler_4bit_syn3_input_init, _sampler_4bit_syn3_input
        .export  _sampler_2bit_woj1_input_init, _sampler_2bit_woj1_input
        .export  _sampler_4bit_woj1_input_init, _sampler_4bit_woj1_input
        .export  _sampler_2bit_woj2_input_init, _sampler_2bit_woj2_input
        .export  _sampler_4bit_woj2_input_init, _sampler_4bit_woj2_input
        .export  _sampler_2bit_woj3_input_init, _sampler_2bit_woj3_input
        .export  _sampler_4bit_woj3_input_init, _sampler_4bit_woj3_input
        .export  _sampler_2bit_woj4_input_init, _sampler_2bit_woj4_input
        .export  _sampler_4bit_woj4_input_init, _sampler_4bit_woj4_input
        .export  _sampler_2bit_woj5_input_init, _sampler_2bit_woj5_input
        .export  _sampler_4bit_woj5_input_init, _sampler_4bit_woj5_input
        .export  _sampler_2bit_woj6_input_init, _sampler_2bit_woj6_input
        .export  _sampler_4bit_woj6_input_init, _sampler_4bit_woj6_input
        .export  _sampler_2bit_woj7_input_init, _sampler_2bit_woj7_input
        .export  _sampler_4bit_woj7_input_init, _sampler_4bit_woj7_input
        .export  _sampler_2bit_woj8_input_init, _sampler_2bit_woj8_input
        .export  _sampler_4bit_woj8_input_init, _sampler_4bit_woj8_input
        .export  _sampler_2bit_pet2_input_init, _sampler_2bit_pet2_input
        .export  _sampler_4bit_pet2_input_init, _sampler_4bit_pet2_input
        .export  _sampler_2bit_cga1_input_init, _sampler_2bit_cga1_input
        .export  _sampler_4bit_cga1_input_init, _sampler_4bit_cga1_input
        .export  _sampler_2bit_cga2_input_init, _sampler_2bit_cga2_input
        .export  _sampler_4bit_cga2_input_init, _sampler_4bit_cga2_input

        .export  _sid_output_init, _sid_output
        .export  _userport_dac_output_init, _userport_dac_output

        .export  _set_sid_addr

        .export  _show_sample

        .importzp   tmp1, tmp2

_sampler_2bit_hummer_input_init:
_sampler_4bit_hummer_input_init:
_sampler_2bit_spt_input_init:
_sampler_4bit_spt_input_init:
_sampler_2bit_pet1_input_init:
_sampler_4bit_pet1_input_init:
_sampler_2bit_pet2_input_init:
_sampler_4bit_pet2_input_init:
        ldx     #$00
        stx     $e843
        rts

e843_e0:
        ldx     #$E0
        stx     $e843
        rts

_sampler_2bit_woj1_input_init:
_sampler_4bit_woj1_input_init:
        jsr     e843_e0
        ldx     #$00
        stx     $e841
        rts

_sampler_2bit_woj2_input_init:
_sampler_4bit_woj2_input_init:
        jsr     e843_e0
        ldx     #$20
        stx     $e841
        rts

_sampler_2bit_woj3_input_init:
_sampler_4bit_woj3_input_init:
        jsr     e843_e0
        ldx     #$40
        stx     $e841
        rts

_sampler_2bit_syn3_input_init:
_sampler_4bit_syn3_input_init:
_sampler_2bit_woj4_input_init:
_sampler_4bit_woj4_input_init:
        jsr     e843_e0
        ldx     #$60
        stx     $e841
        rts

_sampler_2bit_woj5_input_init:
_sampler_4bit_woj5_input_init:
        jsr     e843_e0
        ldx     #$80
        stx     $e841
        rts

_sampler_2bit_syn2_input_init:
_sampler_4bit_syn2_input_init:
_sampler_2bit_woj6_input_init:
_sampler_4bit_woj6_input_init:
        jsr     e843_e0
        ldx     #$A0
        stx     $e841
        rts

_sampler_2bit_syn1_input_init:
_sampler_4bit_syn1_input_init:
_sampler_2bit_woj7_input_init:
_sampler_4bit_woj7_input_init:
        jsr     e843_e0
        ldx     #$C0
        stx     $e841
        rts

_sampler_2bit_woj8_input_init:
_sampler_4bit_woj8_input_init:
        jsr     e843_e0
        ldx     #$E0
        stx     $e841
        rts

_sampler_2bit_cga1_input_init:
_sampler_4bit_cga1_input_init:
        ldx     #$80
        stx     $e843
storex_e841:
        stx     $e841
        rts

_sampler_2bit_cga2_input_init:
_sampler_4bit_cga2_input_init:
        ldx     #$80
        stx     $e843
        ldx     #$00
        jmp     storex_e841

_sampler_2bit_pet2_input:
        lda     $e841
        and     #$30
        asl
        asl
        rts

_sampler_4bit_pet2_input:
        lda     $e841
        and     #$f0
        rts

_sampler_2bit_hummer_input:
_sampler_2bit_pet1_input:
_sampler_2bit_cga1_input:
_sampler_2bit_cga2_input:
_sampler_2bit_syn1_input:
_sampler_2bit_syn2_input:
_sampler_2bit_syn3_input:
_sampler_2bit_woj1_input:
_sampler_2bit_woj2_input:
_sampler_2bit_woj3_input:
_sampler_2bit_woj4_input:
_sampler_2bit_woj5_input:
_sampler_2bit_woj6_input:
_sampler_2bit_woj7_input:
_sampler_2bit_woj8_input:
        lda     $e841
        asl
        asl
do_asl4:
        asl
        asl
        asl
        asl
        rts

_sampler_2bit_spt_input:
        lda     $e841
        and     #$0C
        jmp     do_asl4

_sampler_4bit_hummer_input:
_sampler_4bit_pet1_input:
_sampler_4bit_cga1_input:
_sampler_4bit_cga2_input:
_sampler_4bit_syn1_input:
_sampler_4bit_syn2_input:
_sampler_4bit_syn3_input:
_sampler_4bit_woj1_input:
_sampler_4bit_woj2_input:
_sampler_4bit_woj3_input:
_sampler_4bit_woj4_input:
_sampler_4bit_woj5_input:
_sampler_4bit_woj6_input:
_sampler_4bit_woj7_input:
_sampler_4bit_woj8_input:
        lda     $e841
        jmp     do_asl4

_sampler_4bit_spt_input:
        lda     $e841
        sta     tmp1
        and     #$0C
        lsr
        lsr
        sta     tmp2
        lda     tmp1
        and     #$03
        asl
        asl
        ora     tmp2
        jmp     do_asl4

_set_sid_addr:
        sta     store_sid+1
        stx     store_sid+2
        rts

store_sid:
        sta     $e900,x
        rts

_sid_output_init:
        lda     #$00
        tax
@l:
        jsr     store_sid
        inx
        cpx     #$20
        bne     @l
        lda     #$ff
        ldx     #$06
        jsr     store_sid
        ldx     #$0d
        jsr     store_sid
        ldx     #$14
        jsr     store_sid
        lda     #$49
        ldx     #$04
        jsr     store_sid
        ldx     #$0b
        jsr     store_sid
        ldx     #$12
        jmp     store_sid

_sid_output:
        lsr
        lsr
        lsr
        lsr
        ldx     #$18
        jmp     store_sid

_userport_dac_output_init:
        ldx     #$ff
        stx     $e843
        rts

_userport_dac_output:
        sta     $e841
        rts

_show_sample:
        sta     $8020
        rts
