void main() {

   //Em um display de 7 segmentos, faça um contador de 0 a 9, com intervalo de 500ms entre cada
   //número. O contador deve funcionar em um ciclo de repetição infinito, ou seja, após chegar no digito 9 de voltar a contagem para o digito 0.
   //Faça a leitura do estado de uma chave e sempre que a mesma for pressionada, a contagem deve parar imediatamente, caso a chave não esteja pressionada a contagem deve rodar normalmente.
   
   unsigned char numbers[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x98};
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
    LATD = numbers[index];
    
    delay_ms(500);




   }



   //Faça um contador binário de 5 bits (O contador deve funcionar em um ciclo de repetição infinito).
   /*
   unsigned char num = 1;
   int i = 0;
   ADCON1 = 0X0F;
   TRISA  = 0;
   
   for(;;){

    for(i = 0; i < 31; i++){
       LATA = num;
       delay_ms(1000);
       num += 1;
    }
    
    num = 0;

   
   }**/
   

   /**
   //Crie um programa para gerar uma onda quadrada com frequência de 100hz
   //Meça com o osciloscópio/multímetro para verificar o valor da frequência.

   TRISA = 0;
   
   for(;;){
    LATA ^= 1; //toggle RA0
    delay_ms(5);
    LATA ^= 1;
    delay_ms(5);
    
    
   }**/

   /**
   //Ler o estado de uma chave, quando a chave for pressionada todos os LEDs devem piscar a cada 1 segundo caso a chave não seja pressionada todos os LEDs devem piscar a cada 100 ms.
   ADCON1 |= 0xF;
   TRISB = 255;
   TRISA = 0;
   TRISC = 0;
   
   for(;;){
    LATA ^= 255;
    LATC ^= 255;
    if(~PORTB & 1){
       delay_ms(1000);
    }else{
       delay_ms(100);
    }
   }
    **/
   /**
   //Ler o estado de duas chaves e ligar um led (RD0) quando qualquer um dos dois botões forem pressionados.
   ADCON1 |= 0xF;
   TRISB = 255;
   TRISA = 0;
   
   for(;;){
    if(~PORTB & 1 || ~PORTB & 2){
     LATA |= 3;
    }
    else{
     LATA &= 252;
    }
   }  **/

   /**
   //Ler o estado de duas chaves e ligar um LED apenas quando os dois botões forem pressionados ao mesmo tempo.
   ADCON1 |= 0xF;
   TRISB = 255;
   TRISA = 0;
   
   for(;;){
    if((~PORTB & 1) && (~PORTB & 2)){
     LATA |= 1; //turn on
    }else{
     LATA &= 0xFE; //turn off
    }
   } **/
   
   


   /**
   //Quando uma chave for pressionada (chave envia VCC) deve ligar um LED e quando a chave não for pressionada (chave envia GND) deve desligar o LED.
   ADCON1 |= 0xF;
   
   TRISA = 0;
   TRISB = 255;
   INTCON2.RBPU = 1; //disable weak internal pull ups
   
   for(;;){
      if(PORTB & 4){
         LATA |= 1;
      }else{
         LATA ^= 1; //xor
      }

   }**/
   

   //Ligar os 4 primeiros LEDs e desligar os 4 últimos LEDs.
   /**
   TRISA =  0;
   TRISC = 0;
   
   for(;;){
      LATA = 0xF;
      LATC = 0;
   }**/


}