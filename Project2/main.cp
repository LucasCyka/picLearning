#line 1 "C:/users/Public/Documents/MikroCProjects/Project2/main.c"
void init_interrupt();

int modifier = -1;
int num = 0;
char numCodes[10] = {63,6,91,79,102,109,125,7,127,103};

void main() {

 ADCON1 |= 15;
 TRISB |= 1;
 TRISD = 0;
 INTCON2.RBPU = 0;
 LATD = 0;

 init_interrupt();


 for(;;){
 num += modifier;
 if(num == -1) {num = 9;}
 else if(num == 10){num = 0;}

 LATD = numCodes[num];




 delay_ms(1000);


 }

}


void init_interrupt(){
 INTCON.INT0IF = 0;
 INTCON2.INTEDG0 = 0;
 INTCON.INT0IE = 1;
 INTCON.INT0IF = 0;
 INTCON.GIEH = 1;


}

void interrupt(){
 INTCON.INT0IF = 0;

 modifier *= -1;


}
