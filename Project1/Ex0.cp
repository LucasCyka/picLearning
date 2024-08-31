#line 1 "C:/users/Public/Documents/MikroCProjects/Project1/Ex0.c"
void main() {

 TRISB = 255;
 TRISA = 0;
 ADCON1 |= 15;
 INTCON2.RBPU = 0;
 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;
 INTCON2.INTEDG0 = 0;
 INTCON.GIE = 1;

 for(;;){

 }


}

void interrupt(){
 LATA = ~LATA;
 INTCON.INT0IF = 0;

 delay_ms(500);
}
