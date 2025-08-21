%Limpieza general
clear all; %Borrar todas las variables del espacio de trabajo
close all; %Cierra todas las ventanas emergentes
clc; % Limpia la ventana de comandos 


%% Parámetros iniciales

nbits= 8; % Cantidad de bits
np= 400; % Cantidad de pobladores 

% Rango o intervalo

% Población inicial
pobin = randi([0,255],np,1)
% La función de ajuste o fitness
x= pobin;


for n=1:100  %cantidad de generaciones
    %Evaluación
    y= x.^2 %función de ajuste o fitness o función objetivo
    promy(n,1)=mean(y);
    
    cromosoma = [y x];
    
    cromosoma = sortrows(cromosoma,1,'descend') %Selección por ranking / ordenamiento
    
    
    padredec = cromosoma(1:np/2 , 2); %Padres en decimal 
    
    
    padrebin= de2bi(padredec, nbits) %conversión de decimal a binario
    
    %dec2bin la salida es texto
    
    %cruzamiento
    % 1 punto de cruce
    for k=1;np/4 
        p= randi([2,nbits-1]);
        hijobin(2*k-1, :)= [padrebin(2*k-1, 1:p),padrebin(2*k,p+1:nbits)];
        hijobin(2*k,:)=[padrebin(2*k, 1:p),padrebin(2*k-1,p+1:nbits)];
    end

    %Mutación
    p=rand() %número aleatorio  para decidir si muta 

    if p >= 0.85
            hijo = randi(np/2); % Hijo aleatorio
            bit = randi(nbits); % Bit aleatorio

        if hijobin(hijo, bit) == 1
            hijobin(hijo, bit) = 0;
        else 
            hijobin(hijo, bit) = 1; 
        end
    end

    
    hijodec = bi2de(hijobin); %convierte de binario a decimal
    %bin2dec
    x= [padredec ; hijodec];

end 
plot(promy)
max(y)
max(x)