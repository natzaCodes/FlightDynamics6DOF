clc;
clear;
close all;

fttom = 0.3048;
t=20;
Delta_deltae0 = [0.001, 0.01, 0.1];
tal = 0.05;
q_p = 0.05;

%% initial conditions 
u=convvel(634,'ft/s','m/s');
w=0;
q=0;
teta=0;
xf=0;
zf=15000*fttom;
e = 0;
Delta_deltaei =0;

%% reference state
u0 = convvel(634,'ft/s','m/s');
w0 = 0;
q0=0;
teta0=0;
xf0=0;
zf0=15000*fttom;
e0 = 0;
Delta_deltaei0 =0;
y0=[u0, w0, q0, teta0, xf0, zf0];
y0B = [u0, w0, q0, teta0, xf0, zf0, e0, Delta_deltaei0];


%% calculations
int=[0 t];
ic=[u w q teta xf zf];                     
[timeout1, yout1]=ode45(@(t,y)PlaneModel3A(y,y0,Delta_deltae0(1)),int,ic);
[timeout2, yout2]=ode45(@(t,y)PlaneModel3A(y,y0,Delta_deltae0(2)),int,ic);
[timeout3, yout3]=ode45(@(t,y)PlaneModel3A(y,y0,Delta_deltae0(3)),int,ic);

icB=[u w q teta xf zf e Delta_deltaei];    
[timeout4, yout4]=ode45(@(t,y)PlaneModel3B(y,y0B, q_p, tal),int,icB);


%% Plots

figure
hold on;
plot(timeout1, yout1(:,3))
time=-1:0.05:t;
plot(time, heaviside(time)*0.001, 'LineWidth',2);
ylabel('q [rad/s]');
xlabel('t [s]');
xlim([0 t]);
legend('q response','input $\Delta \delta_{e,0}$ = 0.001','Interpreter','Latex');
hold off;
grid on;

figure
hold on;
plot(timeout2, yout2(:,3))
plot(time, heaviside(time)*0.01, 'LineWidth',2);
ylabel('q [rad/s]');
xlabel('t [s]');
xlim([0 t]);
legend('q response','input $\Delta \delta_{e,0}$ = 0.01','Interpreter','Latex');
hold off;
grid on;

figure
hold on;
plot(timeout3, yout3(:,3))
plot(time, heaviside(time)*0.1, 'LineWidth',2);
ylabel('q [rad/s]');
xlabel('t [s]');
xlim([0 t]);
legend('q response','input $\Delta \delta_{e,0}$ = 0.1','Interpreter','Latex');
hold off;
grid on;


qp = linspace(q_p,q_p,length(timeout4));
figure
hold on;
plot(timeout4, qp)
plot(timeout4, yout4(:,3))
ylabel('q [rad/s]');
xlabel('t [s]');
ylim([0,0.055])
legend('$q_p$ = 0.05', 'q response','Interpreter','Latex')
grid on;
hold off


