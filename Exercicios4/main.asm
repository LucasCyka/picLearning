
_main:

;main.c,1 :: 		void main() {
;main.c,7 :: 		unsigned char numeros[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x98};
	MOVLW       192
	MOVWF       main_numeros_L0+0 
	MOVLW       249
	MOVWF       main_numeros_L0+1 
	MOVLW       164
	MOVWF       main_numeros_L0+2 
	MOVLW       176
	MOVWF       main_numeros_L0+3 
	MOVLW       153
	MOVWF       main_numeros_L0+4 
	MOVLW       146
	MOVWF       main_numeros_L0+5 
	MOVLW       130
	MOVWF       main_numeros_L0+6 
	MOVLW       248
	MOVWF       main_numeros_L0+7 
	MOVLW       128
	MOVWF       main_numeros_L0+8 
	MOVLW       152
	MOVWF       main_numeros_L0+9 
	CLRF        main_index_L0+0 
;main.c,9 :: 		TRISD = 0;
	CLRF        TRISD+0 
;main.c,10 :: 		TRISB = 1;
	MOVLW       1
	MOVWF       TRISB+0 
;main.c,11 :: 		ADCON1= 15;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,12 :: 		for(;;){
L_main0:
;main.c,14 :: 		if(PORTB & 1){
	BTFSS       PORTB+0, 0 
	GOTO        L_main3
;main.c,15 :: 		index++;
	INCF        main_index_L0+0, 1 
;main.c,16 :: 		}
L_main3:
;main.c,18 :: 		if (index >= 10){
	MOVLW       10
	SUBWF       main_index_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;main.c,19 :: 		index = 0;
	CLRF        main_index_L0+0 
;main.c,20 :: 		}
L_main4:
;main.c,21 :: 		LATD = numeros[index];
	MOVLW       main_numeros_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_index_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;main.c,23 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;main.c,28 :: 		}
	GOTO        L_main0
;main.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
