
_main:

;AD.c,1 :: 		void main() {
;AD.c,3 :: 		ADCON1  = 14;
	MOVLW       14
	MOVWF       ADCON1+0 
;AD.c,4 :: 		ADCON0 &= 195;   //Selects channel0 (AN0)
	MOVLW       195
	ANDWF       ADCON0+0, 1 
;AD.c,5 :: 		ADCON0  |= 1;    //enable converter module
	BSF         ADCON0+0, 0 
;AD.c,6 :: 		TRISA    = 1;
	MOVLW       1
	MOVWF       TRISA+0 
;AD.c,8 :: 		for(;;){
L_main0:
;AD.c,10 :: 		if(ADRES >= 100){
	MOVLW       0
	SUBWF       ADRES+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVLW       100
	SUBWF       ADRES+0, 0 
L__main6:
	BTFSS       STATUS+0, 0 
	GOTO        L_main3
;AD.c,11 :: 		LATA.RA1 = 1;
	BSF         LATA+0, 1 
;AD.c,12 :: 		}else{
	GOTO        L_main4
L_main3:
;AD.c,13 :: 		LATA.RA1 = 0;
	BCF         LATA+0, 1 
;AD.c,14 :: 		}
L_main4:
;AD.c,16 :: 		}
	GOTO        L_main0
;AD.c,22 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
