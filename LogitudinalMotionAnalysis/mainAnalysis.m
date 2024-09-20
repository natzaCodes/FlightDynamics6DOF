clc;
clear;
close all;

ft2m = 0.3048;

%reference state
u0 = convvel(634,'ft/s','m/s');
w0 = 0;
q0=0;
teta0=0;
xf0=0;
zf0=15000*ft2m;
y0=[u0, w0, q0, teta0, xf0, zf0];
location0 =0;
location = linspace(1,5,5);
locationdetail = linspace(0,2.5,5);

%% A part
[Gw,Gq,Gaz] = calcG(location0,y0);

%% B part
[~,~,Gaz1] = calcG(location(1),y0);
[~,~,Gaz2] = calcG(location(2),y0);
[~,~,Gaz3] = calcG(location(3),y0);
[~,~,Gaz4] = calcG(location(4),y0);
[~,~,Gaz5] = calcG(location(5),y0);
[~,~,Gaz1det] = calcG(locationdetail(1),y0);
[~,~,Gaz2det] = calcG(locationdetail(2),y0);
[~,~,Gaz3det] = calcG(locationdetail(3),y0);
[~,~,Gaz4det] = calcG(locationdetail(4),y0);
[~,~,Gaz5det] = calcG(locationdetail(5),y0);

%% C part
[G_c] = calcGroot(y0);
figure
rlocus(G_c);

%% D part
[r_ideal] = idealpoles(y0);

%% E part
%k_rg = [0,0.1,1,5];    %experiments
k_rg = 0.26;                %selected
s=tf('s');
for a=1:length(k_rg)
    Gc(a)=(-Gq)/(1- k_rg(a)*Gq);
    figure
    rlocus(Gc(a)/s);
    hold on;
    scatter([real(r_ideal)], [imag(r_ideal)],'*','r')
    %xlim([-40,1]);
    %ylim([-100,100]);
    legend('','ideal poles');
    title(['K_rg =',num2str(k_rg(a),3)]);
end
ka=0.438;   %found based on plot for k_rg = 0.26;  

%tal values for H part
tal = 0.25;
tal2=0.3;
tal3=0.35;
tal4=0.4;

k_rg1 = 0.48;
k_rg2 = 0.2;
k_rg3 = 1.0;
ka2 = 1.2;


%% Plots

time1 =10; %s
figure
hold on;
step(Gq,time1);
t=-1:0.05:time1;
plot(t, heaviside(t), 'LineWidth',2);
axis([-1 time1 -6 1.1]);
legend('$G_q$ for 10s','input $\delta_e$','Interpreter','Latex');
hold off

figure
hold on;
step(Gaz,time1);
t=-1:0.05:time1;
plot(t, heaviside(t), 'LineWidth',2);
legend('$G_a_z$ for 10s','input $\delta_e$','Interpreter','Latex');
hold off

time2 =100; %s
figure
hold on;
step(Gq,time2);
t=-1:0.05:time2;
plot(t, heaviside(t), 'LineWidth',2);
axis([-1 time2 -6 1.1]);
legend('$G_q$ for 100s','input $\delta_e$','Interpreter','Latex');
hold off

figure
hold on;
step(Gaz,time1);
step(Gaz1,time1);
step(Gaz2det,time1);
step(Gaz2,time1);
step(Gaz4det,time1);
step(Gaz3,time1);
step(Gaz2det,time1);
step(Gaz4,time1);
step(Gaz5,time1);
t=-1:0.05:time1;
plot(t, heaviside(t), 'LineWidth',2);
xlim([-0.1,0.4]);
legend('l=0','l=1','l=1.5','l=2','l=2.5','l=3','l=4','l=4.5','l=5','input $\delta_e$','Interpreter','Latex');
hold off
