clear all
clc
close all

Tb=1/100;                 %Tiempo de bit
Eb=2;                     %Energia de bit
N=10;                     %Cantidad de bits a simular
L=4;                      %Cantidad de elementos del registro(Si se modifica, modificar condiciones iniciales de usuario en simulink)
MultPer=1;                %Cantidad de periodos de chips por bit
MultFrec=5;                %Multiplicidad de los tonos

%Variables dependientes:

Nchips=(2^L)-1;                       %Periodo de chips
Rb=1/Tb;                              %Tasa de bit
Tc= Tb/(MultPer*Nchips);              %Tiempo de chip
Ec=Eb/Nchips;                         %Energia de cada chip
Tsampling=Tc/1000;                    %Tiempo de muestreo, se definen la cantidad de muestras por chip
FrecSignal=MultFrec*(1/Tc);           %Frecuencia de las waveform
CantMPerBit=1000*(MultPer*Nchips);
n = 2^nextpow2(CantMPerBit);
switch (L)
    case(2)
        m=2;
        PolGen=[2,1,0];                  %[2,1]
        %CondIniciales=[0,1];
    case(3)
        m=2;
        PolGen=[3,2,0];                  %[3,1]
        %CondIniciales=[0,0,1];
    case(4)
        m=2;
        PolGen=[4,3,0];                  %[4,1]
        %CondIniciales=[0,0,0,1];
    case(5)
        m=6;
        PolGen=[5,2,0];                  %[5,3]
        %CondIniciales=[0,0,0,0,1];
    case(6)
        m=6;
        PolGen=[6,5,0];                  %[6,1]
        %CondIniciales=[0,0,0,0,0,1];
    case(7)
        m=18;
        PolGen=[7,6,0];                  %[7,1]
        %CondIniciales=[0,0,0,0,0,0,1];
    case(8)
        m=16;
        PolGen=[8, 6, 5, 4, 0];          %[8,4,3,2]
        %CondIniciales=[0,0,0,0,0,0,0,1];
end