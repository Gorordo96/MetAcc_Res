clc
close all
clear all
L=5;               %Cantidad de Registros del generador
N=(2^L)-1;         %Cantidad de bits de periodo del codigo PN
CantSalidas=N;     %Cantidad de bits de salida por cada Iteracion
PosiblCod=[];
CondInicialesPosiblCod=[];
SecPN=[];

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
for i=1:(2^L)-1
    PosiblCod=[PosiblCod i];
    CondInicialesPosiblCod=[CondInicialesPosiblCod;ConvToBin(i,L)];
    PNCode=comm.PNSequence('Polynomial',PolGen,'SamplesPerFrame',CantSalidas,'InitialConditions',CondInicialesPosiblCod(i,:));
    SecPN=[SecPN ; PNCode()' ];
end
