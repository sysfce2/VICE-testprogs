;
; Marco van den Heuvel, 27.01.2016
;
; Temporary stubs till all functions are implemented
;
;

        .export  _sampler_2bit_hit1_input_init, _sampler_2bit_hit1_input
        .export  _sampler_4bit_hit1_input_init, _sampler_4bit_hit1_input
        .export  _sampler_2bit_hit2_input_init, _sampler_2bit_hit2_input
        .export  _sampler_4bit_hit2_input_init, _sampler_4bit_hit2_input
        .export  _sampler_2bit_kingsoft1_input_init, _sampler_2bit_kingsoft1_input
        .export  _sampler_4bit_kingsoft1_input_init, _sampler_4bit_kingsoft1_input
        .export  _sampler_2bit_kingsoft2_input_init, _sampler_2bit_kingsoft2_input
        .export  _sampler_4bit_kingsoft2_input_init, _sampler_4bit_kingsoft2_input
        .export  _sampler_2bit_starbyte1_input_init, _sampler_2bit_starbyte1_input
        .export  _sampler_4bit_starbyte1_input_init, _sampler_4bit_starbyte1_input
        .export  _sampler_2bit_starbyte2_input_init, _sampler_2bit_starbyte2_input
        .export  _sampler_4bit_starbyte2_input_init, _sampler_4bit_starbyte2_input
        .export  _sampler_2bit_cga1_input_init, _sampler_2bit_cga1_input
        .export  _sampler_4bit_cga1_input_init, _sampler_4bit_cga1_input
        .export  _sampler_2bit_cga2_input_init, _sampler_2bit_cga2_input
        .export  _sampler_4bit_cga2_input_init, _sampler_4bit_cga2_input
        .export  _sampler_2bit_pet1_input_init, _sampler_2bit_pet1_input
        .export  _sampler_4bit_pet1_input_init, _sampler_4bit_pet1_input
        .export  _sampler_2bit_pet2_input_init, _sampler_2bit_pet2_input
        .export  _sampler_4bit_pet2_input_init, _sampler_4bit_pet2_input
        .export  _sampler_2bit_oem_input_init, _sampler_2bit_oem_input
        .export  _sampler_4bit_oem_input_init, _sampler_4bit_oem_input
        .export  _sampler_2bit_hummer_input_init, _sampler_2bit_hummer_input
        .export  _sampler_4bit_hummer_input_init, _sampler_4bit_hummer_input
        .export  _sampler_4bit_userport_input_init, _sampler_4bit_userport_input
        .export  _sampler_8bss_left_input_init, _sampler_8bss_left_input
        .export  _sampler_8bss_right_input_init, _sampler_8bss_right_input
        .export  _sampler_2bit_joy1_input_init, _sampler_2bit_joy1_input
        .export  _sampler_4bit_joy1_input_init, _sampler_4bit_joy1_input
        .export  _sampler_2bit_joy2_input_init, _sampler_2bit_joy2_input
        .export  _sampler_4bit_joy2_input_init, _sampler_4bit_joy2_input
        .export  _sampler_2bit_sidcart_input_init, _sampler_2bit_sidcart_input
        .export  _sampler_4bit_sidcart_input_init, _sampler_4bit_sidcart_input
        .export  _sfx_input_init, _sfx_input
        .export  _daisy_input_init, _daisy_input
        .export  _digiblaster_input_init, _digiblaster_input
        .export  _software_input_init, _software_input

        .export  _sid_output_init, _sid_output
        .export  _ted_output_init, _ted_output
        .export  _vic_output_init, _vic_output
        .export  _sfx_output_init, _sfx_output
        .export  _digimax_cart_output_init, _digimax_cart_output
        .export  _userport_digimax_output_init, _userport_digimax_output
        .export  _userport_dac_output_init, _userport_dac_output
        .export  _digiblaster_output_init, _digiblaster_output

_sampler_2bit_hit1_input_init:
_sampler_2bit_hit1_input:
_sampler_4bit_hit1_input_init:
_sampler_4bit_hit1_input:
_sampler_2bit_hit2_input_init:
_sampler_2bit_hit2_input:
_sampler_4bit_hit2_input_init:
_sampler_4bit_hit2_input:
_sampler_2bit_kingsoft1_input_init:
_sampler_2bit_kingsoft1_input:
_sampler_4bit_kingsoft1_input_init:
_sampler_4bit_kingsoft1_input:
_sampler_2bit_kingsoft2_input_init:
_sampler_2bit_kingsoft2_input:
_sampler_4bit_kingsoft2_input_init:
_sampler_4bit_kingsoft2_input:
_sampler_2bit_starbyte1_input_init:
_sampler_2bit_starbyte1_input:
_sampler_4bit_starbyte1_input_init:
_sampler_4bit_starbyte1_input:
_sampler_2bit_starbyte2_input_init:
_sampler_2bit_starbyte2_input:
_sampler_4bit_starbyte2_input_init:
_sampler_4bit_starbyte2_input:
_sampler_2bit_cga1_input_init:
_sampler_2bit_cga1_input:
_sampler_4bit_cga1_input_init:
_sampler_4bit_cga1_input:
_sampler_2bit_cga2_input_init:
_sampler_2bit_cga2_input:
_sampler_4bit_cga2_input_init:
_sampler_4bit_cga2_input:
_sampler_2bit_pet1_input_init:
_sampler_2bit_pet1_input:
_sampler_4bit_pet1_input_init:
_sampler_4bit_pet1_input:
_sampler_2bit_pet2_input_init:
_sampler_2bit_pet2_input:
_sampler_4bit_pet2_input_init:
_sampler_4bit_pet2_input:
_sampler_2bit_oem_input_init:
_sampler_2bit_oem_input:
_sampler_4bit_oem_input_init:
_sampler_4bit_oem_input:
_sampler_2bit_hummer_input_init:
_sampler_2bit_hummer_input:
_sampler_4bit_hummer_input_init:
_sampler_4bit_hummer_input:
_sampler_4bit_userport_input_init:
_sampler_4bit_userport_input:
_sampler_8bss_left_input_init:
_sampler_8bss_left_input:
_sampler_8bss_right_input_init:
_sampler_8bss_right_input:
_sampler_2bit_joy1_input_init:
_sampler_2bit_joy1_input:
_sampler_4bit_joy1_input_init:
_sampler_4bit_joy1_input:
_sampler_2bit_joy2_input_init:
_sampler_2bit_joy2_input:
_sampler_4bit_joy2_input_init:
_sampler_4bit_joy2_input:
_sampler_2bit_sidcart_input_init:
_sampler_2bit_sidcart_input:
_sampler_4bit_sidcart_input_init:
_sampler_4bit_sidcart_input:
_sfx_input_init:
_sfx_input:
_daisy_input_init:
_daisy_input:
_digiblaster_input_init:
_digiblaster_input:
_software_input_init:
_software_input:

_sid_output_init:
_sid_output:
_ted_output_init:
_ted_output:
_vic_output_init:
_vic_output:
_sfx_output_init:
_sfx_output:
_digimax_cart_output_init:
_digimax_cart_output:
_userport_digimax_output_init:
_userport_digimax_output:
_userport_dac_output_init:
_userport_dac_output:
_digiblaster_output_init:
_digiblaster_output: