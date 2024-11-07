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

int counter = 0;
char counterTxt[7];
char *counterTxtTrim;
char lastScreen = -1;

void init_interrupts();
void screen1();
void screen2();
void screen3();

void interrupt(){
   if(INTCON.INT0IF){
     INTCON.INT0IF = 0;
     INTCON.INT0IE = 0;
     counter++;
   }

}

void main() {
   ADCON1 = 0x0F;
   TRISB |= 0x01;
   init_interrupts();
   Lcd_Init();
   delay_ms(10);
   lcd_cmd(_LCD_CURSOR_OFF);


   for(;;){
     IntToStr(counter,counterTxt);
     counterTxtTrim = ltrim(counterTxt);
     lcd_out(2,1,counterTxtTrim);
     delay_ms(30);
     
     switch (counter){
        case 0:
          screen1();
          break;
        case 1:
          screen2();
          break;
        case 2:
          screen3();
          break;
        case 3:
          counter = 0;
     }
     
     if(!INTCON.INT0IE){ //interrupt has been disabled/buttons has been pressed
       delay_ms(30); //deboucing
       if(!PORTB.RB0){
          INTCON.INT0IF = 0;
          INTCON.INT0IE = 1;
       }
     }
     
   }
   
}

void init_interrupts(){
   INTCON.INT0IE = 1;  //enable int0 interrupts
   INTCON.INT0IF = 0;  //clear intterupt flag
   INTCON.INTEDG0 = 1; //int0 is enabled on rising edge
   INTCON.GIE = 1;     //enable global interrupts
}

void screen1(){
   if(lastScreen != 0){
     lastScreen = 0;
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1,1,"Pronto");
   }
}

void screen2(){
   if(lastScreen != 1){
     lastScreen = 1;
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1,1,"Emergencia");
   }
}

void screen3(){
   if(lastScreen != 2){
     lastScreen = 2;
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1,1,"Manutencao");
   }
}








