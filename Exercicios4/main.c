void main() {

   //Em um display de 7 segmentos, fa?a um contador de 0 a 9, com intervalo de 500ms entre cada
   //n?mero. O contador deve funcionar em um ciclo de repeti??o infinito, ou seja, ap?s chegar no digito 9 de voltar a contagem para o digito 0.
   //Fa?a a leitura do estado de uma chave e sempre que a mesma for pressionada, a contagem deve parar imediatamente, caso a chave n?o esteja pressionada a contagem deve rodar normalmente.

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