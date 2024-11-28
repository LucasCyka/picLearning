
_main:

;tacometro.c,26 :: 		void main() {
;tacometro.c,27 :: 		setup();
	CALL        _setup+0, 0
;tacometro.c,29 :: 		for(;;){
L_main0:
;tacometro.c,31 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;tacometro.c,32 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;tacometro.c,33 :: 		TMR0Val = (TMR0H << 8) | TMR0L;
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        TMR0L+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _TMR0Val+0 
	MOVF        R1, 0 
	MOVWF       _TMR0Val+1 
;tacometro.c,35 :: 		TMR0H = 0x00;
	CLRF        TMR0H+0 
;tacometro.c,36 :: 		TMR0L = 0x00;
	CLRF        TMR0L+0 
;tacometro.c,38 :: 		TMR0Val *= 60;
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TMR0Val+0 
	MOVF        R1, 0 
	MOVWF       _TMR0Val+1 
;tacometro.c,40 :: 		IntToStr(TMR0Val,TMR0_txt);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TMR0_txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TMR0_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;tacometro.c,41 :: 		TMR0_txt_trimmed = Ltrim(TMR0_txt);
	MOVLW       _TMR0_txt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_TMR0_txt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       _TMR0_txt_trimmed+0 
	MOVF        R1, 0 
	MOVWF       _TMR0_txt_trimmed+1 
;tacometro.c,44 :: 		lcd_out(1,1,TMR0_txt_trimmed);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tacometro.c,45 :: 		lcd_out(1,7,"RPM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_tacometro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_tacometro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tacometro.c,47 :: 		TMR0Val = 0;
	CLRF        _TMR0Val+0 
	CLRF        _TMR0Val+1 
;tacometro.c,49 :: 		}
	GOTO        L_main0
;tacometro.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_setup:

;tacometro.c,53 :: 		void setup(){
;tacometro.c,54 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;tacometro.c,55 :: 		TRISA  |= 0x10;
	BSF         TRISA+0, 4 
;tacometro.c,56 :: 		TRISC  &= 0xFB;
	MOVLW       251
	ANDWF       TRISC+0, 1 
;tacometro.c,59 :: 		LATC |= 0x04;
	BSF         LATC+0, 2 
;tacometro.c,62 :: 		TRISE &= 0x02;
	MOVLW       2
	ANDWF       TRISE+0, 1 
;tacometro.c,63 :: 		LATE   = 0x00;
	CLRF        LATE+0 
;tacometro.c,65 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;tacometro.c,66 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;tacometro.c,70 :: 		T0CON.TMR0ON = 1; //turn timer on
	BSF         T0CON+0, 7 
;tacometro.c,71 :: 		T0CON.T08BIT = 0; //use it as 16bit
	BCF         T0CON+0, 6 
;tacometro.c,72 :: 		T0CON.T0CS   = 1; //as counter on t0CKI
	BSF         T0CON+0, 5 
;tacometro.c,73 :: 		T0CON.T0SE   = 1; //rising edge
	BSF         T0CON+0, 4 
;tacometro.c,74 :: 		T0CON.PSA    = 1; //do not use prescaler
	BSF         T0CON+0, 3 
;tacometro.c,75 :: 		TMR0H        = 0x00;
	CLRF        TMR0H+0 
;tacometro.c,76 :: 		TMR0L        = 0x00;
	CLRF        TMR0L+0 
;tacometro.c,82 :: 		}
L_end_setup:
	RETURN      0
; end of _setup
