
_main:

;Ex0.c,1 :: 		void main() {
;Ex0.c,3 :: 		TRISB = 255;
	MOVLW       255
	MOVWF       TRISB+0 
;Ex0.c,4 :: 		TRISA = 0;
	CLRF        TRISA+0 
;Ex0.c,5 :: 		ADCON1 |= 15;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;Ex0.c,6 :: 		INTCON2.RBPU = 0; //enable pull ups for port B
	BCF         INTCON2+0, 7 
;Ex0.c,7 :: 		INTCON.INT0IE = 1; //enable external interrupt int0
	BSF         INTCON+0, 4 
;Ex0.c,8 :: 		INTCON.INT0IF = 0; //clear interrupt flag
	BCF         INTCON+0, 1 
;Ex0.c,9 :: 		INTCON2.INTEDG0 = 0;//enable external interrupt 0 for falling edge
	BCF         INTCON2+0, 6 
;Ex0.c,10 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Ex0.c,12 :: 		for(;;){
L_main0:
;Ex0.c,14 :: 		}
	GOTO        L_main0
;Ex0.c,17 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Ex0.c,19 :: 		void interrupt(){
;Ex0.c,20 :: 		LATA = ~LATA;
	COMF        LATA+0, 1 
;Ex0.c,21 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Ex0.c,23 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_interrupt3:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt3
	DECFSZ      R12, 1, 1
	BRA         L_interrupt3
	DECFSZ      R11, 1, 1
	BRA         L_interrupt3
	NOP
;Ex0.c,24 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt
