
_main:

;lcd.c,9 :: 		void main() {
;lcd.c,12 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;lcd.c,13 :: 		write_lcd();
	CALL        _write_lcd+0, 0
;lcd.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_init_lcd:

;lcd.c,58 :: 		void init_lcd(){
;lcd.c,59 :: 		TRISE &= 248;
	MOVLW       248
	ANDWF       TRISE+0, 1 
;lcd.c,60 :: 		TRISD  = 0;
	CLRF        TRISD+0 
;lcd.c,61 :: 		LATE  &= 248;
	MOVLW       248
	ANDWF       LATE+0, 1 
;lcd.c,62 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_init_lcd0:
	DECFSZ      R13, 1, 1
	BRA         L_init_lcd0
	DECFSZ      R12, 1, 1
	BRA         L_init_lcd0
	NOP
;lcd.c,65 :: 		LATD  = 0b00111000;
	MOVLW       56
	MOVWF       LATD+0 
;lcd.c,66 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;lcd.c,68 :: 		LATD = 0b00001111;
	MOVLW       15
	MOVWF       LATD+0 
;lcd.c,69 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;lcd.c,70 :: 		LATD = 0b00111010;
	MOVLW       58
	MOVWF       LATD+0 
;lcd.c,71 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;lcd.c,74 :: 		}
L_end_init_lcd:
	RETURN      0
; end of _init_lcd

_enable_pulse:

;lcd.c,76 :: 		void enable_pulse(){
;lcd.c,77 :: 		LATE |= 1;
	BSF         LATE+0, 0 
;lcd.c,78 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_enable_pulse1:
	DECFSZ      R13, 1, 1
	BRA         L_enable_pulse1
	DECFSZ      R12, 1, 1
	BRA         L_enable_pulse1
	DECFSZ      R11, 1, 1
	BRA         L_enable_pulse1
	NOP
	NOP
;lcd.c,79 :: 		LATE &= 254;
	MOVLW       254
	ANDWF       LATE+0, 1 
;lcd.c,80 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_enable_pulse2:
	DECFSZ      R13, 1, 1
	BRA         L_enable_pulse2
	DECFSZ      R12, 1, 1
	BRA         L_enable_pulse2
	DECFSZ      R11, 1, 1
	BRA         L_enable_pulse2
	NOP
	NOP
;lcd.c,81 :: 		}
L_end_enable_pulse:
	RETURN      0
; end of _enable_pulse

_write_lcd:

;lcd.c,83 :: 		void write_lcd(){
;lcd.c,84 :: 		for(index = 0; index < 17; index++){
	CLRF        _index+0 
	CLRF        _index+1 
L_write_lcd3:
	MOVLW       128
	XORWF       _index+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_lcd10
	MOVLW       17
	SUBWF       _index+0, 0 
L__write_lcd10:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_lcd4
;lcd.c,85 :: 		LATE |= 4;
	BSF         LATE+0, 2 
;lcd.c,86 :: 		LATD = myWord[index];
	MOVLW       _myWord+0
	ADDWF       _index+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_myWord+0)
	ADDWFC      _index+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;lcd.c,87 :: 		enable_pulse();
	CALL        _enable_pulse+0, 0
;lcd.c,84 :: 		for(index = 0; index < 17; index++){
	INFSNZ      _index+0, 1 
	INCF        _index+1, 1 
;lcd.c,89 :: 		}
	GOTO        L_write_lcd3
L_write_lcd4:
;lcd.c,92 :: 		}
L_end_write_lcd:
	RETURN      0
; end of _write_lcd
