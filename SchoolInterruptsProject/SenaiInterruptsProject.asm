
_interrupt:

;SenaiInterruptsProject.c,67 :: 		void interrupt(){
;SenaiInterruptsProject.c,68 :: 		if(INTCON.INT0F){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;SenaiInterruptsProject.c,69 :: 		INTCON.INT0E = 0;
	BCF         INTCON+0, 4 
;SenaiInterruptsProject.c,70 :: 		INTCON.INT0F = 0;
	BCF         INTCON+0, 1 
;SenaiInterruptsProject.c,71 :: 		next_screen++;
	INFSNZ      _next_screen+0, 1 
	INCF        _next_screen+1, 1 
;SenaiInterruptsProject.c,72 :: 		next_screen -= ((next_screen > (SCREENS_NUMBER-1)) * next_screen);
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _next_screen+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVF        _next_screen+0, 0 
	SUBLW       3
L__interrupt17:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _next_screen+0, 0 
	MOVWF       R4 
	MOVF        _next_screen+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	SUBWF       _next_screen+0, 1 
	MOVF        R1, 0 
	SUBWFB      _next_screen+1, 1 
;SenaiInterruptsProject.c,73 :: 		}
L_interrupt0:
;SenaiInterruptsProject.c,74 :: 		}
L_end_interrupt:
L__interrupt16:
	RETFIE      1
; end of _interrupt

_main:

