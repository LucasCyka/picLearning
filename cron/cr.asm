
_main:

;cr.c,21 :: 		void main() {
;cr.c,22 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;cr.c,23 :: 		TRISE.RE1 = 0;
	BCF         TRISE+0, 1 
;cr.c,24 :: 		TRISB.RB0 = 1;
	BSF         TRISB+0, 0 
;cr.c,25 :: 		LATE.RE1 = 0;
	BCF         LATE+0, 1 
;cr.c,27 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;cr.c,28 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;cr.c,30 :: 		for(;;){
L_main0:
;cr.c,36 :: 		if(PORTB.RB0 == 0){
	BTFSC       PORTB+0, 0 
	GOTO        L_main3
;cr.c,37 :: 		delay_ms(800);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;cr.c,38 :: 		seconds++;
	INFSNZ      _seconds+0, 1 
	INCF        _seconds+1, 1 
;cr.c,39 :: 		if(seconds == 60){
	MOVLW       0
	XORWF       _seconds+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVLW       60
	XORWF       _seconds+0, 0 
L__main10:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;cr.c,40 :: 		seconds = 0;
	CLRF        _seconds+0 
	CLRF        _seconds+1 
;cr.c,41 :: 		minutes++;
	INFSNZ      _minutes+0, 1 
	INCF        _minutes+1, 1 
;cr.c,42 :: 		}
L_main5:
;cr.c,44 :: 		if(minutes == 60){
	MOVLW       0
	XORWF       _minutes+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main11
	MOVLW       60
	XORWF       _minutes+0, 0 
L__main11:
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;cr.c,45 :: 		minutes = 0;
	CLRF        _minutes+0 
	CLRF        _minutes+1 
;cr.c,46 :: 		}
L_main6:
;cr.c,47 :: 		}
L_main3:
;cr.c,51 :: 		IntToStr(seconds,txt_seconds);
	MOVF        _seconds+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _seconds+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt_seconds+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt_seconds+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;cr.c,52 :: 		IntToStr(minutes,txt_minutes);
	MOVF        _minutes+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _minutes+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt_minutes+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt_minutes+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;cr.c,54 :: 		if (minutes < 10){
	MOVLW       128
	XORWF       _minutes+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main12
	MOVLW       10
	SUBWF       _minutes+0, 0 
L__main12:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;cr.c,55 :: 		txt_minutes[4] = '0';
	MOVLW       48
	MOVWF       _txt_minutes+4 
;cr.c,56 :: 		}
L_main7:
;cr.c,57 :: 		if (seconds < 10){
	MOVLW       128
	XORWF       _seconds+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       10
	SUBWF       _seconds+0, 0 
L__main13:
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;cr.c,58 :: 		txt_seconds[4] = '0';
	MOVLW       48
	MOVWF       _txt_seconds+4 
;cr.c,59 :: 		}
L_main8:
;cr.c,62 :: 		ltrim(txt_minutes);
	MOVLW       _txt_minutes+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt_minutes+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;cr.c,63 :: 		ltrim(txt_seconds);
	MOVLW       _txt_seconds+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_txt_seconds+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;cr.c,66 :: 		lcd_out(1,1,txt_minutes);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt_minutes+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt_minutes+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;cr.c,67 :: 		lcd_out(1,3,":");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_cr+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_cr+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;cr.c,68 :: 		lcd_out(1,4,txt_seconds);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt_seconds+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt_seconds+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;cr.c,70 :: 		}
	GOTO        L_main0
;cr.c,74 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
