
_interrupt:

;tacometro2.c,28 :: 		void interrupt(){
;tacometro2.c,29 :: 		if(PIR1.TMR1IF == 1 && PIE1.TMR1IE == 1){
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt2
	BTFSS       PIE1+0, 0 
	GOTO        L_interrupt2
L__interrupt9:
;tacometro2.c,30 :: 		TMR1H = 0xEC;
	MOVLW       236
	MOVWF       TMR1H+0 
;tacometro2.c,31 :: 		TMR1L = 0x79;
	MOVLW       121
	MOVWF       TMR1L+0 
;tacometro2.c,32 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;tacometro2.c,33 :: 		mseconds++;
	INFSNZ      _mseconds+0, 1 
	INCF        _mseconds+1, 1 
;tacometro2.c,35 :: 		}
L_interrupt2:
;tacometro2.c,36 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt

_main:

;tacometro2.c,38 :: 		void main() {
;tacometro2.c,39 :: 		setup();
	CALL        _setup+0, 0
;tacometro2.c,41 :: 		for(;;){
L_main3:
;tacometro2.c,42 :: 		IntToStr(mseconds,mseconds_txt);
	MOVF        _mseconds+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _mseconds+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _mseconds_txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_mseconds_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;tacometro2.c,43 :: 		lcd_out(1,1,mseconds_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _mseconds_txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_mseconds_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tacometro2.c,45 :: 		if(mseconds >= 1000){
	MOVLW       128
	XORWF       _mseconds+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       232
	SUBWF       _mseconds+0, 0 
L__main13:
	BTFSS       STATUS+0, 0 
	GOTO        L_main6
;tacometro2.c,46 :: 		mseconds = 0;
	CLRF        _mseconds+0 
	CLRF        _mseconds+1 
;tacometro2.c,48 :: 		}
L_main6:
;tacometro2.c,51 :: 		LATC |= 0x04;
	BSF         LATC+0, 2 
;tacometro2.c,52 :: 		delay_us(500);
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       61
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	NOP
	NOP
;tacometro2.c,53 :: 		LATC = 0x00;
	CLRF        LATC+0 
;tacometro2.c,54 :: 		delay_us(500);
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       61
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
	NOP
;tacometro2.c,56 :: 		}
	GOTO        L_main3
;tacometro2.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_setup:

;tacometro2.c,60 :: 		void setup(){
;tacometro2.c,61 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;tacometro2.c,62 :: 		TRISA  |= 0x10;
	BSF         TRISA+0, 4 
;tacometro2.c,63 :: 		TRISC  &= 0xFB;
	MOVLW       251
	ANDWF       TRISC+0, 1 
;tacometro2.c,66 :: 		LATC |= 0x04;
	BSF         LATC+0, 2 
;tacometro2.c,69 :: 		TRISE &= 0x02;
	MOVLW       2
	ANDWF       TRISE+0, 1 
;tacometro2.c,70 :: 		LATE   = 0x00;
	CLRF        LATE+0 
;tacometro2.c,72 :: 		Lcd_init();
	CALL        _Lcd_Init+0, 0
;tacometro2.c,73 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;tacometro2.c,77 :: 		T0CON.TMR0ON = 1; //turn timer on
	BSF         T0CON+0, 7 
;tacometro2.c,78 :: 		T0CON.T08BIT = 0; //use it as 16bit
	BCF         T0CON+0, 6 
;tacometro2.c,79 :: 		T0CON.T0CS   = 1; //as counter on t0CKI
	BSF         T0CON+0, 5 
;tacometro2.c,80 :: 		T0CON.T0SE   = 1; //rising edge
	BSF         T0CON+0, 4 
;tacometro2.c,81 :: 		T0CON.PSA    = 1; //do not use prescaler
	BSF         T0CON+0, 3 
;tacometro2.c,82 :: 		TMR0H        = 0x00;
	CLRF        TMR0H+0 
;tacometro2.c,83 :: 		TMR0L        = 0x00;
	CLRF        TMR0L+0 
;tacometro2.c,87 :: 		T1CON.RD16    = 1;
	BSF         T1CON+0, 7 
;tacometro2.c,88 :: 		T1CON.T1CKPS0 = 0; //prescale
	BCF         T1CON+0, 4 
;tacometro2.c,89 :: 		T1CON.T1CKPS1 = 0; //prescale
	BCF         T1CON+0, 5 
;tacometro2.c,90 :: 		T1CON.TMR1CS  = 0;
	BCF         T1CON+0, 1 
;tacometro2.c,91 :: 		T1CON.T1RUN   = 0;
	BCF         T1CON+0, 6 
;tacometro2.c,92 :: 		T1CON.TMR1ON  = 1; //enables timer1
	BSF         T1CON+0, 0 
;tacometro2.c,93 :: 		TMR1H = 0xEC;
	MOVLW       236
	MOVWF       TMR1H+0 
;tacometro2.c,94 :: 		TMR1L = 0x79; //4999
	MOVLW       121
	MOVWF       TMR1L+0 
;tacometro2.c,97 :: 		INTCON.GIEH = 1;
	BSF         INTCON+0, 7 
;tacometro2.c,98 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;tacometro2.c,99 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;tacometro2.c,100 :: 		PIE1.TMR1IE = 1;
	BSF         PIE1+0, 0 
;tacometro2.c,101 :: 		IPR1.TMR1IP = 1;
	BSF         IPR1+0, 0 
;tacometro2.c,106 :: 		}
L_end_setup:
	RETURN      0
; end of _setup
