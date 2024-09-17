EXERCICIO 9:

void main() {

   //Em um display de 7 segmentos, fa?a um contador de 0 a 9, com intervalo de 500ms entre cada
   //número. O contador deve funcionar em um ciclo de repetição infinito, ou seja, após chegar no digito 9 de voltar a contagem para o digito 0.
   //Faça a leitura do estado de uma chave e sempre que a mesma for pressionada, a contagem deve parar imediatamente, caso a chave não esteja pressionada a contagem deve rodar normalmente.

   unsigned char numeros[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x98};
   unsigned char index = 0;
   TRISD = 0;
   TRISB = 1;
   ADCON1= 15;
   for(;;){

    if(PORTB & 1){
     index++;
    }

    if (index >= 10){
     index = 0;
    }
    LATD = numeros[index];

    delay_ms(500);




   }

}


EXERCICIO 10:


//10 - Faça a leitura de uma chave push button, quando for pressionado deve ligar um LED e permanecer ligado mesmo após soltar o botão.
//Quando o botão for pressionado pela segunda vez deve ser desligado o LED.

//nota: utilizar resistor pull-down externo

void main() {
     char botaoEstado   = 0;
     char botaoComutado = 0;   //Só irá permitir a comutação da led caso o usuario comute o botão (de 1 para 0).
     char ledEstado     = 0;

     PORTB.RBPU = 1; //desativa pull-ups internos da porta b
     ADCON1 = 15;
     TRISB  = 1;
     TRISA  = 0;


     for(;;){

      if(PORTB & 1){
        botaoEstado = 1;
        delay_ms(10);   //debounce
      }else{
        botaoEstado = 0;
        delay_ms(10);  //debounce
      }

      if(botaoEstado == 1 && ledEstado == 0 && botaoComutado == 0){ //botao está pressionado, led está apagada e o botão ainda não foi pressionado
       botaoComutado = 1; //botão foi pressionado.
       ledEstado = 1;     //acende led
      }else if(botaoEstado == 1 && ledEstado == 1 && botaoComutado == 0){  //botao está pressionado, led está acesa e o botão ainda não foi pressionado
       ledEstado = 0;    //apaga led
       botaoComutado = 1;   //botão foi pressionado.
      }

      if(botaoComutado == 1 && !(PORTB & 1)){ //botão que tinha sido pressionado foi comutado
       botaoComutado = 0;
      }

      LATA = ledEstado;

     }


}