#line 1 "C:/users/Public/Documents/MikroCProjects/lcd/lcd.c"
void init_lcd();
void enable_pulse();
void write_lcd();

char myWord[100] = "Goodbye, World!";
int index = 0;


void main() {


 init_lcd();
 write_lcd();
#line 53 "C:/users/Public/Documents/MikroCProjects/lcd/lcd.c"
}




void init_lcd(){
 TRISE &= 248;
 TRISD = 0;
 LATE &= 248;
 delay_ms(10);


 LATD = 0b00111000;
 enable_pulse();

 LATD = 0b00001111;
 enable_pulse();
 LATD = 0b00111010;
 enable_pulse();


}

void enable_pulse(){
 LATE |= 1;
 delay_ms(50);
 LATE &= 254;
 delay_ms(50);
}

void write_lcd(){
 for(index = 0; index < 17; index++){
 LATE |= 4;
 LATD = myWord[index];
 enable_pulse();

 }


}
