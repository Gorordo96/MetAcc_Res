clear all
close all
clc

Tb=1/100;                   %Tiempo de bit
Eb=2;
N=50;                       %Cantidad de bits a simular
MultPer=5;                  %Cantidad de periodos de chips por bit
MultFrec=5;                 %Multiplicidad de los tonos
MultFrecHop=5;              %Multiplicidad de los tonos de hopping
L=3;                        %Cantidad de elementos del registro
MultTiempHop=1;             %Tiempo de hopping como multiplo de Tc
%Variables dependientes
Nchips=(2^L)-1;                       %Periodo de chips
Rb=1/Tb;                              %Tasa de bit
Tc= Tb/(MultPer*Nchips);              %Tiempo de chip
TiempHop=MultTiempHop*Tc;              %Tiempo de hopping
Ec=Eb/Nchips;                         %Energia de cada chip
Tsampling=Tc/1000;                    %Tiempo de muestreo, se definen la cantidad de muestras por chip
FrecSignal=MultFrec*(1/Tc);           %Frecuencia de las waveform
CantMPerBit=1000*(MultPer*Nchips);
CantM=CantMPerBit*N;
nfft=2^nextpow2(1000);
n = 2^nextpow2(CantM);