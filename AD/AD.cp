#line 1 "C:/users/Public/Documents/MikroCProjects/AD/AD.c"
void main() {

 ADCON1 = 14;
 ADCON0 &= 195;
 ADCON0 |= 1;
 TRISA = 1;

 for(;;){

 if(ADRES >= 100){
 LATA.RA1 = 1;
 }else{
 LATA.RA1 = 0;
 }

 }





}
