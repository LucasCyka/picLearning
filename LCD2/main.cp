#line 1 "C:/users/Public/Documents/MikroCProjects/LCD2/main.c"
void init_lcd();
void enable_pulse();
void clear();
void cursorHome();
void enableCursor();
void writeLCD(char value[16]);





void main() {
 unsigned char seconds[3];
 unsigned char minutes[3];
 TRISE &= 248;
 TRISD = 0;
 LATE = 0;
 seconds[0] = '0';
 seconds[1] = '0';
 seconds[2] = '|';

 init_lcd();

 for(;;){


 writeLCD(seconds);


 WriteLCD("SECONDS|");
 seconds[1]++;
 if (seconds[1] == ':'){
 seconds[1] = '0';
 seconds[0]++;
 }


 if(seconds[0] == '6'){
 seconds[0] = '0';
 }




 delay_ms(100);
 clear();
 cursorHome();

 }
}

void init_lcd(){
 delay_ms(15);
 LATD = 0x38;
 enable_pulse();
 delay_ms(1);
 LATD = 0x38;
 enable_pulse();

 enableCursor();
 clear();
 cursorHome();

}

void enable_pulse(){
 LATE |= 4;
 delay_ms(30);
 LATE &= 251;
 delay_ms(30);

}

void enableCursor(){
 LATE = 0;
 LATD = 0x0F;
 enable_pulse();
}

void clear(){
 LATE = 0;
 LATD = 0x01;
 enable_pulse();
}

void cursorHome(){
 LATE = 0;
 LATD = 0x02;
 enable_pulse();
}

void writeLCD(char value[16]){
 int index = 0;
 LATE |= 1;


 for(index = 0; index < 15; index++){
 if(value[index] == '|'){
 index = 16;
 }
 LATD = (int)value[index];
 enable_pulse();

 }


}
