%==========================================================================
%Autores: Geronimo Passini y Gorordo Lucas
%Universidad Nacional de Rio Cuarto
%Gmail: gpassini21@gmail.com / gorordo96@gmail.com
%==========================================================================

clear all
clc
close all

CantBit= 15*10;               %Cantidad de bits a simular                  
CantSimbOFDM=CantBit/3;       %Cantidad de simbolos OFDM
Rb1=1000;                     %Tasa de bit de la primera fuente
Rb2=1000;                     %Tasa de bit de la segunda fuente
Rb3=2000;                     %Tasa de bit de la penultima fuente
Rb4=3000;                     %Tasa de bit de la ultima fuente

Tb1=1/Rb1;                    %Tiempo de bit de la primera fuente
Tb2=1/Rb2;                    %Tiempo de bit de la segunda fuente
Tb3=1/Rb3;                    %Tiempo de bit de la tercera fuente
Tb4=1/Rb4;                    %Tiempo de bit de la ultima fuente
%--------------------------------------------------------------------------------------------
Trama=[Tb1,Tb2,Tb3,Tb4];
Rrama=[Rb1,Rb2,Rb3,Rb4];
TransfBitPerSimb=[1,1,2,3];
Fp=1*10^6;                                %Frecuencia portadora
TsOFDM=max(Trama);                        %Definiendo el tiempo de simbolo OFDM - Deberia estar en funcion de los parametros delay spread y doppler spread
RsOFDM=1/TsOFDM;
N=1000;                                   %Muestras por el tiempo de bit mas pequeño
M=min(Trama);                             %Tiempo de bit mas pequeño para poder tener refencia y simular
Tsampling=M/N;                            %Tiempo de muestreo para simulink
CantMPerSimbOFDM=round(TsOFDM/Tsampling); %Cantidad de muestras por simbolo OFDM
fprintf("Tiempo de simbolo OFDM es de: %d seg/simbolo \n",TsOFDM)
fprintf("Cantidad de ramas que emplea Modulador OFDM: 4 \n")
fprintf("---------------------------------------------- \n")
fprintf("Tasa de bits que utiliza cada fuente : \n")
fprintf("Fuente 1: %d bps\n", Rb1)
fprintf("Fuente 2: %d bps\n", Rb2)
fprintf("Fuente 3: %d bps\n", Rb3)
fprintf("Fuente 4: %d bps\n", Rb4)
fprintf("---------------------------------------------- \n")
RbOFDM=RsOFDM*sum(TransfBitPerSimb);
fprintf("Tasa de transferencia de bits de OFDM: %d bps \n",RbOFDM)
%---------------------------------------------------------------------------------
FsepOFDM=RsOFDM;        %Frecuencia fundamental de la cual son multiplos todos los simbolos de las diferentes ramas.
F1=FsepOFDM*2;            %Frecuencia carrier rama1
F2=FsepOFDM*3;            %Frecuencia carrier rama2
F3=FsepOFDM*4;            %Frecuencia carrier rama3
F4=FsepOFDM*5;            %Frecuencia carrier rama4
fprintf("----------------------------------------------- \n")
fprintf("Frecuencias de portadora utilizada por cada rama del modulador OFDM : \n")
fprintf("Frecuencia portadora para la primer fuente:  %d \n" , F1)
fprintf("Frecuencia portadora para la segunda fuente: %d \n",  F2)
fprintf("Frecuencia portadora para la tercera fuente: %d \n",  F3)
fprintf("Frecuencia portadora para la cuarta fuente:  %d \n",  F4)
%---------------------------------------------------------------------------------------------
Ts1=Tb1;                  %Tasa de simbolo BPSK
Ts2=Tb2;                  %Tasa de simbolo BPSK
Ts3=2*Tb3;                %Tasa de simbolo QPSK
Ts4=3*Tb4;                %Tasa de simbolo 8PSK
%---------------------------------------------------------------------------------------------
%Se asume igual energia para todos los simbolos M-PSK
EsOFDM=2;
%Verificacion de ortogonalidad
%Generacion de las señales en el tiempo
tiemp=[0:Tsampling:TsOFDM-Tsampling];
Signal1=sqrt((2*EsOFDM)/Ts1)*cos(2*pi*F1*tiemp);
Signal2=sqrt((2*EsOFDM)/Ts2)*cos(2*pi*F2*tiemp);
Signal3=sqrt((2*EsOFDM)/Ts3)*cos(2*pi*F3*tiemp);
Signal4=sqrt((2*EsOFDM)/Ts4)*cos(2*pi*F4*tiemp);
%Estimacion espectral
FFT1=abs(fft(Signal1));
FFT2=abs(fft(Signal2));
FFT3=abs(fft(Signal3));
FFT4=abs(fft(Signal4));
%Buscando coeficientes para determinar la frecuencia
Frec_FFT1=find(round(FFT1));
Frec_FFT2=find(round(FFT2));
Frec_FFT3=find(round(FFT3));
Frec_FFT4=find(round(FFT4));
fprintf("----------------------------------------------- \n")
fprintf("Correlacion entre Waveform de rama 1 y Waveform de rama 2 : %d \n",round(sum((Signal1.*Signal2).*Tsampling)))
fprintf("Correlacion entre Waveform de rama 1 y Waveform de rama 3 : %d \n",round(sum((Signal1.*Signal3).*Tsampling)))
fprintf("Correlacion entre Waveform de rama 1 y Waveform de rama 4 : %d \n",round(sum((Signal1.*Signal4).*Tsampling)))
fprintf("Correlacion entre Waveform de rama 2 y Waveform de rama 3 : %d \n",round(sum((Signal2.*Signal3).*Tsampling)))
fprintf("Correlacion entre Waveform de rama 2 y Waveform de rama 4 : %d \n",round(sum((Signal2.*Signal3).*Tsampling)))
fprintf("Correlacion entre Waveform de rama 3 y Waveform de rama 4 : %d \n",round(sum((Signal3.*Signal4).*Tsampling)))
figure()
plot(tiemp,Signal1)
title('Graficas de las waveform para las diferentes ramas')
hold
plot(tiemp,Signal2)
plot(tiemp,Signal3)
plot(tiemp,Signal4)
figure()
stem(FFT1)
title("Estimacion espectral para las diferentes waveform")
hold on
stem(FFT2)
stem(FFT3)
stem(FFT4)
fprintf("----------------------------------------------- \n")
fprintf("Considerando que el tiempo de muestreo para la estimacion espectral es: %d \n", Tsampling)
fprintf("Cantidad de muestras por tiempo de simbolo OFDM : %d \n", round(TsOFDM/Tsampling))
fprintf("El analisis espectral mediante DFT permite establecer que la Ftc=k/N*Ts \n")
fprintf("Las componentes espectrales son : %d HZ \n", round((Frec_FFT1(1)-1)/(round(TsOFDM/Tsampling)*Tsampling)))
fprintf("Las componentes espectrales son : %d HZ \n", round((Frec_FFT2(1)-1)/(round(TsOFDM/Tsampling)*Tsampling)))
fprintf("Las componentes espectrales son : %d HZ \n", round((Frec_FFT3(1)-1)/(round(TsOFDM/Tsampling)*Tsampling)))
fprintf("Las componentes espectrales son : %d HZ \n", round((Frec_FFT4(1)-1)/(round(TsOFDM/Tsampling)*Tsampling)))
fprintf("----------------------------------------------- \n")
fprintf("----------------------------------------------- \n")
fprintf("Comenzando la simulacion en simulink \n")
sim('Modulador_Analogico_CuatroUsuarios')
figure()
tiempGrafSimbOFDM=[0:Tsampling:M*CantBit];
plot(tiempGrafSimbOFDM,SimbOFDM')
title("Señal transmitida por el canal")