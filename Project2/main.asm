
_main:

;main.c,8 :: 		void main() {
;main.c,10 :: 		ADCON1      |= 15; //sets all pins as digital i/o
	MOVLW       15
	IORWF       ADCON1+0, 1 
;main.c,11 :: 		TRISB       |= 1; //sets RB0 as input
	BSF         TRISB+0, 0 
;main.c,12 :: 		TRISD        = 0; //all pins at port d are outputs for the 7-seg
	CLRF        TRISD+0 
;main.c,13 :: 		INTCON2.RBPU = 0; //enable weak interal pullups for port b
	BCF         INTCON2+0, 7 
;main.c,14 :: 		LATD = 0;
	CLRF        LATD+0 
;main.c,16 :: 		init_interrupt();
	CALL        _init_interrupt+0, 0
;main.c,19 :: 		for(;;){
L_main0:
;main.c,21 :: 		num += modifier;
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
;main.c,22 :: 		if(num == -1) {num = 9;}
	MOVLW       255
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       255
	XORWF       R1, 0 
L__main13:
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	MOVLW       9
	MOVWF       _num+0 
	MOVLW       0
	MOVWF       _num+1 
	GOTO        L_main4
L_main3:
;main.c,23 :: 		else if(num == 10){num = 0;}
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVLW       10
	XORWF       _num+0, 0 
L__main14:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	CLRF        _num+0 
	CLRF        _num+1 
L_main5:
L_main4:
;main.c,25 :: 		LATD = numCodes[num];
	MOVLW       _numCodes+0
	ADDWF       _num+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_numCodes+0)
	ADDWFC      _num+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;main.c,30 :: 		delay_ms(1000);
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
;main.c,33 :: 		}
	GOTO        L_main0
;main.c,35 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_interrupt:

;main.c,38 :: 		void init_interrupt(){
;main.c,39 :: 		INTCON.INT0IF = 0; //clear interrupt flag
	BCF         INTCON+0, 1 
;main.c,40 :: 		INTCON2.INTEDG0 = 0; //interrupt 0 uses falling edge
	BCF         INTCON2+0, 6 
;main.c,41 :: 		INTCON.INT0IE = 1;//enables INT0 external interrupt
	BSF         INTCON+0, 4 
;main.c,42 :: 		INTCON.INT0IF = 0; //clear interrupt flag
	BCF         INTCON+0, 1 
;main.c,43 :: 		INTCON.GIEH = 1; //enables global interrupts
	BSF         INTCON+0, 7 
;main.c,46 :: 		}
L_end_init_interrupt:
	RETURN      0
; end of _init_interrupt

_interrupt:

;main.c,48 :: 		void interrupt(){
;main.c,49 :: 		if(INTCON.INT0IF && pressed == 0){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt9
	MOVLW       0
	XORWF       _pressed+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVLW       0
	XORWF       _pressed+0, 0 
L__interrupt18:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
L__interrupt11:
;main.c,50 :: 		pressed = 1;
	MOVLW       1
	MOVWF       _pressed+0 
	MOVLW       0
	MOVWF       _pressed+1 
;main.c,51 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt10:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt10
	DECFSZ      R12, 1, 1
	BRA         L_interrupt10
	DECFSZ      R11, 1, 1
	BRA         L_interrupt10
	NOP
	NOP
;main.c,53 :: 		modifier *= -1;
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
;main.c,54 :: 		pressed = 0;
	CLRF        _pressed+0 
	CLRF        _pressed+1 
;main.c,55 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;main.c,57 :: 		}
L_interrupt9:
;main.c,61 :: 		}
L_end_interrupt:
L__interrupt17:
	RETFIE      1
; end of _interrupt
