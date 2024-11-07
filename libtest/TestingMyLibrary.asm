
_main:

;TestingMyLibrary.c,1 :: 		void main() {
;TestingMyLibrary.c,2 :: 		char *mystr[4] = "0000";
	MOVLW       ?lstr1_TestingMyLibrary+0
	MOVWF       main_mystr_L0+0 
	MOVLW       hi_addr(?lstr1_TestingMyLibrary+0)
	MOVWF       main_mystr_L0+1 
	CLRF        main_mystr_L0+2 
	CLRF        main_mystr_L0+3 
	CLRF        main_mystr_L0+4 
	CLRF        main_mystr_L0+5 
	CLRF        main_mystr_L0+6 
	CLRF        main_mystr_L0+7 
;TestingMyLibrary.c,3 :: 		float _previous_read = 0;
	CLRF        main__previous_read_L0+0 
	CLRF        main__previous_read_L0+1 
	CLRF        main__previous_read_L0+2 
	CLRF        main__previous_read_L0+3 
	CLRF        main_value_L0+0 
	CLRF        main_value_L0+1 
	CLRF        main_value_L0+2 
	CLRF        main_value_L0+3 
;TestingMyLibrary.c,6 :: 		ADCON1 = 14;
	MOVLW       14
	MOVWF       ADCON1+0 
;TestingMyLibrary.c,8 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;TestingMyLibrary.c,11 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;TestingMyLibrary.c,13 :: 		for(;;){
L_main0:
;TestingMyLibrary.c,14 :: 		value = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       main_value_L0+0 
	MOVF        R1, 0 
	MOVWF       main_value_L0+1 
	MOVF        R2, 0 
	MOVWF       main_value_L0+2 
	MOVF        R3, 0 
	MOVWF       main_value_L0+3 
;TestingMyLibrary.c,15 :: 		if(_previous_read != value){
	MOVF        main__previous_read_L0+0, 0 
	MOVWF       R4 
	MOVF        main__previous_read_L0+1, 0 
	MOVWF       R5 
	MOVF        main__previous_read_L0+2, 0 
	MOVWF       R6 
	MOVF        main__previous_read_L0+3, 0 
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;TestingMyLibrary.c,16 :: 		_previous_read = value;
	MOVF        main_value_L0+0, 0 
	MOVWF       main__previous_read_L0+0 
	MOVF        main_value_L0+1, 0 
	MOVWF       main__previous_read_L0+1 
	MOVF        main_value_L0+2, 0 
	MOVWF       main__previous_read_L0+2 
	MOVF        main_value_L0+3, 0 
	MOVWF       main__previous_read_L0+3 
;TestingMyLibrary.c,17 :: 		FloatToStr(value,*mystr);
	MOVF        main_value_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_value_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_value_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_value_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVF        main_mystr_L0+0, 0 
	MOVWF       FARG_FloatToStr_str+0 
	MOVF        main_mystr_L0+1, 0 
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;TestingMyLibrary.c,18 :: 		lcd_print(1,1,*mystr);
	MOVLW       1
	MOVWF       FARG_lcd_print_row+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_row+1 
	MOVLW       1
	MOVWF       FARG_lcd_print_line+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_line+1 
	MOVF        main_mystr_L0+0, 0 
	MOVWF       FARG_lcd_print_text+0 
	MOVF        main_mystr_L0+1, 0 
	MOVWF       FARG_lcd_print_text+1 
	CALL        _lcd_print+0, 0
;TestingMyLibrary.c,20 :: 		}
L_main3:
;TestingMyLibrary.c,23 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
;TestingMyLibrary.c,24 :: 		}
	GOTO        L_main0
;TestingMyLibrary.c,28 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
