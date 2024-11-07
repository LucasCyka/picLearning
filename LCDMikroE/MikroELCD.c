//bit connections with lcd library
sbit LCD_D7 at RD7_BIT;
sbit LCD_D6 at RD6_BIT;
sbit LCD_D5 at RD5_BIT;
sbit LCD_D4 at RD4_BIT;

sbit LCD_RS at RE0_BIT;
sbit LCD_EN at RE2_BIT;

sbit LCD_RS_Direction at TRISE0_BIT;
sbit LCD_EN_Direction at TRISE2_BIT;
sbit LCD_D7_Direction at TRISD7_BIT;
sbit LCD_D6_Direction at TRISD6_BIT;
sbit LCD_D5_Direction at TRISD5_BIT;
sbit LCD_D4_Direction at TRISD4_BIT;


/***
RS  - RE0
RW - RE1 (enviar 0)
EN  - RE2
***/

void main() {

     ADCON1 = 0x0F;
     
     Lcd_Init();
     delay_ms(20);
     
     Lcd_Cmd(_LCD_CLEAR);
     delay_ms(20);
     
     Lcd_Out(1,1,"Testing MIKROE");
     Lcd_Out(2,1,"LCD Library");
     
     Lcd_Cmd(_LCD_SHIFT_RIGHT);
     


}