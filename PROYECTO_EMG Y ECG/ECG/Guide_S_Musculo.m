function varargout = Guide_S_Musculo(varargin)
% GUIDE_S_MUSCULO MATLAB code for Guide_S_Musculo.fig
%      GUIDE_S_MUSCULO, by itself, creates a new GUIDE_S_MUSCULO or raises the existing
%      singleton*.
%
%      H = GUIDE_S_MUSCULO returns the handle to a new GUIDE_S_MUSCULO or the handle to
%      the existing singleton*.
%
%      GUIDE_S_MUSCULO('CALLBACK',hObject,eventData,handles,...) calls the local
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

% Last Modified by GUIDE v2.5 09-May-2019 10:23:23

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

%global ESTADO_BOTON;
%ESTADO_BOTON=1;
set(hObject, 'UserData', false);
% "Boton Pulsado"
VecV=ADC_Serial2(handles);




% --- Executes on button press in STOP.
function STOP_Callback(hObject, eventdata, handles)
% hObject    handle to STOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of STOP
%global ESTADO_BOTON;
%ESTADO_BOTON=0;
set(handles.START, 'UserData', true);
% "Boton No Pulsado"


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
delete(instrfind({'port'},{'COM5'})); %borrar cualquier puerto serial abierto
puerto=serial('COM5'); %declaro variable llamada puerto y se crea el com4
puerto.BaudRate=9600; %Establecer velocidad de transmisión
fopen(puerto);%abre el puerto a utilizar
contador=1;
%M= zeros();
VecV=0;
tiempo_inicio = cputime;
%VecV(contador,2)= tiempo_inicio;
%xlswrite('MatLab_Sensor.xlsx',tiempo_inicio,3,'B1');
valorADC=fscanf(puerto,'%f%f');
texto=fopen('C:\Users\Usuario\Desktop\FCT\PROYECTO_EMG Y ECG\ECG\Sensor_M.txt','wt');
fprintf(texto,'%f',valorADC);
fprintf(texto,';');
fprintf(texto,'%f',tiempo_inicio);
fprintf(texto,'\n');
fclose(texto);

texto=fopen('C:\Users\Usuario\Desktop\FCT\PROYECTO_EMG Y ECG\ECG\Sensor_M.txt','wt');
while true
    drawnow();
    grid off;
    valorADC=fscanf(puerto,'%d%d');%Toma el valor recibido por el puerto y lo guarda en la variable
    %VecV= valorADC*3.3/1023;%Hace la conversión a milivoltios(PERO PARA NO PERDER DATOS SE MASA A MICROVLTIOS)
    VecV= valorADC/1000;
    total = cputime - tiempo_inicio;
    fprintf(texto,'%f',VecV);%\n para saltar de parrafo
    fprintf(texto,';');
    fprintf(texto,'%f',total);
    fprintf(texto,'\n');
    fprintf('%f seg. - %f ml.\n', total, VecV);
    contador=contador+1;
    need_to_stop=get(handles.START, 'UserData');%COMPROBACIÓN SI SE A PULSADO EL STOP
    if need_to_stop  %SALIR DEL BUCLE WHILE
       fclose(texto);
       break;
    end
end
      
      %LEEMOS LOS VALORES DEL TXT
      cd('C:\Users\Usuario\Desktop\FCT\PROYECTO_EMG Y ECG\ECG')
      datos=importdata('Sensor_M.txt');
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot (handles.Graf1,0,0);
clc
clear