
_main:

;interrupt.c,3 :: 		void main() {
;interrupt.c,5 :: 		ADCON1 |= 15;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;interrupt.c,6 :: 		TRISA  &= 252;
	MOVLW       252
	ANDWF       TRISA+0, 1 
;interrupt.c,7 :: 		TRISB  |= 1;
	BSF         TRISB+0, 0 
;interrupt.c,8 :: 		INTCON2.RBPU = 1; //disable internal pullups for port b
	BSF         INTCON2+0, 7 
;interrupt.c,9 :: 		init_interrupt();
	CALL        _init_interrupt+0, 0
;interrupt.c,11 :: 		for(;;){
L_main0:
;interrupt.c,12 :: 		LATA ^= 1;
	BTG         LATA+0, 0 
;interrupt.c,13 :: 		delay_ms(1000);
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
;interrupt.c,14 :: 		}
	GOTO        L_main0
;interrupt.c,16 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_interrupt:

;interrupt.c,18 :: 		void init_interrupt(){
;interrupt.c,19 :: 		INTCON2.INTEDG0 = 1; //rising edge external interrupt 0
	BSF         INTCON2+0, 6 
;interrupt.c,20 :: 		INTCON.INT0IE   = 1; //enables int0 external interrupt
	BSF         INTCON+0, 4 
;interrupt.c,21 :: 		INTCON.INT0IF   = 0; //interrupt flag, mut be cleared always when theres a interrupt
	BCF         INTCON+0, 1 
;interrupt.c,22 :: 		INTCON.GIEH     = 1; //enable global interrupts
	BSF         INTCON+0, 7 
;interrupt.c,24 :: 		}
L_end_init_interrupt:
	RETURN      0
; end of _init_interrupt

_interrupt:

;interrupt.c,26 :: 		void interrupt(void){
;interrupt.c,27 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt4
;interrupt.c,28 :: 		LATA         ^= 2;
	BTG         LATA+0, 1 
;interrupt.c,29 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_interrupt5:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt5
	DECFSZ      R12, 1, 1
	BRA         L_interrupt5
	NOP
;interrupt.c,30 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;interrupt.c,31 :: 		}
L_interrupt4:
;interrupt.c,33 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt
