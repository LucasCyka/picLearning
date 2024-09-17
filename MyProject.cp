#line 1 "C:/users/Public/Documents/MikroCProjects/MyProject.c"
void main() {
 char botaoEstado = 0;
 char botaoComutado = 0;
 char ledEstado = 0;

 PORTB.RBPU = 1;
 ADCON1 = 15;
 TRISB = 1;
 TRISA = 0;


 for(;;){

 if(PORTB & 1){
 botaoEstado = 1;
 delay_ms(10);
 }else{
 botaoEstado = 0;
 delay_ms(10);
 }

 if(botaoEstado == 1 && ledEstado == 0 && botaoComutado == 0){
 botaoComutado = 1;
 ledEstado = 1;
 }else if(botaoEstado == 1 && ledEstado == 1 && botaoComutado == 0){
 ledEstado = 0;
 botaoComutado = 1;
 }

 if(botaoComutado == 1 && !(PORTB & 1)){
 botaoComutado = 0;
 }

 LATA = ledEstado;

 }


}
