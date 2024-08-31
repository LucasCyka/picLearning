void main() {

     TRISB = 255;
     TRISA = 0;
     ADCON1 |= 15;
     INTCON2.RBPU = 0; //enable pull ups for port B
     INTCON.INT0IE = 1; //enable external interrupt int0
     INTCON.INT0IF = 0; //clear interrupt flag
     INTCON2.INTEDG0 = 0;//enable external interrupt 0 for falling edge
     INTCON.GIE = 1;               //enable global interrupts
     
     for(;;){
        //loop and do nothing, wait for interrupt
     }


}

void interrupt(){
   LATA = ~LATA;
   INTCON.INT0IF = 0;
   
   delay_ms(500);
}

