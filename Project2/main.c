void init_interrupt();

int modifier = -1;
int num = 0;
char numCodes[10] = {63,6,91,79,102,109,125,7,127,103};

void main() {

   ADCON1      |= 15; //sets all pins as digital i/o
   TRISB       |= 1; //sets RB0 as input
   TRISD        = 0; //all pins at port d are outputs for the 7-seg
   INTCON2.RBPU = 0; //enable weak interal pullups for port b
   LATD = 0;

   init_interrupt();

   //loop
   for(;;){
      num += modifier;
      if(num == -1) {num = 9;}
      else if(num == 10){num = 0;}
      
      LATD = numCodes[num];
      

      
      
      delay_ms(1000);
      
      
   }

}

//enable external interrupt
void init_interrupt(){
   INTCON.INT0IF = 0; //clear interrupt flag
   INTCON2.INTEDG0 = 0; //interrupt 0 uses falling edge
   INTCON.INT0IE = 1;//enables INT0 external interrupt
   INTCON.INT0IF = 0; //clear interrupt flag
   INTCON.GIEH = 1; //enables global interrupts


}

void interrupt(){
   INTCON.INT0IF = 0;

   modifier *= -1;
   

}