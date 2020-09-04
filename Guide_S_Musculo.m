function varargout = Guide_S_Musculo(varargin)
% GUIDE_S_MUSCULO MATLAB code for Guide_S_Musculo.fig
%      GUIDE_S_MUSCULO, by itself, creates a new GUIDE_S_MUSCULO or raises the existing
%      singleton*.
%
%      H = GUIDE_S_MUSCULO returns the handle to a new GUIDE_S_MUSCULO or the handle to
%      the existing singleton*.
%
%      GUIDE_S_MUSCULO('CALLBACK',hObject,eventData,handles,...) calls the localSerial.println("Envio");
%      function named CALLBACK in GUIDE_S_MUSCULO.M with the given input arguments.
%
%      GUIDE_S_MUSCULO('Property','Value',...) creates a new GUIDE_S_MUSCULO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Guide_S_Musculo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Guide_S_Musculo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".    
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Guide_S_Musculo

% Last Modified by GUIDE v2.5 02-May-2019 16:27:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Guide_S_Musculo_OpeningFcn, ...
                   'gui_OutputFcn',  @Guide_S_Musculo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Guide_S_Musculo is made visible.
function Guide_S_Musculo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Guide_S_Musculo (see VARARGIN)

% Choose default command line output for Guide_S_Musculo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Guide_S_Musculo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Guide_S_Musculo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in START.
function START_Callback(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of START
set(hObject, 'UserData', false);
% LLAMADA A LA FUNCIÓN
VecV=ADC_Serial2(handles);




% --- Executes on button press in STOP.
function STOP_Callback(hObject, eventdata, handles)
% hObject    handle to STOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of STOP
%PARAR EL BUCLE WHILE QUE SE ENCUENTRA EN LA FUNCIÓN LLAMADA ANTERIORMENTE POR EL BOTON START
set(handles.START, 'UserData', true);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function VecV=ADC_Serial2(handles) %la funcion recibe el # de muestras que debe tomar

voltaje=0;%Declara variable en la cual se van a guardar los valores
delete(instrfind({'port'},{'COM9'})); %borrar cualquier puerto serial abierto
puerto=serial('COM9'); %declaro variable llamada puerto y se crea el com4
%puerto.BaudRate=2000000; %Establecer velocidad de transmisión
puerto.BaudRate=57600;
fopen(puerto);%abre el puerto a utilizar
contador=1;
%M= zeros();
VecV=0;
tiempo_inicio = cputime;
%VecV(contador,2)= tiempo_inicio;
%xlswrite('MatLab_Sensor.xlsx',tiempo_inicio,3,'B1');
texto=fopen('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\EMG_real.txt','wt');
%texto=fopen('C:\Users\jasanchez\Documents\Fuerza_Maxima.txt','wt');
while true
    %close all; %Cierra todo lo que matlab tenga abierto
    %clc; %limpiar la pantalla
    drawnow();
    grid off;
    valorADC=fscanf(puerto,'%d%d');%Toma el valor recibido por el puerto y lo guarda en la variable
    if ~isnan(valorADC)
        VecV= valorADC*5/1023;%Hace la conversión a milivoltios(PERO PARA NO PERDER DATOS SE MASA A MICROVLTIOS)
        total = cputime - tiempo_inicio;
        %xlswrite('MatLab_Sensor.xlsx',VecV,3,'A(contador)');
        fprintf(texto,'%f',VecV);%\n para saltar de parrafo
        %xlswrite('MatLab_Sensor.xlsx',total,3,'B(contador)');
        fprintf(texto,';');
        fprintf(texto,'%f',total);
        fprintf(texto,'\n');
        %fprintf(texto,'%d',contador);
        %VecV(contador,3)= contador;
        %xlswrite('MatLab_Sensor.xlsx',contador,3,'C(contador)');
        contador=contador+1;
        fprintf('%f seg. - %f v.\n',total, VecV);
        need_to_stop=get(handles.START, 'UserData');%COMPROBACIÓN SI SE A PULSADO EL STOP
    end
    if need_to_stop  %SALIR DEL BUCLE WHILE
       fclose(texto);
       break;
    end
end
      
      %LEEMOS LOS VALORES DEL TXT
      cd('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB')
      datos=importdata('EMG_real.txt');
      M=datos;
      %fclose(texto);
      plot(handles.Graf1,M(:,2),M(:,1))
      %winopen('C:\Users\jasanchez\Documents\Sensor_M.txt');
      %VecV;
      %contador;
      %plot(M(1:1:contador-1));
      %VecV(1:1:contador-1)
      %fclose(puerto);
      delete(puerto);

%FILTRADO

%Cargar datos a la variable EMG
% texto=fopen('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\EMG_real.txt');
%texto=fopen('C:\Users\jasanchez\Documents\Fuerza_Maxima.txt','wt');
% grid on;
%winopen('Sensor_M.txt');
% Q=length('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\EMG_real.txt');
% formatSpec = '%f ; %f \n ';
% sizeM = [2 Inf];
% M=fscanf(texto,formatSpec,sizeM);
% M=M' 

EMG_data= M(:,1);

 
% 
% %Frecuencia de muestreo
% 
% Fm =337;
% 
%  
% 
% % % Fs = Fm /2
% % 
% % Fs = Fm / 2;
% % 
% %  
% % 
% % Fcorteinf = 10;
% % 
% % BandaAtenuacion = 10; 
% % 
% % Fcortesup = Fs - BandaAtenuacion;
% %  
% % 
% % Wp = [10 (Fcortesup)]/Fs
% % 
% % Ws = [1 (Fcortesup+BandaAtenuacion-1)]/Fs
% % 
% % Rp = 3; %??
% % 
% % Rs = 40; %??
% % 
% % [n,Wn] = buttord(Wp,Ws,Rp,Rs)
% % 
% % [z,p,k] = butter(n,Wn);
% % 
% % [sos,g] = zp2sos(z,p,k);
% % 
% % fvtool(sos,'Color','white');
% % 
% % EMG_Bandpass = filtfilt(sos, g, EMG_data);
% 
% 
% HIGHPASS FILTER (0-10 Hz)
% ========================
n = 4;
m=length(M(:,1))
m1=M(m,2)
m2= M(1,2)
l=(m1-m2)
Fm = (m/l) % ==> CALCULAR EL REAL (TiempoFinal - TiempoInicial)/NumeroMuestras
set(handles.text6,'String',Fm);
Fcorteinf = 10;

highpassFilter = fdesign.highpass('n,f3db', n , 2*Fcorteinf*(1/Fm)); %high-pass filter, cut off frequency at 10Hz

highpassFilterDesign = design(highpassFilter,'butter');

%fvtool(highpassFilterDesign,'Color','white');  %HABRE UNA VENTANA PARA VISUALIZAR EL FILTRO

EMG_highpass = filter(highpassFilterDesign,EMG_data);

% NOTCH FILTER (50 Hz)
% ===================

notchFilter = fdesign.notch('N,F0,Q',n,50,10,Fm); %notch filter (50Hz)

notchFilterDesign = design(notchFilter);

%fvtool(notchFilterDesign,'Color','white'); %HABRE UNA VENTANA PARA VISUALIZAR EL FILTRO DE 50Hz

EMG_Filtered = filter(notchFilterDesign, EMG_highpass);

%fclose(texto); 

%ESCRIBIMOS EN EL TXT DE FILTRADO
texto=fopen('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\EMG_filtrado.txt','wt');
con=length(EMG_Filtered);
for i=1:1:con-1
    B=EMG_Filtered(i,1);
    Y=M(i,2);
    fprintf(texto,'%f',B);
    fprintf(texto,';');
    fprintf(texto,'%f',Y);
    fprintf(texto,'\n');
end
plot (handles.Graf2,M(:,2), EMG_Filtered);

fclose(texto);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%MVC MAXIMOOOOOO

j=0;
global MCV
    j=j+1;

 button=questdlg('Seleccione el archivo de MCV','ABRIR ARCHIVO','ACEPTAR','Cancelar','No hay ayuda','ACEPTAR');
    if strcmp(button,'Cancelar')||strcmp(button,'No hay ayuda')
        return; 
    end;
    
    [filename,pathsuj]=uigetfile('*.txt','Seleccione directorio con las carpetas de los SUJETOS');
    
    if path==0 
        return;
    end;

    cd(pathsuj)
    datos=importdata(filename);
    display('*                                            *')
    display('*USTED SELECCIONO:                           *')
    filename

    muscle=datos(:,1);
    T=datos(:,2);

    plot(handles.Graf3,muscle);
    aux=ginput(2);
    aux = fix(aux);
    vectorMuscle=muscle(aux(1):aux(2));
    vectorTime=T(aux(1):aux(2));
    rms =EMG_rms(vectorMuscle,100); % Ventana temporal de 100 muestras (100 ms)
    
    %ESCRIBIMOS EN EL TXT DE MCV_EMG_RMS
    texto=fopen('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\MCV_EMG_RMS.txt','wt');
    Con=length(rms);
    for i=1:1:Con-1
        C=rms(i,1);
        X=vectorTime(i,1);
        fprintf(texto,'%f',C);
        fprintf(texto,';');
        fprintf(texto,'%f',X);
        fprintf(texto,'\n');
    end
    fclose(texto);
    plot (handles.Graf3,vectorTime, rms);
    i=1;
    MCV(i)=mean(rms)
%save mcv.txt MCV -ASCII
%MCV=0.0508;




%MVC Testtttttttt

 button=questdlg('Seleccione el archivo del TEST','ABRIR ARCHIVO','ACEPTAR','Cancelar','No hay ayuda','ACEPTAR');
    if strcmp(button,'Cancelar')||strcmp(button,'No hay ayuda')
        return; 
    end;
    [filename,pathsuj]=uigetfile('*.txt','Seleccione directorio con las carpetas de los SUJETOS');
    if path==0 
        return;
    end;
    
    cd(pathsuj)
    datos=importdata(filename);
    display('*                                            *')
    display('*USTED SELECCIONO:                           *')
    filename
    
    F=length(datos);
    for i=1:1:F-1
        if datos(i,1)<=1 && datos(i,1)>=(-1)
            Tes(i,1)=datos(i,1);
            Tes(i,2)=datos(i,2);
        end
    end    
     musculo=Tes(:,1)
  Tiempo=Tes(:,2);
  rms2 =EMG_rms(musculo,100); % Ventana temporal de 100 muestras (100 ms)
  %plot(Tes(:,1));
    
 
 
 %ESCRIBIMOS EN EL TXT DE EMG_RMS
    texto=fopen('C:\Users\Usuario\Desktop\FCT\PARA_MATLAB\MATLAB\EMG_RMS.txt','wt');
    S=length(rms2);
    for i=1:1:S-1
        D=rms2(i,1);
        W=Tiempo(i,1);
        fprintf(texto,'%f',D);
        fprintf(texto,';');
        fprintf(texto,'%f',W);
        fprintf(texto,'\n');
    end
    fclose(texto);
    plot (handles.Graf3, rms2);
    i=1;
    MCV2(i)=mean(rms2)

%REALIZAMOS EL CALCULO DEL %MCV DE LOS DOS RMS CALCULADOS ANTERIORMENTE 
    MCV
    MCV_Porcentaje=((MCV2*100)/MCV);
    set(handles.text4,'String',MCV_Porcentaje);
    


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot (handles.Graf1,0, 0);
plot (handles.Graf2,0, 0);
plot (handles.Graf3,0, 0);
set(handles.text4,'String',0.0);
set(handles.text6,'String',0.0);
clc
clear
