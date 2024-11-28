
// Lcd pinout settings
sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE2_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE2_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

//function prototypes
void setup();

//data
char TMR0_txt[7];
char *TMR0_txt_trimmed;
int  TMR0Val = 0;

void main() {
   setup();
   
   for(;;){

     delay_ms(1000);
     Lcd_Cmd(_LCD_CLEAR);
     TMR0Val = (TMR0H << 8) | TMR0L;

     TMR0H = 0x00;
     TMR0L = 0x00;
     //RPS to RPM
     TMR0Val *= 60;

     IntToStr(TMR0Val,TMR0_txt);
     TMR0_txt_trimmed = Ltrim(TMR0_txt);
     
     
     lcd_out(1,1,TMR0_txt_trimmed);
     lcd_out(1,7,"RPM");
     
     TMR0Val = 0;
   
   }

}

void setup(){
   ADCON1 |= 0x0F;
   TRISA  |= 0x10;
   TRISC  &= 0xFB;
   
   //turn on motor
   LATC |= 0x04;
   
   //config lcd
   TRISE &= 0x02;
   LATE   = 0x00;
   
   Lcd_init();
   Lcd_Cmd(_LCD_CURSOR_OFF);

   
   //config timer0 as counter
   T0CON.TMR0ON = 1; //turn timer on
   T0CON.T08BIT = 0; //use it as 16bit
   T0CON.T0CS   = 1; //as counter on t0CKI
   T0CON.T0SE   = 1; //rising edge
   T0CON.PSA    = 1; //do not use prescaler
   TMR0H        = 0x00;
   TMR0L        = 0x00;
   //config timer0 interrupt
   
   
   
   
}