
_main:

;TEsting.c,1 :: 		void main() {
;TEsting.c,3 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;TEsting.c,5 :: 		init_lcd();
	CALL        _init_lcd+0, 0
;TEsting.c,7 :: 		lcd_print(1,1,"Testando minha biblioteca!");
	MOVLW       1
	MOVWF       FARG_lcd_print_row+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_row+1 
	MOVLW       1
	MOVWF       FARG_lcd_print_line+0 
	MOVLW       0
	MOVWF       FARG_lcd_print_line+1 
	MOVLW       ?lstr1_TEsting+0
	MOVWF       FARG_lcd_print_text+0 
	MOVLW       hi_addr(?lstr1_TEsting+0)
	MOVWF       FARG_lcd_print_text+1 
	CALL        _lcd_print+0, 0
;TEsting.c,10 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
