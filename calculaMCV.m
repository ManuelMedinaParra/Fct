function MCV=calculaMCV

clc

display('*********************************************')
display('*********************************************')
display('*                                           *')
display('* SELECCION DE FICHEROS ¡OJO con EL ORDEN!! *')
display('*                                           *')
display('*********************************************')
display('*********************************************')
display('* BICEPS                                    *')
display('* TRICEPS                                   *')
display('* FLEXOR                                    *')
display('* EXTENSOR                                  *')
display('* TRAPECIO                                  *')

j=0;

for i=1:1
    j=j+1;

    button=questdlg('Seleccione el archivo','ABRIR ARCHIVO','ACEPTAR','Cancelar','No hay ayuda','ACEPTAR');
    if strcmp(button,'Cancelar')||strcmp(button,'No hay ayuda'), 
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

    plot(muscle);
    
    aux=ginput(2);
    aux = fix(aux);
    vector=muscle(aux(1):aux(2));    
    rms =EMG_rms(vector,100); % Ventana temporal de 100 muestras (100 ms)
    plot (rms);
    %MCV=0;
    MCV(i)=mean(rms);

end % For
save mcv.txt MCV -ASCII
end % Function