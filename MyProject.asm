
_main:

;MyProject.c,1 :: 		void main() {
;MyProject.c,2 :: 		char botaoEstado   = 0;
	CLRF        main_botaoEstado_L0+0 
	CLRF        main_botaoComutado_L0+0 
	CLRF        main_ledEstado_L0+0 
;MyProject.c,6 :: 		PORTB.RBPU = 1;
	BSF         PORTB+0, 7 
;MyProject.c,7 :: 		ADCON1 = 15;
	MOVLW       15
	MOVWF       ADCON1+0 
;MyProject.c,8 :: 		TRISB  = 1;
	MOVLW       1
	MOVWF       TRISB+0 
;MyProject.c,9 :: 		TRISA  = 0;
	CLRF        TRISA+0 
;MyProject.c,12 :: 		for(;;){
L_main0:
;MyProject.c,14 :: 		if(PORTB & 1){
	BTFSS       PORTB+0, 0 
	GOTO        L_main3
;MyProject.c,15 :: 		botaoEstado = 1;
	MOVLW       1
	MOVWF       main_botaoEstado_L0+0 
;MyProject.c,16 :: 		delay_ms(10);   //debounce
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	NOP
;MyProject.c,17 :: 		}else{
	GOTO        L_main5
L_main3:
;MyProject.c,18 :: 		botaoEstado = 0;
	CLRF        main_botaoEstado_L0+0 
;MyProject.c,19 :: 		delay_ms(10);  //debounce
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
;MyProject.c,20 :: 		}
L_main5:
;MyProject.c,22 :: 		if(botaoEstado == 1 && ledEstado == 0 && botaoComutado == 0){ //botao está pressionado, led está apagada e o botão ainda não foi pressionado
	MOVF        main_botaoEstado_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        main_ledEstado_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        main_botaoComutado_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main19:
;MyProject.c,23 :: 		botaoComutado = 1; //botão foi pressionado.
	MOVLW       1
	MOVWF       main_botaoComutado_L0+0 
;MyProject.c,24 :: 		ledEstado = 1;     //acende led
	MOVLW       1
	MOVWF       main_ledEstado_L0+0 
;MyProject.c,25 :: 		}else if(botaoEstado == 1 && ledEstado == 1 && botaoComutado == 0){  //botao está pressionado, led está acesa e o botão ainda não foi pressionado
	GOTO        L_main10
L_main9:
	MOVF        main_botaoEstado_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
	MOVF        main_ledEstado_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
	MOVF        main_botaoComutado_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
L__main18:
;MyProject.c,26 :: 		ledEstado = 0;    //apaga led
	CLRF        main_ledEstado_L0+0 
;MyProject.c,27 :: 		botaoComutado = 1;   //botão foi pressionado.
	MOVLW       1
	MOVWF       main_botaoComutado_L0+0 
;MyProject.c,28 :: 		}
L_main13:
L_main10:
;MyProject.c,30 :: 		if(botaoComutado == 1 && !(PORTB & 1)){ //botão que tinha sido pressionado foi comutado
	MOVF        main_botaoComutado_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
	BTFSC       PORTB+0, 0 
	GOTO        L_main16
L__main17:
;MyProject.c,31 :: 		botaoComutado = 0;
	CLRF        main_botaoComutado_L0+0 
;MyProject.c,32 :: 		}
L_main16:
;MyProject.c,34 :: 		LATA = ledEstado;
	MOVF        main_ledEstado_L0+0, 0 
	MOVWF       LATA+0 
;MyProject.c,36 :: 		}
	GOTO        L_main0
;MyProject.c,39 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