;SenaiInterruptsProject.c,76 :: 		void main() {
;SenaiInterruptsProject.c,77 :: 		ADCON1 |= 0x0E; //adicionar no somente no picsimlab
	MOVLW       14
	IORWF       ADCON1+0, 1 
;SenaiInterruptsProject.c,78 :: 		TRISB  |= 0x01;
	BSF         TRISB+0, 0 
;SenaiInterruptsProject.c,79 :: 		TRISA  |= 0x01; //RA0 - AN0
	BSF         TRISA+0, 0 
;SenaiInterruptsProject.c,80 :: 		TRISA  &= 0xF1; //RGB led
	MOVLW       241
	ANDWF       TRISA+0, 1 
;SenaiInterruptsProject.c,81 :: 		LATA   &= 0xF8;
	MOVLW       248
	ANDWF       LATA+0, 1 
;SenaiInterruptsProject.c,82 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;SenaiInterruptsProject.c,83 :: 		init_adc();
	CALL        _init_adc+0, 0
;SenaiInterruptsProject.c,84 :: 		init_interrupts();
	CALL        _init_interrupts+0, 0
;SenaiInterruptsProject.c,85 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	NOP
;SenaiInterruptsProject.c,87 :: 		for(;;){ //main loop
L_main2:
;SenaiInterruptsProject.c,88 :: 		if(!INTCON.INT0E){ //DEBOUNCE
	BTFSC       INTCON+0, 4 
	GOTO        L_main5
;SenaiInterruptsProject.c,89 :: 		delay_ms(150);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       207
	MOVWF       R12, 0
	MOVLW       1
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;SenaiInterruptsProject.c,90 :: 		if(!PORTB.RB0){
	BTFSC       PORTB+0, 0 
	GOTO        L_main7
;SenaiInterruptsProject.c,91 :: 		INTCON.INT0F = 0;
	BCF         INTCON+0, 1 
;SenaiInterruptsProject.c,92 :: 		INTCON.INT0E = 1;
	BSF         INTCON+0, 4 
;SenaiInterruptsProject.c,93 :: 		}
L_main7:
;SenaiInterruptsProject.c,94 :: 		}
L_main5:
;SenaiInterruptsProject.c,96 :: 		if(current_screen != next_screen){
	MOVF        _current_screen+1, 0 
	XORWF       _next_screen+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVF        _next_screen+0, 0 
	XORWF       _current_screen+0, 0 
L__main19:
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;SenaiInterruptsProject.c,97 :: 		update_screen();
	CALL        _update_screen+0, 0
;SenaiInterruptsProject.c,98 :: 		}
L_main8:
;SenaiInterruptsProject.c,100 :: 		if(adc_enabled){
	MOVF        _adc_enabled+0, 0 
	IORWF       _adc_enabled+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
;SenaiInterruptsProject.c,101 :: 		adc_reading = ADC_read(ADC_CHANNEl);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc_reading+0 
	MOVF        R1, 0 
	MOVWF       _adc_reading+1 
;SenaiInterruptsProject.c,102 :: 		adc_reading_mapped = map(adc_reading);
	MOVF        R0, 0 
	MOVWF       FARG_map_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_map_value+1 
	CALL        _map+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _adc_reading_mapped+0 
	MOVF        R1, 0 
	MOVWF       _adc_reading_mapped+1 
;SenaiInterruptsProject.c,103 :: 		adc_reading = adc_reading_mapped;
	MOVF        R0, 0 
	MOVWF       _adc_reading+0 
	MOVF        R1, 0 
	MOVWF       _adc_reading+1 
;SenaiInterruptsProject.c,106 :: 		convert_int_to_str(adc_reading,adc_txt);
	MOVF        R0, 0 
	MOVWF       FARG_convert_int_to_str_fromInt+0 
	MOVF        R1, 0 
	MOVWF       FARG_convert_int_to_str_fromInt+1 
	MOVLW       _adc_txt+0
	MOVWF       FARG_convert_int_to_str_toStr+0 
	MOVLW       hi_addr(_adc_txt+0)
	MOVWF       FARG_convert_int_to_str_toStr+1 
	CALL        _convert_int_to_str+0, 0
;SenaiInterruptsProject.c,107 :: 		lcd_out(2,10,adc_txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _adc_txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_adc_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SenaiInterruptsProject.c,108 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
	NOP
	NOP
;SenaiInterruptsProject.c,109 :: 		}
L_main9:
;SenaiInterruptsProject.c,111 :: 		}
	GOTO        L_main2
;SenaiInterruptsProject.c,113 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_lcd:

;SenaiInterruptsProject.c,115 :: 		void init_lcd(){
;SenaiInterruptsProject.c,117 :: 		TRISE &= 0xFD;
	MOVLW       253
	ANDWF       TRISE+0, 1 
;SenaiInterruptsProject.c,118 :: 		LATE  &= 0xFD;
	MOVLW       253
	ANDWF       LATE+0, 1 
;SenaiInterruptsProject.c,120 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;SenaiInterruptsProject.c,121 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_init_lcd11:
	DECFSZ      R13, 1, 1
	BRA         L_init_lcd11
	DECFSZ      R12, 1, 1
	BRA         L_init_lcd11
	NOP
;SenaiInterruptsProject.c,122 :: 		lcd_cmd(_LCD_TURN_ON);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SenaiInterruptsProject.c,123 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SenaiInterruptsProject.c,124 :: 		lcd_out(1,1,screens[0].message1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _screens+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_screens+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SenaiInterruptsProject.c,126 :: 		}
L_end_init_lcd:
	RETURN      0
; end of _init_lcd

_init_interrupts:

;SenaiInterruptsProject.c,128 :: 		void init_interrupts(){
;SenaiInterruptsProject.c,129 :: 		INTCON.INT0IF    = 0; //clear INT0 flag
	BCF         INTCON+0, 1 
;SenaiInterruptsProject.c,130 :: 		INTCON.INT0IE    = 1; //INT0 interrupt enable
	BSF         INTCON+0, 4 
;SenaiInterruptsProject.c,131 :: 		INTCON2.INTEDG0  = 0; //INT0 on falling edge
	BCF         INTCON2+0, 6 
;SenaiInterruptsProject.c,132 :: 		INTCON.GIE       = 1; //init global interrupts
	BSF         INTCON+0, 7 
;SenaiInterruptsProject.c,134 :: 		}
L_end_init_interrupts:
	RETURN      0
; end of _init_interrupts

_init_adc:

;SenaiInterruptsProject.c,136 :: 		void init_adc(){
;SenaiInterruptsProject.c,137 :: 		ADC_init();
	CALL        _ADC_Init+0, 0
;SenaiInterruptsProject.c,139 :: 		}
L_end_init_adc:
	RETURN      0
; end of _init_adc

_convert_int_to_str:

;SenaiInterruptsProject.c,141 :: 		void convert_int_to_str(int fromInt, char *toStr){
;SenaiInterruptsProject.c,142 :: 		int index = 3;
	MOVLW       3
	MOVWF       convert_int_to_str_index_L0+0 
	MOVLW       0
	MOVWF       convert_int_to_str_index_L0+1 
;SenaiInterruptsProject.c,143 :: 		int num   = fromInt;
	MOVF        FARG_convert_int_to_str_fromInt+0, 0 
	MOVWF       convert_int_to_str_num_L0+0 
	MOVF        FARG_convert_int_to_str_fromInt+1, 0 
	MOVWF       convert_int_to_str_num_L0+1 
;SenaiInterruptsProject.c,145 :: 		for(index  = 3; index >= 0; index--){
	MOVLW       3
	MOVWF       convert_int_to_str_index_L0+0 
	MOVLW       0
	MOVWF       convert_int_to_str_index_L0+1 
L_convert_int_to_str12:
	MOVLW       128
	XORWF       convert_int_to_str_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__convert_int_to_str24
	MOVLW       0
	SUBWF       convert_int_to_str_index_L0+0, 0 
L__convert_int_to_str24:
	BTFSS       STATUS+0, 0 
	GOTO        L_convert_int_to_str13
;SenaiInterruptsProject.c,146 :: 		toStr[index] = (char)(num % 10 + '0');
	MOVF        convert_int_to_str_index_L0+0, 0 
	ADDWF       FARG_convert_int_to_str_toStr+0, 0 
	MOVWF       FLOC__convert_int_to_str+0 
	MOVF        convert_int_to_str_index_L0+1, 0 
	ADDWFC      FARG_convert_int_to_str_toStr+1, 0 
	MOVWF       FLOC__convert_int_to_str+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_int_to_str_num_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_int_to_str_num_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__convert_int_to_str+0, FSR1L+0
	MOVFF       FLOC__convert_int_to_str+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SenaiInterruptsProject.c,147 :: 		num /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        convert_int_to_str_num_L0+0, 0 
	MOVWF       R0 
	MOVF        convert_int_to_str_num_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       convert_int_to_str_num_L0+0 
	MOVF        R1, 0 
	MOVWF       convert_int_to_str_num_L0+1 
;SenaiInterruptsProject.c,145 :: 		for(index  = 3; index >= 0; index--){
	MOVLW       1
	SUBWF       convert_int_to_str_index_L0+0, 1 
	MOVLW       0
	SUBWFB      convert_int_to_str_index_L0+1, 1 
;SenaiInterruptsProject.c,148 :: 		}
	GOTO        L_convert_int_to_str12
L_convert_int_to_str13:
;SenaiInterruptsProject.c,151 :: 		}
L_end_convert_int_to_str:
	RETURN      0
; end of _convert_int_to_str

_update_screen:

;SenaiInterruptsProject.c,153 :: 		void update_screen(){
;SenaiInterruptsProject.c,154 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SenaiInterruptsProject.c,155 :: 		current_screen = next_screen;
	MOVF        _next_screen+0, 0 
	MOVWF       _current_screen+0 
	MOVF        _next_screen+1, 0 
	MOVWF       _current_screen+1 
;SenaiInterruptsProject.c,157 :: 		lcd_out(1,1,screens[current_screen].message1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       36
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _next_screen+0, 0 
	MOVWF       R4 
	MOVF        _next_screen+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _screens+0
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_screens+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SenaiInterruptsProject.c,158 :: 		lcd_out(2,1,screens[current_screen].message2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       36
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _current_screen+0, 0 
	MOVWF       R4 
	MOVF        _current_screen+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _screens+0
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_screens+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       16
	ADDWF       FARG_Lcd_Out_text+0, 1 
	MOVLW       0
	ADDWFC      FARG_Lcd_Out_text+1, 1 
	CALL        _Lcd_Out+0, 0
;SenaiInterruptsProject.c,159 :: 		LATA &= 0x01;
	MOVLW       1
	ANDWF       LATA+0, 1 
;SenaiInterruptsProject.c,160 :: 		LATA |= screens[current_screen].led_color;
	MOVLW       36
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _current_screen+0, 0 
	MOVWF       R4 
	MOVF        _current_screen+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _screens+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_screens+0)
	ADDWFC      R1, 1 
	MOVLW       32
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	IORWF       LATA+0, 1 
;SenaiInterruptsProject.c,161 :: 		adc_enabled = screens[current_screen].ADC;
	MOVLW       34
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       _adc_enabled+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       _adc_enabled+1 
;SenaiInterruptsProject.c,163 :: 		}
L_end_update_screen:
	RETURN      0
; end of _update_screen

_map:

;SenaiInterruptsProject.c,165 :: 		float map(int value){
;SenaiInterruptsProject.c,166 :: 		return (float)value /1023 * 500;
	MOVF        FARG_map_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_map_value+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
;SenaiInterruptsProject.c,167 :: 		}
L_end_map:
	RETURN      0
; end of _map
