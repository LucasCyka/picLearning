#line 1 "C:/users/Public/Documents/MikroCProjects/MotorLDR/MotorLDR.c"

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

int value = 0;
char txtValue[5];

void ConIntToStr(int FromInt, char *ToStr);
float map(int value);

void main() {



 TRISE &= 253;
 LATE &= 253;
 LATA &= 253;
 TRISA |= 1;
 TRISA &= 253;

 delay_ms(10);
 ADC_init();
 lcd_init();

 for(;;){
 value = map(ADC_Read(0));

 ConIntToStr(value,txtValue);

 lcd_out(2,1,txtValue);
 delay_ms(1);


 if(value >= 150){
 lcd_out(1,1,"Motor Ligado");
 LATA |= 2;
 }else{
 lcd_out(1,1,"Motor Desligado");
 LATA &= 253;
 }

 delay_ms(200);

 lcd_cmd(_LCD_CLEAR);
 lcd_cmd(_LCD_CURSOR_OFF);

 }

}

void ConIntToStr(int FromInt, char *ToStr){
 int index = 3;
 int num = FromInt;

 for(index = 3; index > -1 ; index--){
 ToStr[index] = (char)(num % 10)+'0';
 num /= 10;
 }

 ToStr[4] = 0;
}

float map(int value){

 return (float) (200-100)/(1023) * value + 100;


}
