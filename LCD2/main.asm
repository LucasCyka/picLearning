
_main:

;main.c,12 :: 		void main() {
;main.c,15 :: 		TRISE &= 248;
	MOVLW       248
	ANDWF       TRISE+0, 1 
;main.c,16 :: 		TRISD  = 0;
	CLRF        TRISD+0 
;main.c,17 :: 		LATE = 0;
	CLRF        LATE+0 
;main.c,18 :: 		seconds[0] = '0';
	MOVLW       48
	MOVWF       main_seconds_L0+0 
;main.c,19 :: 		seconds[1] = '0';
	MOVLW       48
	MOVWF       main_seconds_L0+1 
;main.c,20 :: 		seconds[2] = '|';
	MOVLW       124
	MOVWF       main_seconds_L0+2 
;main.c,22 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;main.c,24 :: 		for(;;){
L_main0:
;main.c,27 :: 		writeLCD(seconds);
	MOVLW       main_seconds_L0+0
	MOVWF       FARG_writeLCD_value+0 
	MOVLW       hi_addr(main_seconds_L0+0)
	MOVWF       FARG_writeLCD_value+1 
	CALL        _writeLCD+0, 0
;main.c,30 :: 		WriteLCD("SECONDS|");
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_writeLCD_value+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_writeLCD_value+1 
	CALL        _writeLCD+0, 0
;main.c,31 :: 		seconds[1]++;
	INCF        main_seconds_L0+1, 1 
;main.c,32 :: 		if (seconds[1] == ':'){
	MOVF        main_seconds_L0+1, 0 
	XORLW       58
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;main.c,33 :: 		seconds[1] = '0';
	MOVLW       48
	MOVWF       main_seconds_L0+1 
;main.c,34 :: 		seconds[0]++;
	INCF        main_seconds_L0+0, 1 
;main.c,35 :: 		}
L_main3:
;main.c,38 :: 		if(seconds[0] == '6'){
	MOVF        main_seconds_L0+0, 0 
	XORLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;main.c,39 :: 		seconds[0] = '0';
	MOVLW       48
	MOVWF       main_seconds_L0+0 
;main.c,40 :: 		}
L_main4:
;main.c,45 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;main.c,46 :: 		clear();
	CALL        _clear+0, 0
;main.c,47 :: 		cursorHome();
	CALL        _cursorHome+0, 0
;main.c,49 :: 		}
	GOTO        L_main0
;main.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_lcd:

;main.c,52 :: 		void init_lcd(){
;main.c,53 :: 		delay_ms(15);
	MOVLW       98
	MOVWF       R12, 0
	MOVLW       101
	MOVWF       R13, 0
L_init_lcd6:
	DECFSZ      R13, 1, 1
	BRA         L_init_lcd6
	DECFSZ      R12, 1, 1
	BRA         L_init_lcd6
	NOP
	NOP
;main.c,54 :: 		LATD = 0x38;
	MOVLW       56
	MOVWF       LATD+0 
;main.c,55 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,56 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_init_lcd7:
	DECFSZ      R13, 1, 1
	BRA         L_init_lcd7
	DECFSZ      R12, 1, 1
	BRA         L_init_lcd7
;main.c,57 :: 		LATD = 0x38;
	MOVLW       56
	MOVWF       LATD+0 
;main.c,58 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,60 :: 		enableCursor();
	CALL        _enableCursor+0, 0
;main.c,61 :: 		clear();
	CALL        _clear+0, 0
;main.c,62 :: 		cursorHome();
	CALL        _cursorHome+0, 0
;main.c,64 :: 		}
L_end_init_lcd:
	RETURN      0
; end of _init_lcd

_enable_pulse:

;main.c,66 :: 		void enable_pulse(){
;main.c,67 :: 		LATE |= 4;
	BSF         LATE+0, 2 
;main.c,68 :: 		delay_ms(30);
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_enable_pulse8:
	DECFSZ      R13, 1, 1
	BRA         L_enable_pulse8
	DECFSZ      R12, 1, 1
	BRA         L_enable_pulse8
;main.c,69 :: 		LATE &= 251;
	MOVLW       251
	ANDWF       LATE+0, 1 
;main.c,70 :: 		delay_ms(30);
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       205
	MOVWF       R13, 0
L_enable_pulse9:
	DECFSZ      R13, 1, 1
	BRA         L_enable_pulse9
	DECFSZ      R12, 1, 1
	BRA         L_enable_pulse9
;main.c,72 :: 		}
L_end_enable_pulse:
	RETURN      0
; end of _enable_pulse

_enableCursor:

;main.c,74 :: 		void enableCursor(){
;main.c,75 :: 		LATE = 0;
	CLRF        LATE+0 
;main.c,76 :: 		LATD = 0x0F;
	MOVLW       15
	MOVWF       LATD+0 
;main.c,77 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,78 :: 		}
L_end_enableCursor:
	RETURN      0
; end of _enableCursor

_clear:

;main.c,80 :: 		void clear(){
;main.c,81 :: 		LATE = 0;
	CLRF        LATE+0 
;main.c,82 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;main.c,83 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,84 :: 		}
L_end_clear:
	RETURN      0
; end of _clear

_cursorHome:

;main.c,86 :: 		void cursorHome(){
;main.c,87 :: 		LATE = 0;
	CLRF        LATE+0 
;main.c,88 :: 		LATD = 0x02;
	MOVLW       2
	MOVWF       LATD+0 
;main.c,89 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,90 :: 		}
L_end_cursorHome:
	RETURN      0
; end of _cursorHome

_writeLCD:

;main.c,92 :: 		void writeLCD(char value[16]){
;main.c,93 :: 		int index = 0;
	CLRF        writeLCD_index_L0+0 
	CLRF        writeLCD_index_L0+1 
;main.c,94 :: 		LATE |= 1;
	BSF         LATE+0, 0 
;main.c,97 :: 		for(index = 0; index < 15; index++){
	CLRF        writeLCD_index_L0+0 
	CLRF        writeLCD_index_L0+1 
L_writeLCD10:
	MOVLW       128
	XORWF       writeLCD_index_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__writeLCD21
	MOVLW       15
	SUBWF       writeLCD_index_L0+0, 0 
L__writeLCD21:
	BTFSC       STATUS+0, 0 
	GOTO        L_writeLCD11
;main.c,98 :: 		if(value[index] == '|'){
	MOVF        writeLCD_index_L0+0, 0 
	ADDWF       FARG_writeLCD_value+0, 0 
	MOVWF       FSR0L+0 
	MOVF        writeLCD_index_L0+1, 0 
	ADDWFC      FARG_writeLCD_value+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       124
	BTFSS       STATUS+0, 2 
	GOTO        L_writeLCD13
;main.c,99 :: 		index = 16;
	MOVLW       16
	MOVWF       writeLCD_index_L0+0 
	MOVLW       0
	MOVWF       writeLCD_index_L0+1 
;main.c,100 :: 		}
L_writeLCD13:
;main.c,101 :: 		LATD = (int)value[index];
	MOVF        writeLCD_index_L0+0, 0 
	ADDWF       FARG_writeLCD_value+0, 0 
	MOVWF       FSR0L+0 
	MOVF        writeLCD_index_L0+1, 0 
	ADDWFC      FARG_writeLCD_value+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;main.c,102 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;main.c,97 :: 		for(index = 0; index < 15; index++){
	INFSNZ      writeLCD_index_L0+0, 1 
	INCF        writeLCD_index_L0+1, 1 
;main.c,104 :: 		}
	GOTO        L_writeLCD10
L_writeLCD11:
;main.c,107 :: 		}
L_end_writeLCD:
	RETURN      0
; end of _writeLCD
