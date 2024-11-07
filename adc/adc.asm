
_main:

;adc.c,1 :: 		void main() {
;adc.c,5 :: 		float f_result = 0;
;adc.c,11 :: 		ADCON0.CHS3 = 0;
	BCF         ADCON0+0, 5 
;adc.c,12 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;adc.c,13 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;adc.c,14 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;adc.c,17 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;adc.c,19 :: 		ADCON1 = 0xE; //vdd and vss as reference, an0 is analogic
	MOVLW       14
	MOVWF       ADCON1+0 
;adc.c,21 :: 		ADCON2.ADFM = 1; //result if right justified
	BSF         ADCON2+0, 7 
;adc.c,23 :: 		TRISA |= 1;//RA0 will be input
	BSF         TRISA+0, 0 
;adc.c,26 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 1 
;adc.c,29 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;adc.c,30 :: 		lcd_command(0x0C);
	MOVLW       12
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;adc.c,32 :: 		for(;;){
L_main0:
;adc.c,34 :: 		while(ADCON0.GO == 1){
L_main3:
	BTFSS       ADCON0+0, 1 
	GOTO        L_main4
;adc.c,36 :: 		}
	GOTO        L_main3
L_main4:
;adc.c,38 :: 		low_result =  ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       main_low_result_L0+0 
	MOVLW       0
	MOVWF       main_low_result_L0+1 
;adc.c,39 :: 		high_result = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       main_high_result_L0+0 
	MOVLW       0
	MOVWF       main_high_result_L0+1 
;adc.c,40 :: 		final_result =  (high_result << 8) | low_result;
	MOVF        main_high_result_L0+0, 0 
	MOVWF       main_final_result_L0+1 
	CLRF        main_final_result_L0+0 
	MOVF        main_low_result_L0+0, 0 
	IORWF       main_final_result_L0+0, 1 
	MOVF        main_low_result_L0+1, 0 
	IORWF       main_final_result_L0+1, 1 
;adc.c,42 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;adc.c,43 :: 		f_result =  (final_result/1023.0) * 5.0;
	MOVF        main_final_result_L0+0, 0 
	MOVWF       R0 
	MOVF        main_final_result_L0+1, 0 
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
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
;adc.c,44 :: 		txt_result[0] = '0';
	MOVLW       48
	MOVWF       main_txt_result_L0+0 
;adc.c,45 :: 		txt_result[1] = '0';
	MOVLW       48
	MOVWF       main_txt_result_L0+1 
;adc.c,46 :: 		txt_result[2] = '0';
	MOVLW       48
	MOVWF       main_txt_result_L0+2 
;adc.c,47 :: 		txt_result[3] = '0';
	MOVLW       48
	MOVWF       main_txt_result_L0+3 
;adc.c,48 :: 		txt_result[4] = '0';
	MOVLW       48
	MOVWF       main_txt_result_L0+4 
;adc.c,49 :: 		FloatToStr(f_result,txt_result);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_txt_result_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_txt_result_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;adc.c,51 :: 		txt_result[4] = 0;
	CLRF        main_txt_result_L0+4 
;adc.c,52 :: 		lcd_print(1,1,txt_result);
	MOVLW       1
	MOVWF       FARG_lcd_print_row+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_row+1 
	MOVLW       1
	MOVWF       FARG_lcd_print_line+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_line+1 
	MOVLW       main_txt_result_L0+0
	MOVWF       FARG_lcd_print_text+0 
	MOVLW       hi_addr(main_txt_result_L0+0)
	MOVWF       FARG_lcd_print_text+1 
	CALL        _lcd_print+0, 0
;adc.c,54 :: 		ADCON0.GO = 1;
	BSF         ADCON0+0, 1 
;adc.c,55 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
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
;adc.c,59 :: 		}
	GOTO        L_main0
;adc.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
