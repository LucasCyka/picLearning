/***********************************************************
*                                                          *
*    Aluno:       Lucas Santos                             *
*    Professor:   Paulo Y.                                 *
*    Escola:      Senai "Anchieta"                         *
*    Assunto:     interruptores, conversor AD e LCD.       *
*    Data:        18/11/2024                               *
*                                                          *
************************************************************/

#define RED            2
#define GREEN          4
#define BLUE           8
#define PURPLE         10
#define SCREENS_NUMBER 4
#define TRUE           1
#define FALSE          0
#define ADC_CHANNEl    0

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
void init_lcd();
void init_adc();
void init_interrupts();
void update_screen();
void convert_int_to_str(int fromInt, char *toStr);
float map(int value);

//screens
typedef struct SCR{
   char message1[16];
   char message2[16];
   int led_color;
   int ADC;
}Screen;

Screen screens[] = {
  {"TELA 1 ","LED VERMELHA",RED,FALSE},
  {"TELA 2 ","LED VERDE",GREEN,FALSE},
  {"TELA 3 ","LED AZUL",BLUE,FALSE},
  {"TELA 4 - ADC ","LEITURA: ",PURPLE,TRUE}
};

int current_screen     = -1;
int next_screen        =  0;
int adc_enabled        =  FALSE;
int adc_reading        =  0;
int adc_reading_mapped = 0;
int adc_txt[5];


void interrupt(){
   if(INTCON.INT0F){
      INTCON.INT0E = 0;
      INTCON.INT0F = 0;
      next_screen++;
      next_screen -= ((next_screen > (SCREENS_NUMBER-1)) * next_screen);
   }
}

void main() {
   ADCON1 |= 0x0E; //adicionar no somente no picsimlab
   TRISB  |= 0x01;
   TRISA  |= 0x01; //RA0 - AN0
   TRISA  &= 0xF1; //RGB led
   LATA   &= 0xF8;
   init_lcd();
   init_adc();
   init_interrupts();
   delay_ms(10);

   for(;;){ //main loop
      if(!INTCON.INT0E){ //DEBOUNCE
       delay_ms(150);
       if(!PORTB.RB0){
          INTCON.INT0F = 0;
          INTCON.INT0E = 1;
       }
      }
      
      if(current_screen != next_screen){
         update_screen();
      }
      
      if(adc_enabled){
        adc_reading = ADC_read(ADC_CHANNEl);
        adc_reading_mapped = map(adc_reading);
        adc_reading = adc_reading_mapped;

        //map(int value, int fromLow, int fromHigh, int toLow, int toHigh)
        convert_int_to_str(adc_reading,adc_txt);
        lcd_out(2,10,adc_txt);
        delay_ms(200);
      }
      
   }

}

void init_lcd(){
   //RE1 = RW
   TRISE &= 0xFD;
   LATE  &= 0xFD;
   
   lcd_init();
   delay_ms(10);
   lcd_cmd(_LCD_TURN_ON);
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_out(1,1,screens[0].message1);
   
}

void init_interrupts(){
   INTCON.INT0IF    = 0; //clear INT0 flag
   INTCON.INT0IE    = 1; //INT0 interrupt enable
   INTCON2.INTEDG0  = 0; //INT0 on falling edge
   INTCON.GIE       = 1; //init global interrupts

}

void init_adc(){
   ADC_init();

}

void convert_int_to_str(int fromInt, char *toStr){
   int index = 3;
   int num   = fromInt;

   for(index  = 3; index >= 0; index--){
    toStr[index] = (char)(num % 10 + '0');
    num /= 10;
   }
   //toStr[4] = 0; hmmmm
   
}

void update_screen(){
   lcd_cmd(_LCD_CLEAR);
   current_screen = next_screen;
   
   lcd_out(1,1,screens[current_screen].message1);
   lcd_out(2,1,screens[current_screen].message2);
   LATA &= 0x01;
   LATA |= screens[current_screen].led_color;
   adc_enabled = screens[current_screen].ADC;
   
}

float map(int value){
   return (float)value /1023 * 500;
}