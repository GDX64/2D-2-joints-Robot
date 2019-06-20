function [x, y] = nt()
%I told you...
N=32;
t=linspace(0,2*pi,N);
x1=-1/2+0.5*cos(t);
y1=-1.3+0.5*sin(t);

x2=1/2-0.5*cos([t t(1:end/4)]);
y2=-1.3+sin([t t(1:end/4)])/2;

x3=x2(end)*ones(1,N/4);
y3=y2(end)+linspace(0,1.7,N/4);

x4=linspace(0.5,-0.5,N/2);
y4=y3(end)-70/25*(x4.^2-0.25);

x5=rand(1,N)*0.8-1;
y5=rand(1,N)*0.8-1.8;

x6=rand(1,N)*0.8;
y6=rand(1,N)*0.8-1.8;

x=[x1 x2 x3 x4 -x3(end:-1:1) x5 x6];
y=[y1 y2 y3 y4 y3(end:-1:1) y5 y6];


end

