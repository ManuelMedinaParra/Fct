


function voltaje=ADC_Serial2(muestras) %la funcion recibe el # de muestras que debe tomar

close all; %Cierra todo lo que matlab tenga abierto
clc; %limpiar la pantalla
voltaje=0;%Declara variable en la cual se van a guardar los valores
%voltaje1=0;%Declara variable en la que se van a guardar los datos de la primera señal
% voltaje2=0;%Declara variable en la que se van a guardar los datos de la segunda señal
Q=0;
%Borra datos que se encuentren previos y vuelve a declarar el puerto y la
%velocidad de transmisión

% --- Executes on button press in togglebutton1.

delete(instrfind({'port'},{'COM6'})); %borrar cualquier puerto serial abierto
puerto=serial('COM6'); %declaro variable llamada puerto y se crea el com4
puerto.BaudRate=2000000; %Establecer velocidad de transmisión

fopen(puerto);%abre el puerto a utilizar
contador=1;
VecV= zeros();
%VecGrafica= zeros();
tiempo_inicio = cputime
VecV(contador,2)= tiempo_inicio
%configura la ventana donde se va a mostrar la grafica
% figure('Name','Grafica de dos señales')%Nombre de la ventana
% title('GRAFICA DE DOS SEÑALES'); %Titulo de la grafica
% xlabel('Numero de Muestras'); %Leyenda o titulo del eje x
% ylabel('Voltaje (V)'); %Leyenda o titulo en el eje y
 %grid on; %Apagar cuadricula
 %hold on;
%Ciclo para capturando valores e ir realizando la grafica paso a paso
while contador<=muestras
    %xlim([0 (contador/100)])
    %ylim([-1 1])
    valorADC=fscanf(puerto,'%d%d');%Toma el valor recibido por el puerto y lo guarda en la variable
    %voltaje(contador)=valorADC(1)*5/1023 %Hace la conversión a voltaje
    %VecV= zeros (contador,2);
    %vecGrafica= zeros(contador,2);
    VecV(contador,1)= valorADC*5/1023;
    %vecGrafica(contador,2)= valorADC*5/1023;
    total = cputime - tiempo_inicio;
    VecV(contador,2)= total;
    %VecV(contador,3)= contador;
    %plot(vecV);
    contador=contador+1;
    %pause on %activar un delay
    %pause(0.001)
    
end
%"fffffffffffffffffffffffffffffffffffffffffff"
plot(VecV(1:1:contador-1))
VecV
contador
a=1; %variable contadora para las casillas del vector de la señal 1
%Ciclo para ir separando los datos de la primera señal
% for i=1:muestras %Ciclo para contar desde la casilla 1 hasta el numero de muestras avanzando de dos en dos
% voltaje1(a)=voltaje(i); %guarda el valor de la casilla i del vector que contiene las dos señales en el vector que solo va a contener la primera señal
% xlim([0 (muestras/100)])
% ylim([0 5.1])
% a=a+1; 
% end

%a=1; %variable contadora para las casillas del vector de la señal 2
%Ciclo para ir separando los datos de la segunda señal
% for i=2:2:muestras %Ciclo para contar desde la casilla 2 hasta el numero de muestras avanzando de dos en dos
% voltaje2(a)=voltaje(i); %guarda el valor de la casilla i del vector que contiene las dos señales en el vector que solo va a contener la segunda señal
% a=a+1;
% end
%vectorM=(0:(muestras/100));% vector que va a representar el numero de muestra en el eje X de la grafica
%plot(vectorM,voltaje1) %Grafica de las dos señales
%cierra y borra el puerto utilizado, borra todas las variables utilizadas
fclose(puerto);
delete(puerto);
end