
_init_lcd:

;eemLCD.c,45 :: 		void init_lcd(){
;eemLCD.c,46 :: 		TRISE &= 248;
	MOVLW       248
	ANDWF       TRISE+0, 1 
;eemLCD.c,47 :: 		TRISD  = 0;
	CLRF        TRISD+0 
;eemLCD.c,48 :: 		delay_ms(10);
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
;eemLCD.c,50 :: 		lcd_command(_lcd_start);
	MOVLW       56
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;eemLCD.c,51 :: 		lcd_command(_lcd_display_on);
	MOVLW       12
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;eemLCD.c,52 :: 		lcd_command(_lcd_cursor_blink);
	MOVLW       15
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;eemLCD.c,53 :: 		lcd_command(_lcd_cursor_home);
	MOVLW       2
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;eemLCD.c,54 :: 		lcd_command(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_lcd_command_cmd+0 
	MOVLW       0
	MOVWF       FARG_lcd_command_cmd+1 
	CALL        _lcd_command+0, 0
;eemLCD.c,57 :: 		}
L_end_init_lcd:
	RETURN      0
; end of _init_lcd

_lcd_command:

;eemLCD.c,60 :: 		void lcd_command(int cmd){
;eemLCD.c,61 :: 		LATE  &= 254; //RS = 0
	MOVLW       254
	ANDWF       LATE+0, 1 
;eemLCD.c,62 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_lcd_command1:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_command1
	DECFSZ      R12, 1, 1
	BRA         L_lcd_command1
	NOP
;eemLCD.c,63 :: 		LATD = cmd;
	MOVF        FARG_lcd_command_cmd+0, 0 
	MOVWF       LATD+0 
;eemLCD.c,64 :: 		lcd_enable_pulse();
	CALL        _lcd_enable_pulse+0, 0
;eemLCD.c,66 :: 		}
L_end_lcd_command:
	RETURN      0
; end of _lcd_command

_lcd_enable_pulse:

;eemLCD.c,69 :: 		void lcd_enable_pulse(){
;eemLCD.c,70 :: 		LATE |= 4;
	BSF         LATE+0, 2 
;eemLCD.c,71 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_lcd_enable_pulse2:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_enable_pulse2
	DECFSZ      R12, 1, 1
	BRA         L_lcd_enable_pulse2
	NOP
;eemLCD.c,72 :: 		LATE &= 251;
	MOVLW       251
	ANDWF       LATE+0, 1 
;eemLCD.c,73 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_lcd_enable_pulse3:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_enable_pulse3
	DECFSZ      R12, 1, 1
	BRA         L_lcd_enable_pulse3
	NOP
;eemLCD.c,75 :: 		}
L_end_lcd_enable_pulse:
	RETURN      0
; end of _lcd_enable_pulse

_lcd_print:

;eemLCD.c,77 :: 		void lcd_print(int row, int line, char text[]){
;eemLCD.c,78 :: 		int index = 0;
	CLRF        lcd_print_index_L0+0 
	CLRF        lcd_print_index_L0+1 
;eemLCD.c,79 :: 		int _line = 128 + (64 * line - 64);
	MOVLW       6
	MOVWF       R2 
	MOVF        FARG_lcd_print_line+0, 0 
	MOVWF       R0 
	MOVF        FARG_lcd_print_line+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__lcd_print12:
	BZ          L__lcd_print13
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__lcd_print12
L__lcd_print13:
	MOVLW       64
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       128
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;eemLCD.c,80 :: 		int _row  = row - 1;
	MOVLW       1
	SUBWF       FARG_lcd_print_row+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_lcd_print_row+1, 0 
	MOVWF       R1 
;eemLCD.c,83 :: 		LATE  &= 254; //RS = 0
	MOVLW       254
	ANDWF       LATE+0, 1 
;eemLCD.c,84 :: 		LATD   = _line + _row;
	MOVF        R0, 0 
	ADDWF       R2, 0 
	MOVWF       LATD+0 
;eemLCD.c,85 :: 		lcd_enable_pulse();
	CALL        _lcd_enable_pulse+0, 0
;eemLCD.c,87 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_lcd_print4:
	DECFSZ      R13, 1, 1
	BRA         L_lcd_print4
	DECFSZ      R12, 1, 1
	BRA         L_lcd_print4
	NOP
;eemLCD.c,90 :: 		LATE  |= 1; //RS = 1
	BSF         LATE+0, 0 
;eemLCD.c,91 :: 		for(index = 0; text[index] != 0; index++){
	CLRF        lcd_print_index_L0+0 
	CLRF        lcd_print_index_L0+1 
L_lcd_print5:
	MOVF        lcd_print_index_L0+0, 0 
	ADDWF       FARG_lcd_print_text+0, 0 
	MOVWF       FSR0L+0 
	MOVF        lcd_print_index_L0+1, 0 
	ADDWFC      FARG_lcd_print_text+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_lcd_print6
;eemLCD.c,92 :: 		LATD = text[index];
	MOVF        lcd_print_index_L0+0, 0 
	ADDWF       FARG_lcd_print_text+0, 0 
	MOVWF       FSR0L+0 
	MOVF        lcd_print_index_L0+1, 0 
	ADDWFC      FARG_lcd_print_text+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;eemLCD.c,93 :: 		lcd_enable_pulse();
	CALL        _lcd_enable_pulse+0, 0
;eemLCD.c,91 :: 		for(index = 0; text[index] != 0; index++){
	INFSNZ      lcd_print_index_L0+0, 1 
	INCF        lcd_print_index_L0+1, 1 
;eemLCD.c,94 :: 		}
	GOTO        L_lcd_print5
L_lcd_print6:
;eemLCD.c,97 :: 		}
L_end_lcd_print:
	RETURN      0
; end of _lcd_print
