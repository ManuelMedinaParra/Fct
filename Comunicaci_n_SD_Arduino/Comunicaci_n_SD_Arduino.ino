/*
  Capitulo 37 de Arduino desde cero en Español.
  Mediante un modulo lector de memoria MicroSD conectado mediante interfaz SPI
        crearemos un archivo de texto con los datos separados por comas (CSV) de los valores
  de temperatura y humedad leidos de un modulo sensor DHT11 (KY-015) a intervalos
  de 1 segundo. Requiere instalar librerias DHT de Adafruit.

  Autor: bitwiseAr  

*/

#include <SPI.h>    // incluye libreria interfaz SPI
#include <SD.h>     // incluye libreria para tarjetas SD
#include <DHT.h>    // incluye libreria DHT de Adafruit
#include <DHT_U.h>    // incluye libreria Adafruit Unified Sensor

#define SENSOR 4    // constante SENSOR en pin digital 4 (senal de DHT11)
int TEMPERATURA;    // variable para almacenar valor de temperatura
int HUMEDAD;      // variable para almacenar valor de humedad

#define SSpin 10    // Slave Select en pin digital 10

File archivo;     // objeto archivo del tipo File
DHT dht(SENSOR, DHT11);   // objeto dht del tipo DHT en pin 4 y modelo DHT11

void setup() {
  Serial.begin(9600);   // inicializa monitor serie a 9600 bps
  dht.begin();      // inicializacion de sensor

  Serial.println("Inicializando tarjeta ...");  // texto en ventana de monitor
  if (!SD.begin(SSpin)) {     // inicializacion de tarjeta SD
    Serial.println("fallo en inicializacion !");// si falla se muestra texto correspondiente y
    return;         // se sale del setup() para finalizar el programa
  }
  Serial.println("inicializacion correcta");  // texto de inicializacion correcta
  archivo = SD.open("datos.txt", FILE_WRITE); // apertura para lectura/escritura de archivo datos.txt

  if (archivo) {  
    for (int i=1; i < 31; i++){     // bucle repite 30 veces
      TEMPERATURA = dht.readTemperature();  // almacena en variable valor leido de temperatura
      HUMEDAD = dht.readHumidity();   // almacena en variable valor leido de humedad

      archivo.print(i);       // escribe en tarjeta el valor del indice
      archivo.print(",");     // escribe en tarjeta una coma
      archivo.print(TEMPERATURA);   // escribe en tarjeta el valor de temperatura
      archivo.print(",");     // escribe en tarjeta una coma
      archivo.println(HUMEDAD);     // escribe en tarjeta el valor de humedad y salto de linea

      Serial.print(i);        // escribe en monitor el valor del indice
      Serial.print(",");      // escribe en monitor una coma
      Serial.print(TEMPERATURA);    // escribe en monitor el valor de temperatura
      Serial.print(",");      // escribe en monitor una coma
      Serial.println(HUMEDAD);      // escribe en monitor el valor de humedad y salto de linea

      delay(1000);        // demora de 1 segundo
      }
    archivo.close();        // cierre de archivo
    Serial.println("escritura correcta"); // texto de escritura correcta en monitor serie
  } else {
    Serial.println("error en apertura de datos.txt"); // texto de falla en apertura de archivo
  }
}

void loop() {     // funcion loop() obligatoria de declarar pero no utilizada
  // nada por aqui
}
