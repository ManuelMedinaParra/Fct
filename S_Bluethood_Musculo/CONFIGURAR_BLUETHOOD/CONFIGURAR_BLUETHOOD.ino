
#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10,11);

 

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
  //Serial.println("Listo");
  BTSerial.begin(38400);
}

void loop() {
  // put your main code here, to run repeatedly:

   if (BTSerial.available())
  {
    Serial.write(BTSerial.read());
  }
    
   if (Serial.available())
{
   BTSerial.write(Serial.read());
   
  }



}
