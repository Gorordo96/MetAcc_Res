clear all
close all
clc
%Esquema de modulacion BPSK
N=1000;                      %Cantidad de bits a simular 
Rb=1000;                     %Tasa de bits de informacion
Eb=2;                        %Energia de bit
Tb=1/Rb;                     %Tiempo de bit
Rc=10000;                    %Tasa de chips para realizar spreading
Tc=1/Rc;                     %Tiempo de chip
Gp=Tb/Tc;                    %Ganancia de procesamiento
fp=2*Rc;                     %Frecuencia de portadora
Tsampling=Tc/100;            %Tiempo de muestreo para sistema
CantMperbit=Tb/Tsampling;
CantMtotal=CantMperbit*N;