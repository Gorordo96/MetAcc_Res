clc
close all
clear all

L=8;                                      %Cantidad de Registros del generador
N=2^L-1;                                  %Cantidad de bits de periodo del codigo PN
CantPerSim=1;                             %Cantidad de periodos de codigo a simular
CantSalidas=N*CantPerSim;                 %Cantidad de bits de salida por cada simulacion
SelecPol=1;                               %Se puede elegir cambiar las condiciones iniciales de cada polinomio , elegir 1 o 2;
PosiblCod=[];
CondInicialesPosiblCod1=[];
CondInicialesPosiblCod2=[];
SecGD=[];
SecPN=[];

switch (L)
    case(5)
        m=6;
        PolGen1=[5,2,0];                  %[5,3]
        PolGen2=[5,3,2,1,0];               %[5,4,3,2]
        %PolGen=[5,3,0]                   %[5,2] Imagen del [5,3]
        %CondIniciales=[0,0,0,0,1];
    case(6)
        m=6;
        PolGen1=[6,5,0];                  %[6,1]
        PolGen2=[6,5,4,1,0];              %[6,5,2,1]
        %CondIniciales=[0,0,0,0,0,1];
    case(7)
        m=18;
        %Primer par
        PolGen1=[7,4,0];                  %[7,3]
        PolGen2=[7,6,5,4,0];              %[7,3,2,1]
        %Segundo par
        %PolGen1=[7,6,5,4,0];              %[7,3,2,1]
        %PolGen2=[7, 6, 5, 4, 3, 2, 0];                  %[7,5,4,3,2,1]
        %CondIniciales=[0,0,0,0,0,0,1];
    case(8)
        m=16;
        PolGen1=[8, 7, 6, 3, 2, 1, 0];         %[8,7,6,5,2,1] 
        PolGen2=[8, 7, 2, 1, 0];         %[8,7,6,1] 
        %CondIniciales=[0,0,0,0,0,0,0,1];
end
for i=1:(2^L)-1
    PosiblCod=[PosiblCod i];
    CondInicialesPosiblCod1=[CondInicialesPosiblCod1;ConvToBin(i,L)];
    CondInicialesPosiblCod2=[CondInicialesPosiblCod2;ConvToBin(i,L)];
