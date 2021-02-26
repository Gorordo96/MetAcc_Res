%==========================================================================
%Autores: Geronimo Passini y Lucas Gorordo
%==========================================================================

clear all
close all
clc

Rb=16000;                                   %Tasa de bits asociada a un usuario en la implementacion digital
Tb=1/Rb;                                    %Tiempo de bit asociadao a un usuario en la implementacion digital
Eb=4;                                       %Energia de bit de cada rama del modulador, Eb=Es , implementacion de BPSK
Fp=Rb;                                      %Frecuencia portadora para generar simbolo OFDM de banda de paso
Tsampling=Tb/1000;                          %Tiempo de muestreo para simulink
CantIFFT=8;                                 %Si modificamos esto hay que cambiar la estructura paralelo de los moduladores      
RsOFDM=Rb/(1*CantIFFT);                     %Tasa de simbolo OFDM (Rb/(k*NFFT))
TsOFDM=1/RsOFDM;                            %Tiempo de simbolo
CantMPerSimb=TsOFDM/Tsampling;              %Cantidad de muestras por simbolo OFDM
CantSimbOFDM=50;                            %Cantidad de simbolos OFDM a simular
N=CantSimbOFDM*CantIFFT;
sim('implementacion_Digital_OFDM')