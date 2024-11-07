void main() {
     ADCON1 = 0x0F;
     TRISB  = 0;
     
     PWM1_Init(5000);
     
     PWM1_Set_Duty(128);
     
     PWM1_Start();
     
     
}