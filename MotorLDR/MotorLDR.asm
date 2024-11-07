
_main:

;MotorLDR.c,23 :: 		void main() {
;MotorLDR.c,27 :: 		TRISE  &= 253;
	MOVLW       253
	ANDWF       TRISE+0, 1 
;MotorLDR.c,28 :: 		LATE   &= 253; //RW  = 0
	MOVLW       253
	ANDWF       LATE+0, 1 
;MotorLDR.c,29 :: 		LATA   &= 253; //relay off
	MOVLW       253
	ANDWF       LATA+0, 1 
;MotorLDR.c,30 :: 		TRISA  |= 1;   //RA0 = LDR
	BSF         TRISA+0, 0 
;MotorLDR.c,31 :: 		TRISA  &= 253;
	MOVLW       253
	ANDWF       TRISA+0, 1 
;MotorLDR.c,33 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
;MotorLDR.c,34 :: 		ADC_init();
	CALL        _ADC_Init+0, 0
;MotorLDR.c,35 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;MotorLDR.c,37 :: 		for(;;){
L_main1:
;MotorLDR.c,38 :: 		value = map(ADC_Read(0));
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_map_value+0 
	MOVF        R1, 0 
	MOVWF       FARG_map_value+1 
	CALL        _map+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _value+0 
	MOVF        R1, 0 
	MOVWF       _value+1 
;MotorLDR.c,40 :: 		ConIntToStr(value,txtValue);
	MOVF        R0, 0 
	MOVWF       FARG_ConIntToStr_FromInt+0 
	MOVF        R1, 0 
	MOVWF       FARG_ConIntToStr_FromInt+1 
	MOVLW       _txtValue+0
	MOVWF       FARG_ConIntToStr_ToStr+0 
	MOVLW       hi_addr(_txtValue+0)
	MOVWF       FARG_ConIntToStr_ToStr+1 
	CALL        _ConIntToStr+0, 0
;MotorLDR.c,42 :: 		lcd_out(2,1,txtValue);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txtValue+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txtValue+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MotorLDR.c,43 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
;MotorLDR.c,46 :: 		if(value >= 150){
	MOVLW       128
	XORWF       _value+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main12
	MOVLW       150
	SUBWF       _value+0, 0 
L__main12:
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;MotorLDR.c,47 :: 		lcd_out(1,1,"Motor Ligado");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_MotorLDR+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_MotorLDR+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MotorLDR.c,48 :: 		LATA |= 2;
	BSF         LATA+0, 1 
;MotorLDR.c,49 :: 		}else{
	GOTO        L_main6
L_main5:
;MotorLDR.c,50 :: 		lcd_out(1,1,"Motor Desligado");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_MotorLDR+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_MotorLDR+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MotorLDR.c,51 :: 		LATA &= 253;
	MOVLW       253
	ANDWF       LATA+0, 1 
;MotorLDR.c,52 :: 		}
L_main6:
;MotorLDR.c,54 :: 		delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;MotorLDR.c,56 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorLDR.c,57 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorLDR.c,59 :: 		}
	GOTO        L_main1
;MotorLDR.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ConIntToStr:

;MotorLDR.c,63 :: 		void ConIntToStr(int FromInt, char *ToStr){
;MotorLDR.c,64 :: 		int index = 3;
	MOVLW       3
	MOVWF       ConIntToStr_index_L0+0 
	MOVLW       0
	MOVWF       ConIntToStr_index_L0+1 
;MotorLDR.c,65 :: 		int num = FromInt;
	MOVF        FARG_ConIntToStr_FromInt+0, 0 
	MOVWF       ConIntToStr_num_L0+0 
	MOVF        FARG_ConIntToStr_FromInt+1, 0 
	MOVWF       ConIntToStr_num_L0+1 
;MotorLDR.c,67 :: 		for(index = 3; index > -1 ; index--){
	MOVLW       3
	MOVWF       ConIntToStr_index_L0+0 
	MOVLW       0
	MOVWF       ConIntToStr_index_L0+1 
L_ConIntToStr8:
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       ConIntToStr_index_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ConIntToStr14
	MOVF        ConIntToStr_index_L0+0, 0 
	SUBLW       255
L__ConIntToStr14:
	BTFSC       STATUS+0, 0 
	GOTO        L_ConIntToStr9
;MotorLDR.c,68 :: 		ToStr[index] = (char)(num % 10)+'0';
	MOVF        ConIntToStr_index_L0+0, 0 
	ADDWF       FARG_ConIntToStr_ToStr+0, 0 
	MOVWF       FLOC__ConIntToStr+0 
	MOVF        ConIntToStr_index_L0+1, 0 
	ADDWFC      FARG_ConIntToStr_ToStr+1, 0 
	MOVWF       FLOC__ConIntToStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        ConIntToStr_num_L0+0, 0 
	MOVWF       R0 
	MOVF        ConIntToStr_num_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__ConIntToStr+0, FSR1L+0
	MOVFF       FLOC__ConIntToStr+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MotorLDR.c,69 :: 		num /= 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        ConIntToStr_num_L0+0, 0 
	MOVWF       R0 
	MOVF        ConIntToStr_num_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       ConIntToStr_num_L0+0 
	MOVF        R1, 0 
	MOVWF       ConIntToStr_num_L0+1 
;MotorLDR.c,67 :: 		for(index = 3; index > -1 ; index--){
	MOVLW       1
	SUBWF       ConIntToStr_index_L0+0, 1 
	MOVLW       0
	SUBWFB      ConIntToStr_index_L0+1, 1 
;MotorLDR.c,70 :: 		}
	GOTO        L_ConIntToStr8
L_ConIntToStr9:
;MotorLDR.c,72 :: 		ToStr[4] = 0;
	MOVLW       4
	ADDWF       FARG_ConIntToStr_ToStr+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_ConIntToStr_ToStr+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;MotorLDR.c,73 :: 		}
L_end_ConIntToStr:
	RETURN      0
; end of _ConIntToStr

_map:

;MotorLDR.c,75 :: 		float map(int value){
;MotorLDR.c,77 :: 		return (float) (200-100)/(1023) * value + 100;
	MOVF        FARG_map_value+0, 0 
	MOVWF       R0 
	MOVF        FARG_map_value+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVLW       13
	MOVWF       R4 
	MOVLW       50
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;MotorLDR.c,80 :: 		}
L_end_map:
	RETURN      0
; end of _map
