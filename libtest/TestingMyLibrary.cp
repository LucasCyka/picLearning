#line 1 "C:/users/Public/Documents/MikroCProjects/libtest/TestingMyLibrary.c"
void main() {
 char *mystr[4] = "0000";
 float _previous_read = 0;
 float value = 0;

 ADCON1 = 14;

 init_lcd();


 ADC_Init();

 for(;;){
 value = ADC_Read(0);
 if(_previous_read != value){
 _previous_read = value;
 FloatToStr(value,*mystr);
 lcd_print(1,1,*mystr);

 }


 delay_ms(10);
 }



}
