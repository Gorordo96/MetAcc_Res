function [R] =ConvToBin(Dividendo,n)
Divisor=2;
Cociente=0;
Residuo=0;
R=[];
a=0;
i=1;
j=1;
b=1;
c=2;
x=0;1;
w=0;
z=0;
%------------------------------------------------------------
Residuo=Dividendo;
while c>1
    while Residuo>=Divisor
        Cociente=Cociente+1;
        Residuo=Residuo-Divisor;
    end
    a(j,i)=Residuo;
    i=i+1;
    Residuo=Cociente;
    c=Cociente;
    Cociente=0;
end
a(j,i)=c;
f=i;
while b<=i
    x(j,b)=a(j,f);
    f=f-1;
    b=b+1;
end

if (n<length(x))
    disp("Error, debe ingresar un N mayor o igual a los requeridos para representar a x")
else
    R=[zeros(1,n-length(x)) x];
end