#include "ListLib.h"
#include <EEPROM.h>
int entrada=A0;
int enviar=12;
int salida=13;
int value=0;
int  Alpha= 0;
int grados= 0;
int contador=0;
char Se_Envia[10]    ; // dato enviado en forma de caracter
char Se_Envia1[10]   ; // dato enviado en forma de caracter
//List<int> list;



void setup() {
  // put your setup code here, to run once:
  
  pinMode(entrada, INPUT);
  pinMode(enviar, INPUT);
  pinMode(salida, OUTPUT);
  Serial.begin(9600);
 
}

void loop() {
  // put your main code here, to run repeatedly:
   
  value= analogRead(entrada);
  contador=contador +1;
   
  //Con esta parte le enviapos al serial ploter un valor para que realice la grafiva(Picos)
  
  ///////////////////////////////////////////////////////////////
  //Serial.println("Empezar trama");
  //Serial.println(Alpha);
  //Serial.print("DATA,TIME,TIMER,"); 
  //escribe el tiempo en la columna A y el tiempo en segundos 
  // desde la primera medida en la columna B
  //dtostrf(value, 5 , 3 , Se_Envia);// se convierte a carácter
  //dtostrf(contador, 5 , 3 , Se_Envia1);
  Serial.println(value);      
  //Serial.print(",");
  //Serial.println(Se_Envia1);
  
  delay(1);
  }
    
 
