
_interrupt:

;Interrupts.c,27 :: 		void interrupt(){
;Interrupts.c,28 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt0
;Interrupts.c,29 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Interrupts.c,30 :: 		INTCON.INT0IE = 0;
	BCF         INTCON+0, 4 
;Interrupts.c,31 :: 		counter++;
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;Interrupts.c,32 :: 		}
L_interrupt0:
;Interrupts.c,34 :: 		}
L_end_interrupt:
L__interrupt19:
	RETFIE      1
; end of _interrupt

_main:

;Interrupts.c,36 :: 		void main() {
;Interrupts.c,37 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Interrupts.c,38 :: 		TRISB |= 0x01;
	BSF         TRISB+0, 0 
;Interrupts.c,39 :: 		init_interrupts();
	CALL        _init_interrupts+0, 0
;Interrupts.c,40 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Interrupts.c,41 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	NOP
;Interrupts.c,42 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Interrupts.c,45 :: 		for(;;){
L_main2:
;Interrupts.c,46 :: 		IntToStr(counter,counterTxt);
	MOVF        _counter+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _counter+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _counterTxt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_counterTxt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Interrupts.c,47 :: 		counterTxtTrim = ltrim(counterTxt);
	MOVLW       _counterTxt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_counterTxt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       _counterTxtTrim+0 
	MOVF        R1, 0 
	MOVWF       _counterTxtTrim+1 
;Interrupts.c,48 :: 		lcd_out(2,1,counterTxtTrim);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        R1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Interrupts.c,49 :: 		delay_ms(30);
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
;Interrupts.c,51 :: 		switch (counter){
	GOTO        L_main6
;Interrupts.c,52 :: 		case 0:
L_main8:
;Interrupts.c,53 :: 		screen1();
	CALL        _screen1+0, 0
;Interrupts.c,54 :: 		break;
	GOTO        L_main7
;Interrupts.c,55 :: 		case 1:
L_main9:
;Interrupts.c,56 :: 		screen2();
	CALL        _screen2+0, 0
;Interrupts.c,57 :: 		break;
	GOTO        L_main7
;Interrupts.c,58 :: 		case 2:
L_main10:
;Interrupts.c,59 :: 		screen3();
	CALL        _screen3+0, 0
;Interrupts.c,60 :: 		break;
	GOTO        L_main7
;Interrupts.c,61 :: 		case 3:
L_main11:
;Interrupts.c,62 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;Interrupts.c,63 :: 		}
	GOTO        L_main7
L_main6:
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVLW       0
	XORWF       _counter+0, 0 
L__main21:
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVLW       1
	XORWF       _counter+0, 0 
L__main22:
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       2
	XORWF       _counter+0, 0 
L__main23:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVLW       3
	XORWF       _counter+0, 0 
L__main24:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L_main7:
;Interrupts.c,65 :: 		if(!INTCON.INT0IE){ //interrupt has been disabled/buttons has been pressed
	BTFSC       INTCON+0, 4 
	GOTO        L_main12
;Interrupts.c,66 :: 		delay_ms(30); //deboucing
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
;Interrupts.c,67 :: 		if(!PORTB.RB0){
	BTFSC       PORTB+0, 0 
	GOTO        L_main14
;Interrupts.c,68 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;Interrupts.c,69 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;Interrupts.c,70 :: 		}
L_main14:
;Interrupts.c,71 :: 		}
L_main12:
;Interrupts.c,73 :: 		}
	GOTO        L_main2
;Interrupts.c,75 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_interrupts:

;Interrupts.c,77 :: 		void init_interrupts(){
;Interrupts.c,78 :: 		INTCON.INT0IE = 1;  //enable int0 interrupts
	BSF         INTCON+0, 4 
;Interrupts.c,79 :: 		INTCON.INT0IF = 0;  //clear intterupt flag
	BCF         INTCON+0, 1 
;Interrupts.c,80 :: 		INTCON.INTEDG0 = 1; //int0 is enabled on rising edge
	BSF         INTCON+0, 6 
;Interrupts.c,81 :: 		INTCON.GIE = 1;     //enable global interrupts
	BSF         INTCON+0, 7 
;Interrupts.c,82 :: 		}
L_end_init_interrupts:
	RETURN      0
; end of _init_interrupts

_screen1:

;Interrupts.c,84 :: 		void screen1(){
;Interrupts.c,85 :: 		if(lastScreen != 0){
	MOVF        _lastScreen+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_screen115
;Interrupts.c,86 :: 		lastScreen = 0;
	CLRF        _lastScreen+0 
;Interrupts.c,87 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Interrupts.c,88 :: 		lcd_out(1,1,"Pronto");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Interrupts+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Interrupts+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Interrupts.c,89 :: 		}
L_screen115:
;Interrupts.c,90 :: 		}
L_end_screen1:
	RETURN      0
; end of _screen1

_screen2:

;Interrupts.c,92 :: 		void screen2(){
;Interrupts.c,93 :: 		if(lastScreen != 1){
	MOVF        _lastScreen+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_screen216
;Interrupts.c,94 :: 		lastScreen = 1;
	MOVLW       1
	MOVWF       _lastScreen+0 
;Interrupts.c,95 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Interrupts.c,96 :: 		lcd_out(1,1,"Emergencia");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Interrupts+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Interrupts+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Interrupts.c,97 :: 		}
L_screen216:
;Interrupts.c,98 :: 		}
L_end_screen2:
	RETURN      0
; end of _screen2

_screen3:

;Interrupts.c,100 :: 		void screen3(){
;Interrupts.c,101 :: 		if(lastScreen != 2){
	MOVF        _lastScreen+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_screen317
;Interrupts.c,102 :: 		lastScreen = 2;
	MOVLW       2
	MOVWF       _lastScreen+0 
;Interrupts.c,103 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Interrupts.c,104 :: 		lcd_out(1,1,"Manutencao");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Interrupts+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Interrupts+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Interrupts.c,105 :: 		}
L_screen317:
;Interrupts.c,106 :: 		}
L_end_screen3:
	RETURN      0
; end of _screen3