end
%--------------------------------------------------------------------------
CondIn=CondInicialesPosiblCod1(1,:);
if (SelecPol ==1)
    Pol=PolGen1;
    for j=1:length(PosiblCod)
        goldseq = comm.GoldSequence('FirstPolynomial',PolGen1,'SecondPolynomial',PolGen2,'FirstInitialConditions',CondInicialesPosiblCod1(j,:),'SecondInitialConditions',CondInicialesPosiblCod2(1,:),'SamplesPerFrame',CantSalidas);
        SecGD=[SecGD ; goldseq()' ];
    end
elseif (SelecPol ==2)
     Pol=PolGen2;
     for j=1:length(PosiblCod)
        goldseq = comm.GoldSequence('FirstPolynomial',PolGen1,'SecondPolynomial',PolGen2,'FirstInitialConditions',CondInicialesPosiblCod1(1,:),'SecondInitialConditions',CondInicialesPosiblCod2(j,:),'SamplesPerFrame',CantSalidas);
        SecGD=[SecGD ; goldseq()' ];
     end
end
%----------------------------------------------------------------------------------------------------------
PNCode=comm.PNSequence('Polynomial',Pol,'SamplesPerFrame',CantSalidas,'InitialConditions',CondIn);
SecPN=[SecPN ; PNCode()' ];
SecPN=[SecPN, SecPN(1:L-1)];
Cod_GOLD_Ord_Prueba=[];
for h=1:(length(SecPN)-(L-1))
    AUX=SecPN(h:h+(L-1));
    Cont=0;
    for y=length(AUX):-1:1
        Cont=Cont+(AUX(y))*(2^(y-1));
    end
    Cod_GOLD_Ord_Prueba=[Cod_GOLD_Ord_Prueba,Cont];
end
Cod_GOLD_Ord=[Cod_GOLD_Ord_Prueba(1), fliplr(Cod_GOLD_Ord_Prueba(2:length(Cod_GOLD_Ord_Prueba))) ];
%-----------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------
% ANALISIS DE PROPIEDADES
%--------------------------------------------------------------------------
Seleccion_Us=5;                                                                                     %Cantidad de codigos Gold seleccionados en orden
Seleccion_Cod=2;                                                                                    %Codigo seleccionado para analisis dentro de los ordenados
%--------------------------------------------------------------------------
%Ejemplo del libro: tomar Seleccion_Cod=2 y Seleccion_Us=5
%--------------------------------------------------------------------------
Vector_Gold=[];
for u=1:Seleccion_Us
    Vector_Gold=[Vector_Gold;SecGD(Cod_GOLD_Ord(u),:)];
end
Sec_GD_analisis=SecGD(Cod_GOLD_Ord(Seleccion_Cod),:);                                                %Vector_Gold=[SecGD(1,:);SecGD(5,:);SecGD(10,:);SecGD(21,:);SecGD(11,:);SecGD(23,:);SecGD(14,:);SecGD(29,:);SecGD(27,:);SecGD(22,:);SecGD(12,:);SecGD(24,:);SecGD(17,:);SecGD(3,:);SecGD(7,:);SecGD(15,:);.....];
Sec_GD_Base=[Sec_GD_analisis(2:length(Sec_GD_analisis)),Sec_GD_analisis(1)];
%-------------------------------
% PROP. Balance
%-------------------------------
Cant_uno=length(Sec_GD_analisis(Sec_GD_analisis==1));
Cant_cero=length(Sec_GD_analisis(Sec_GD_analisis==0));
Valor_medio=((Cant_uno-Cant_cero)/(length(Sec_GD_analisis)));
%-------------------------------
% PROP. de corridas
%-------------------------------
corridas=[];
cont_corridas=1;
for n=1:(length(Sec_GD_analisis)-1)  
    if(Sec_GD_analisis(n)==Sec_GD_analisis(n+1))
        cont_corridas= cont_corridas +1;
        if n==(length(Sec_GD_analisis)-1)
        corridas= [corridas cont_corridas];
        end
    else
        corridas= [corridas cont_corridas];
        n=n+(cont_corridas);
        cont_corridas=1;
    end
end
for m=1:L
    fprintf("Fraccion de corridas de %i: %i \n",m,(length(corridas(corridas==m))/length(corridas)));
end
%-------------------------------
% PROP. de autocorrelacion
%-------------------------------
Sec_GD_analisis_corr =[];
Correlation=[];
VectorTime=[];
%Corrimientos para autocorrelacion
for k=1:length(Sec_GD_analisis)
Sec_GD_analisis_corr = [Sec_GD_analisis((length(Sec_GD_analisis)-k + 1):length(Sec_GD_analisis)),Sec_GD_analisis(1:(length(Sec_GD_analisis)-k))];
Corr=xor(Sec_GD_analisis,Sec_GD_analisis_corr);
Corr_Res=((length(Corr(Corr == 0)))-(length(Corr(Corr==1))))/length(Corr);

Correlation =[Correlation Corr_Res];

if (k == length(Sec_GD_analisis))
    VectorTime=[VectorTime,0];
else
    VectorTime=[VectorTime,k];
end
end
figure()
stem(VectorTime,Correlation)
title("Autocorrelacion de Codigo Gold")
%--------------------------------------------------------------------------
%PROP. de Correlacion Cruzada
%--------------------------------------------------------------------------
figure()
Long=length(Vector_Gold(:,1));
for t=1:Long
    Sec_GD_analisis=Vector_Gold(t,:);
    Sec_GD_analisis=[Sec_GD_analisis(2:length(Sec_GD_analisis)),Sec_GD_analisis(1)];
    Sec_GD_analisis_corr =[];
    Correlation=[];
    %Parte de los corrimientos para graficar correlacion cruzada
    for k=1:length(Sec_GD_analisis)
        Sec_GD_analisis_corr = [Sec_GD_analisis((length(Sec_GD_analisis)-k + 1):length(Sec_GD_analisis)),Sec_GD_analisis(1:(length(Sec_GD_analisis)-k))];
        Corr=xor(Sec_GD_Base,Sec_GD_analisis_corr);
        Corr_Res=((length(Corr(Corr == 0)))-(length(Corr(Corr==1))));
        Correlation =[Correlation Corr_Res];
    end
    subplot(Long,1,t)
    stem(VectorTime,Correlation)
    title("Correlacion Cruzada de Codigos Golds respecto a Gold ")
    
end
%--------------------------------------------------------------------------
%PROP. de Densidad espectral de potencia
%--------------------------------------------------------------------------
Tc=1/1000;
CantMuestrPerChip=10000;
Tsampling=Tc/CantMuestrPerChip;
Exp_Cod_PN=[];
Time_Plot=[];
for i=1:length(Sec_GD_analisis)
    tiemp=[(i-1)*Tc:Tsampling:i*Tc-Tsampling];
    Time_Plot=[Time_Plot,tiemp];
    if(Sec_GD_analisis(i)==0)
        Exp_Cod_PN=[Exp_Cod_PN (-1)*ones(1,CantMuestrPerChip)];
    else
        Exp_Cod_PN=[Exp_Cod_PN ones(1,CantMuestrPerChip)];
    end
end
figure()
plot(Time_Plot,Exp_Cod_PN)
title("Codigo Gold")
grid on
axis([0 CantSalidas*Tc -1.5 1.5])
figure()
nfft=2^(nextpow2(length(Exp_Cod_PN)));
XX=fft(Exp_Cod_PN,nfft);
Fs=1/Tsampling;
Vect_Frec=Fs*(0:(nfft/2)-1)/nfft;
Graf_Spect=(abs(XX(1:length(Vect_Frec)))).^2;
plot(Vect_Frec,Graf_Spect/(max(Graf_Spect)))
title("Densidad espectral de potencia de Codigo Gold")