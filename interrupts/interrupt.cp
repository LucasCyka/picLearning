#line 1 "C:/users/Public/Documents/MikroCProjects/interrupts/interrupt.c"
void init_interrupt();

void main() {

 ADCON1 |= 15;
 TRISA &= 252;
 TRISB |= 1;
 INTCON2.RBPU = 1;
 init_interrupt();

 for(;;){
 LATA ^= 1;
 delay_ms(1000);
 }

}

void init_interrupt(){
 INTCON2.INTEDG0 = 1;
 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;
 INTCON.GIEH = 1;

}

void interrupt(void){
 if(INTCON.INT0IF){
 LATA ^= 2;
 delay_ms(10);
 INTCON.INT0IF = 0;
 }

}
