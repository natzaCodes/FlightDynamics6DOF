clc;
clear;
close all;

fttom = 0.3048;
t=200;


%% initial conditions 
u=convvel(634,'ft/s','m/s');
v =0;
w=0;
p=0;
q=0;
r=0.0;
phi=0;
teta=0.1;
psi=0;
xf=0;
yf=0;
zf=-15000*fttom;


%% reference state
u0=convvel(634,'ft/s','m/s');
v0 =0;
w0=0;
p0=0;
q0=0;
r0=0;
phi0=0;
teta0=0;
psi0=0;
xf0=0;
yf0=0;
zf0=-15000*fttom;

y0=[u0,v0,w0,p0,q0,r0,phi0,teta0,psi0,xf0,yf0,zf0];
y0c=[u0, w0, q0, teta0, xf0, zf0];



%% calculations
int=[0 t];
ic=[u v w p q r phi teta psi xf yf zf];    
icC=[u w q 0.1 xf zf];
[timeoutA, youtA]=ode45(@(t,y)PlaneModel5A(y,y0),int,ic);
[timeoutC, youtC]=ode45(@(t,y)PlaneModelC(y,y0c),int,icC);

%% Plot

subplot(3,2,1);
plot(timeoutA, youtA(:,1))
ylabel(' u [m/s]');
xlabel('t [s]');
grid on;

subplot(3,2,3); 
plot(timeoutA, youtA(:,2))
ylabel('v [m/s]');
xlabel('t [s]');
grid on;

subplot(3,2,5);
plot(timeoutA, youtA(:,3))
ylabel('w [m/s]');
xlabel('t [s]');
grid on;

subplot(3,2,2); 
plot(timeoutA, youtA(:,4))
ylabel('p [rad/s]');
xlabel('t [s]');
grid on;

subplot(3,2,4);
plot(timeoutA, youtA(:,5))
ylabel('q [rad/s]');
xlabel('t [s]');
grid on;

subplot(3,2,6); 
plot(timeoutA, youtA(:,6))
ylabel('r [rad/s]');
xlabel('t [s]');
grid on;


figure
subplot(3,2,1);
plot(timeoutA, youtA(:,7))
ylabel('\phi [rad]');
xlabel('t [s]');
grid on;

subplot(3,2,3); 
plot(timeoutA, youtA(:,8))
ylabel('\theta [rad]');
xlabel('t [s]');
grid on;

subplot(3,2,5);
plot(timeoutA, youtA(:,9))
ylabel('\psi [rad]');
xlabel('t [s]');
grid on;

subplot(3,2,2); 
plot(timeoutA, youtA(:,10))
ylabel('xf [m]');
xlabel('t [s]');
grid on;

subplot(3,2,4);
plot(timeoutA, youtA(:,11))
ylabel('yf [m]');
xlabel('t [s]');
grid on;

subplot(3,2,6); 
plot(timeoutA, youtA(:,12))
ylabel('zf [m]');
xlabel('t [s]');
grid on;

figure
h=plot(youtA(:,10), youtA(:,12),youtC(:,5), youtC(:,6));
set(h(1),'linewidth',2);
set(h(2),'linewidth',1);
ylabel('zf [m]');
xlabel('xf [m]');
legend('$z^f(x^f)$ from Assignment 5b','$z^f(x^f)$ from Assignment 1c','Interpreter','Latex');
grid on;


figure
hold on;
plot(youtA(:,10), youtA(:,11));
ylabel('yf [m]');
xlabel('xf [m]');
grid on;
hold off;

