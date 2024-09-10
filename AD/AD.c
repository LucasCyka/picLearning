void main() {

   ADCON1  = 14;
   ADCON0 &= 195;   //Selects channel0 (AN0)
   ADCON0  |= 1;    //enable converter module
   TRISA    = 1;
   
   for(;;){
   
    if(ADRES >= 100){
     LATA.RA1 = 1;
    }else{
     LATA.RA1 = 0;
    }
   
   }
   

   


}