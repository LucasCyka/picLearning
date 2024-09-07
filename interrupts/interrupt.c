void init_interrupt();

void main() {

     ADCON1 |= 15;
     TRISA  &= 252;
     TRISB  |= 1;
     INTCON2.RBPU = 1; //disable internal pullups for port b
     init_interrupt();
     
     for(;;){
      LATA ^= 1;
      delay_ms(1000);
     }

}

void init_interrupt(){
     INTCON2.INTEDG0 = 1; //rising edge external interrupt 0
     INTCON.INT0IE   = 1; //enables int0 external interrupt
     INTCON.INT0IF   = 0; //interrupt flag, mut be cleared always when theres a interrupt
     INTCON.GIEH     = 1; //enable global interrupts

}

void interrupt(void){
     if(INTCON.INT0IF){
      LATA         ^= 2;
      delay_ms(10);
      INTCON.INT0IF = 0;
     }

}