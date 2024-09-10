void init_lcd();
void enable_pulse();
void write_lcd();

char myWord[100] = "Goodbye, World!";
int index = 0;


void main() {


     init_lcd();
     write_lcd();
     

       /*
       char character = 'L';
       int  asccode = (int) character;
       TRISE &=  248;
       TRISD  =  0;
       
       LATE = 0;
       
       LATD = 0b00111000;
       LATE |= 1;
       delay_ms(500);
       LATE = 0;
       delay_ms(500);
       
       LATD = 0b00001111;
       delay_ms(500);
       LATE = 1;
       delay_ms(500);
       LATE = 0;
       delay_ms(500);
       LATD = 0b00111010;
       delay_ms(500);
       LATE = 1;
       delay_ms(500);
       LATE = 0;
       delay_ms(500);
       LATE = 0b00000101;
       delay_ms(500);
       LATD = asccode;
       delay_ms(500);
       LATE = 0b00000100;
       delay_ms(500);
       LATE = 0b00000101;
       delay_ms(500);
       LATE = 0b00000100;  */
       
       
}

//RST = RE2 DATA/instruction
//R/W = RE1 always 0
//E   = RE0 fallinge edge pulse
void init_lcd(){
     TRISE &= 248;
     TRISD  = 0;
     LATE  &= 248;
     delay_ms(10);
     
     //init lcd
     LATD  = 0b00111000;
     enable_pulse();
     //cursor
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








