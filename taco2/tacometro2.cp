#line 1 "C:/users/Public/Documents/MikroCProjects/taco2/tacometro2.c"

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


void setup();


char TMR0_txt[7];
char *TMR0_txt_trimmed;
int TMR0Val = 0;
int mseconds = 0;
char mseconds_txt[7];


void interrupt(){
 if(PIR1.TMR1IF == 1 && PIE1.TMR1IE == 1){
 TMR1H = 0xEC;
 TMR1L = 0x79;
 PIR1.TMR1IF = 0;
 mseconds++;

 }
}

void main() {
 setup();

 for(;;){
 IntToStr(mseconds,mseconds_txt);
 lcd_out(1,1,mseconds_txt);

 if(mseconds >= 1000){
 mseconds = 0;

 }


 LATC |= 0x04;
 delay_us(500);
 LATC = 0x00;
 delay_us(500);

 }

}

void setup(){
 ADCON1 |= 0x0F;
 TRISA |= 0x10;
 TRISC &= 0xFB;


 LATC |= 0x04;


 TRISE &= 0x02;
 LATE = 0x00;

 Lcd_init();
 Lcd_Cmd(_LCD_CURSOR_OFF);



 T0CON.TMR0ON = 1;
 T0CON.T08BIT = 0;
 T0CON.T0CS = 1;
 T0CON.T0SE = 1;
 T0CON.PSA = 1;
 TMR0H = 0x00;
 TMR0L = 0x00;



 T1CON.RD16 = 1;
 T1CON.T1CKPS0 = 0;
 T1CON.T1CKPS1 = 0;
 T1CON.TMR1CS = 0;
 T1CON.T1RUN = 0;
 T1CON.TMR1ON = 1;
 TMR1H = 0xEC;
 TMR1L = 0x79;


 INTCON.GIEH = 1;
 INTCON.PEIE = 1;
 PIR1.TMR1IF = 0;
 PIE1.TMR1IE = 1;
 IPR1.TMR1IP = 1;




}
