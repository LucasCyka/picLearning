void main() {
     int low_result;
     int high_result;
     int final_result;
     float f_result = 0;
     
     char txt_result[15];


     //channel select an0
     ADCON0.CHS3 = 0;
     ADCON0.CHS2 = 0;
     ADCON0.CHS1 = 0;
     ADCON0.CHS0 = 0;
     
     //enable A/D
     ADCON0.ADON = 1;
     
     ADCON1 = 0xE; //vdd and vss as reference, an0 is analogic
     
     ADCON2.ADFM = 1; //result if right justified
     
     TRISA |= 1;//RA0 will be input
     
     //starts conversion
     ADCON0.GO = 1;
     
     //starts LCD
     init_lcd();
     lcd_command(0x0C);
     
     for(;;){
     
       while(ADCON0.GO == 1){
          //lcd_print(1,1,"reading...");
       }

       low_result =  ADRESL;
       high_result = ADRESH;
       final_result =  (high_result << 8) | low_result;
       
       delay_ms(100);
       f_result =  (final_result/1023.0) * 5.0;
       txt_result[0] = '0';
       txt_result[1] = '0';
       txt_result[2] = '0';
       txt_result[3] = '0';
       txt_result[4] = '0';
       FloatToStr(f_result,txt_result);

       txt_result[4] = 0;
       lcd_print(1,1,txt_result);
       
       ADCON0.GO = 1;
       delay_ms(100);
       

     
     }

}