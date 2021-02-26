%------------------------------------------------------------------------
%Autores: Geronimo Passini y Lucas Gorordo
%Material Base: MIMO OFDM Wireless Communications with Matlab pag.137
%-----------------------------------------------------------------------
clc
close all
clear all

%Trade Off
%------------------------------------------------------------------------
%Rendimiento al incorporar prefijo ciclico (CP) versus incorporacion de ceros (ZP) Frente a
%un canal con multicaminos (Multipath) 
%Considerando  : Variable en analisis:            CP ó ZP
%                Channel:                         Multipath
%                Ecualizacion de canal:          -SI
%                Esquema de modulacion:           QPSK
%                Longitud de NFFT:                64
%                Longitud de Intervalo de guarda: 16   (%25 NFFT)
%                Frecuencias Piloto:              16   (%25 NFFT)
parametros = [[1, 1, 2, 64, 16, 16];[2, 1, 2, 64, 16, 16]];
figure()
for (grafica=1:size(parametros,1))   
subplot(size(parametros,1),1,grafica)
NgType_parametro= parametros(grafica,1);
Ch_parametro=parametros(grafica,2);
Nbps_parametro=parametros(grafica,3);
Nfft_parametro=parametros(grafica,4);
Ng_parametro=parametros(grafica,5);
Nvc_parametro=parametros(grafica,6);
OFDM_parametrizable
if grafica==1 
    title('Rendimiento con CP')
elseif grafica==2
    title('Rendimiento con ZP')
end
end
%-------------------------------------------------------------------------
%Rendimiento al tener en cuenta distintas longitudes de prefijo ciclico
%Considerando  : Variable en analisis: Longitud de Intervalo de guarda ((4)%5 , (7)%10 , (10)%15 y (13)%20 (64)NFFT)APROX
%                Channel:                         Multipath
%                Esquema de modulacion:           QPSK
%                Ecualizacion de canal:           -SI
%                Longitud de NFFT:                64
%                Frecuencias Piloto:              16   (%25 NFFT)
clear all
parametros = [[1, 1, 2, 64, 4, 0];[1, 1, 2, 64, 7, 0];[1, 1, 2, 64, 9, 0];[1, 1, 2, 64, 13, 0]];
figure()
for (grafica=1:size(parametros,1))  
subplot(2,2,grafica)
NgType_parametro= parametros(grafica,1);
Ch_parametro=parametros(grafica,2);
Nbps_parametro=parametros(grafica,3);
Nfft_parametro=parametros(grafica,4);
Ng_parametro=parametros(grafica,5);
Nvc_parametro=parametros(grafica,6);
OFDM_parametrizable
plot_ber(file_name,Nbps);
if grafica==1 
    title('Prefijo Ciclico de 5%')
elseif grafica==2
    title('Prefijo Ciclico de 10%')
elseif grafica==3
    title('Prefijo Ciclico de 15%')
elseif grafica==4
    title('Prefijo Ciclico de 20%')
end
end
%-------------------------------------------------------------------------
%Rendimiento al tener en cuenta ecualizacion de canal , si ya se cuenta con
%prefijo ciclico o no.
%Considerando  : Variable en analisis: Ecualizacion de canal -SI ó NO
%                Channel:                         Multipath
%                Esquema de modulacion:           QPSK
%                Longitud de Prefijo ciclico:     16   (%25 NFFT)
%                Longitud de NFFT:                64
%                Frecuencias Piloto:              SI: 16 o NO: 0   (%25 NFFT)
%-------------------------------------------------------------------------
clear all
parametros = [[1, 1, 2, 64, 16, 16];[1, 1, 2, 64, 16, 0]];
figure()
for (grafica=1:size(parametros,1))
subplot(size(parametros,1),1,grafica)
NgType_parametro= parametros(grafica,1);
Ch_parametro=parametros(grafica,2);
Nbps_parametro=parametros(grafica,3);
Nfft_parametro=parametros(grafica,4);
Ng_parametro=parametros(grafica,5);
Nvc_parametro=parametros(grafica,6);
OFDM_parametrizable
plot_ber(file_name,Nbps);
if grafica==1 
    title('Con ecualizacion')
elseif grafica==2
    title('Sin ecualizacion')
end
end