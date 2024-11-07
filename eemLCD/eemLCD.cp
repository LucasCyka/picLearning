#line 1 "C:/users/Public/Documents/MikroCProjects/eemLCD/eemLCD.c"
#line 25 "C:/users/Public/Documents/MikroCProjects/eemLCD/eemLCD.c"
void init_lcd();
void lcd_command(int cmd);
void lcd_enable_pulse();
void lcd_print(int row, int line, char text[]);
#line 45 "C:/users/Public/Documents/MikroCProjects/eemLCD/eemLCD.c"
void init_lcd(){
 TRISE &= 248;
 TRISD = 0;
 delay_ms(10);

 lcd_command( 0x38 );
 lcd_command( 0x0C );
 lcd_command( 0x0F );
 lcd_command( 0x02 );
 lcd_command( 0x01 );


}


void lcd_command(int cmd){
 LATE &= 254;
 delay_ms(10);
 LATD = cmd;
 lcd_enable_pulse();

}


void lcd_enable_pulse(){
 LATE |= 4;
 delay_ms(10);
 LATE &= 251;
 delay_ms(10);

}

void lcd_print(int row, int line, char text[]){
 int index = 0;
 int _line = 128 + (64 * line - 64);
 int _row = row - 1;


 LATE &= 254;
 LATD = _line + _row;
 lcd_enable_pulse();

 delay_ms(10);


 LATE |= 1;
 for(index = 0; text[index] != 0; index++){
 LATD = text[index];
 lcd_enable_pulse();
 }


}
