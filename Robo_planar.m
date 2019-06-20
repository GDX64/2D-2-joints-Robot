close all
clear all
clc

x0=10;
y0=10;
sc=10;
width=1000;
height=1000;
set(gcf,'units','points','position',[x0,y0,width,height])

L1=10; %size of the arms
L2=10;

%% Paths
%%reta

% x = -1:0.05:1;
% y = tand(30) * x + 0.5;

%%cirnferencia

% x = 0.5 + 1.2 * cosd(0:2:180);
% y = 1.2 * sind(0:2:180);

%%cubica

% x = -1:0.05:1;
% y = x.^3 + 0.5;

%coração

t = -3:.1:3;
x = (1.6*(power(sin(t),3)));
y = (1.3*cos(t)-0.5*cos(2*t)-0.2*cos(3*t)-0.1*cos(4*t));

%%seno
% 
% x=-1:0.03:1;
% y=1+0.5*sin(10*x);

%Better not to try this one
% [x,y]=nt();

%% Code
x=x*sc; %scale factor
y=y*sc;

for i=1:length(x)

    c2=((x(i)^2+y(i)^2)-(L1^2+L2^2))/(2*L1*L2);
    s2=-sqrt(1-c2^2);
    k1=L1+L2*c2;
    k2=L2*s2;
    r=sqrt(k1^2+k2^2);
    th1=atan2(y(i)/r,x(i)/r)-atan2(k2,k1);
    th2=atan2(s2,c2);


    f0=rot('x',0);
    f1=f0*rot('z',th1)*trans([L1 0 0]);
    f2=f1*rot('z',th2)*trans([L2 0 0]);

    plot(x(1:i),y(1:i), 'k', 'linewidth', 5)
    hold on

    frames={f0 f1 f2};

    for i=1:length(frames)
        %link
        if i<length(frames)
           plot3([frames{i}(1,4) frames{i+1}(1,4)],[frames{i}(2,4) frames{i+1}(2,4)],[frames{i}(3,4) frames{i+1}(3,4)], 'y', 'linewidth', 6) 
        end
        f1=frames{i};

        plot3(f1(1,4) , f1(2,4) , f1(3,4) , 'om', 'linewidth', 2 , 'markersize', 15);
        text(f1(1,4) , f1(2,4) , f1(3,4)-0.2 , strcat('\{', mat2str(i-1), '\}'))
        % Eixo-x no robô no frame
        plot3([f1(1,4) f1(1,4)+f1(1,1)] , [f1(2,4) f1(2,4)+f1(2,1)] , [f1(3,4) f1(3,4)+f1(3,1)] , 'b', 'linewidth', 2)
        text(f1(1,4)+f1(1,1) , f1(2,4)+f1(2,1) , f1(3,4)+f1(3,1) , strcat('x_{\{', mat2str(i-1), '\}}'))
        % Eixo-y no robô no frame
        plot3([f1(1,4) f1(1,4)+f1(1,2)] , [f1(2,4) f1(2,4)+f1(2,2)] , [f1(3,4) f1(3,4)+f1(3,2)] , 'r', 'linewidth', 2)
        text(f1(1,4)+f1(1,2) , f1(2,4)+f1(2,2) , f1(3,4)+f1(3,2) , strcat('y_{\{', mat2str(i-1), '\}}'))
        % Eixo-z no robô no frame
        plot3([f1(1,4) f1(1,4)+f1(1,3)] , [f1(2,4) f1(2,4)+f1(2,3)] , [f1(3,4) f1(3,4)+f1(3,3)] , 'g', 'linewidth', 2)
        text(f1(1,4)+f1(1,3) , f1(2,4)+f1(2,3) , f1(3,4)+f1(3,3) , strcat('z_{\{', mat2str(i-1), '\}}'))
        axis([-20 20 -20 20 0 5])
        view(0,90) %ajusta a visão do plot

    end

    grid on
    hold off
    pause(0.05)

end
