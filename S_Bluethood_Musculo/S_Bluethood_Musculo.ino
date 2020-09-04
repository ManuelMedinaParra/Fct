#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10,11);
int entrada=A0;
int value=0;

void setup() {
  pinMode(entrada, INPUT);
  Serial.begin(9600);
  //Serial.println("Listo");
  BTSerial.begin(57600);
}

void loop() {
  // put your main code here, to run repeatedly:
   
  
 if (BTSerial.available())
  {
    //Serial.println(BTSerial);
    value=analogRead(entrada); 
    BTSerial.println(value);
    Serial.println("Envio");
    BTSerial.flush();
  }
 else{
  Serial.println("No Envio");
 
    
  }
   //if (Serial.available())
//{
   //BTSerial.write(Serial.read());
 //}
  
//}



    //BTSerial.write(";");
   //BTSerial.write("\n");
   //Serial.println(value);
delay(1);
}
