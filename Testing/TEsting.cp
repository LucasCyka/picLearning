#line 1 "C:/users/Public/Documents/MikroCProjects/Testing/TEsting.c"
void main() {

 ADCON1 = 0x0F;

 init_lcd();

 lcd_print(1,1,"Testando minha biblioteca!");


}
