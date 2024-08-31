
_main:

;main.c,7 :: 		void main() {
;main.c,9 :: 		ADCON1      |= 15; //sets all pins as digital i/o
	MOVLW       15
	IORWF       ADCON1+0, 1 
;main.c,10 :: 		TRISB       |= 1; //sets RB0 as input
	BSF         TRISB+0, 0 
;main.c,11 :: 		TRISD        = 0; //all pins at port d are outputs for the 7-seg
	CLRF        TRISD+0 
;main.c,12 :: 		INTCON2.RBPU = 0; //enable weak interal pullups for port b
	BCF         INTCON2+0, 7 
;main.c,13 :: 		LATD = 0;
	CLRF        LATD+0 
;main.c,15 :: 		init_interrupt();
	CALL        _init_interrupt+0, 0
;main.c,18 :: 		for(;;){
L_main0:
;main.c,19 :: 		num += modifier;
	MOVF        _modifier+0, 0 
	ADDWF       _num+0, 0 
	MOVWF       R1 
	MOVF        _modifier+1, 0 
	ADDWFC      _num+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _num+0 
	MOVF        R2, 0 
	MOVWF       _num+1 
;main.c,20 :: 		if(num == -1) {num = 9;}
	MOVLW       255
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVLW       255
	XORWF       R1, 0 
L__main8:
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	MOVLW       9
	MOVWF       _num+0 
	MOVLW       0
	MOVWF       _num+1 
	GOTO        L_main4
L_main3:
;main.c,21 :: 		else if(num == 10){num = 0;}
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVLW       10
	XORWF       _num+0, 0 
L__main9:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	CLRF        _num+0 
	CLRF        _num+1 
L_main5:
L_main4:
;main.c,23 :: 		LATD = numCodes[num];
	MOVLW       _numCodes+0
	ADDWF       _num+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_numCodes+0)
	ADDWFC      _num+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;main.c,28 :: 		delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;main.c,31 :: 		}
	GOTO        L_main0
;main.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_interrupt:

;main.c,36 :: 		void init_interrupt(){
;main.c,37 :: 		INTCON.INT0IF = 0; //clear interrupt flag
	BCF         INTCON+0, 1 
;main.c,38 :: 		INTCON2.INTEDG0 = 0; //interrupt 0 uses falling edge
	BCF         INTCON2+0, 6 
;main.c,39 :: 		INTCON.INT0IE = 1;//enables INT0 external interrupt
	BSF         INTCON+0, 4 
;main.c,40 :: 		INTCON.INT0IF = 0; //clear interrupt flag
	BCF         INTCON+0, 1 
;main.c,41 :: 		INTCON.GIEH = 1; //enables global interrupts
	BSF         INTCON+0, 7 
;main.c,44 :: 		}
L_end_init_interrupt:
	RETURN      0
; end of _init_interrupt

_interrupt:

;main.c,46 :: 		void interrupt(){
;main.c,47 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;main.c,49 :: 		modifier *= -1;
	MOVF        _modifier+0, 0 
	MOVWF       R0 
	MOVF        _modifier+1, 0 
	MOVWF       R1 
	MOVLW       255
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _modifier+0 
	MOVF        R1, 0 
	MOVWF       _modifier+1 
;main.c,52 :: 		}
L_end_interrupt:
L__interrupt12:
	RETFIE      1
; end of _interrupt
