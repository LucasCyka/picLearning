/*******************************************************************************
  Minha biblioteca de LCD para as aulas de EEM1.

  Autor: Lucas Santos
  Data: 29/09/24

  RS  - RE0
  RW - RE1 (enviar 0)
  EN  - RE2

*******************************************************************************/

//*****COMMANDS*****//
#define _lcd_start 0x38
#define _lcd_display_on 0x0C
#define _lcd_cursor_blink 0x0F
#define _lcd_cursor_home 0x02
#define _lcd_clear 0x01
#define _lcd_shift_right 0x1C
#define _lcd_shift_left  0x18

//*****************//


void init_lcd();
void lcd_command(int cmd);
void lcd_enable_pulse();
void lcd_print(int row, int line, char text[]);

//void main() {
     //*****debug only, user should modify this *****//
//     ADCON1 = 0x0F;

//     init_lcd();

//     lcd_print(8,2,"wassup");
     //lcd_command(_lcd_shift_left);
     //lcd_command(_lcd_shift_left);
     //lcd_command(_lcd_shift_left);
     //*****debug only, user should modify this *****//

//}   //***


void init_lcd(){
  TRISE &= 248;
  TRISD  = 0;
  delay_ms(10);

  lcd_command(_lcd_start);
  lcd_command(_lcd_display_on);
  lcd_command(_lcd_cursor_blink);
  lcd_command(_lcd_cursor_home);
  lcd_command(_lcd_clear);


}

//sends command to lcd
void lcd_command(int cmd){
  LATE  &= 254; //RS = 0
  delay_ms(10);
  LATD = cmd;
  lcd_enable_pulse();

}

//enable pulse
void lcd_enable_pulse(){
  LATE |= 4;
  delay_ms(10);
  LATE &= 251;
  delay_ms(10);

}

void lcd_print(int row, int line, char text[]){
  int index = 0;
  int _line = 128 + (64 * line - 64);
  int _row  = row - 1;
  
  //sets cursor to line and row selected
  LATE  &= 254; //RS = 0
  LATD   = _line + _row;
  lcd_enable_pulse();
  
  delay_ms(10);
  
  //print characters
  LATE  |= 1; //RS = 1
  for(index = 0; text[index] != 0; index++){
   LATD = text[index];
   lcd_enable_pulse();
  }


}