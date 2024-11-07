#line 1 "C:/users/Public/Documents/MikroCProjects/cron/cr.c"
sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE2_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE2_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

int seconds = 0;
int minutes = 0;
char txt_seconds[7];
char txt_minutes[7];

void main() {
 ADCON1 = 0x0F;
 TRISE.RE1 = 0;
 TRISB.RB0 = 1;
 LATE.RE1 = 0;

 lcd_init();
 Lcd_Cmd(_LCD_CURSOR_OFF);

 for(;;){





 if(PORTB.RB0 == 0){
 delay_ms(800);
 seconds++;
 if(seconds == 60){
 seconds = 0;
 minutes++;
 }

 if(minutes == 60){
 minutes = 0;
 }
 }



 IntToStr(seconds,txt_seconds);
 IntToStr(minutes,txt_minutes);

 if (minutes < 10){
 txt_minutes[4] = '0';
 }
 if (seconds < 10){
 txt_seconds[4] = '0';
 }


 ltrim(txt_minutes);
 ltrim(txt_seconds);


 lcd_out(1,1,txt_minutes);
 lcd_out(1,3,":");
 lcd_out(1,4,txt_seconds);

 }



}
