clc;
clear;
close all;

fttom = 0.3048;

%% initial conditions
t=100;              %  100s for A,B; 200 for C; 100s for D; 20s for E 
u=convvel(634,'ft/s','m/s');
w=0;
q=0;
teta=0;
xf=0;
zf=15000*fttom;

%% reference state
u0 = convvel(634,'ft/s','m/s');
w0 = 0;
q0=0;
teta0=0;
xf0=0;
zf0=15000*fttom;
y0=[u0, w0, q0, teta0, xf0, zf0];

%% calculations
int=[0 t];
ic=[u w q teta xf zf];                         %initial conditions for A, B
icC=[u w q 0.1 xf zf];                         %initial conditions for C, D
icE=[u w 0.1 teta0 xf zf];                     %initial conditions for E
[timeoutA, youtA]=ode45(@(t,y)PlaneModelA(y),int,ic);
[timeoutB, youtB]=ode45(@(t,y)PlaneModelB(y),int,ic);
[timeoutC, youtC]=ode45(@(t,y)PlaneModelC(y,y0),int,icC);
[timeoutD, youtD]=ode45(@(t,y)PlaneModelD(y,y0),int,icC);
[timeoutE, youtE]=ode45(@(t,y)PlaneModelE(y,y0),int,icE);

%Analytical solution for A
x_analytic(1) =xf;
z_analytic(1)=zf;
for a=2:length(timeoutA)
    x_analytic(a)=x_analytic(a-1)+youtA(a-1,1)*(timeoutA(a,1)-timeoutA(a-1,1));
    z_analytic(a)=z_analytic(a-1)-(youtA(a-1,2)*(timeoutA(a,1)-timeoutA(a-1,1)));
end

%Angle of attack
AoAC = atan( youtC(:,2)./youtC(:,1) ); % Angle of attack for C
AoAC = AoAC * 180/pi;
AoAD = atan( youtD(:,2)./youtD(:,1) ); % Angle of attack for D
AoAD = AoAD * 180/pi;
AoAE = atan( youtE(:,2)./youtE(:,1) ); % Angle of attack for E
AoAE = AoAE * 180/pi;

%Find period time
[maxZf, idx] = max(youtC(:,6));
Period = 4* timeoutC(idx);
fprintf('Period time = %f s',Period);

% theta,u phaze difference
[maxTheta, idxt] = min(youtC(:,4));
[maxu, idxu] = min(youtC(:,1));
PhazeT = timeoutC(idxt);
PhazeU = timeoutC(idxu);
Phazediff = abs(PhazeT-PhazeU)*360/Period;
fprintf('Phaze difference = %f deg',Phazediff);


%% Plots
%If the same plot was made for more than one subsection (A/B/C/D/E), the
%formula stays the same, just data designations have been changed, for
%example istead of timeoutC, there was written timeoutD and analogously

subplot(3,2,1);
plot(timeoutC, youtC(:,1))
ylabel(' u [m/s]');
xlabel('t [s]');
grid on;

subplot(3,2,2); 
plot(timeoutC, youtC(:,2))
ylabel('w [m/s]');
xlabel('t [s]');
grid on;

subplot(3,2,3);
plot(timeoutC, youtC(:,3))
ylabel('q [rad/s]');
xlabel('t [s]');
grid on;

subplot(3,2,4); 
plot(timeoutC, youtC(:,4))
ylabel('\theta [rad]');
xlabel('t [s]');
grid on;

subplot(3,2,5);
plot(timeoutC, youtC(:,5))
ylabel('xf [m]');
xlabel('t [s]');
grid on;

subplot(3,2,6); 
plot(timeoutC, youtC(:,6))
ylabel('zf [m]');
xlabel('t [s]');
grid on;





figure
hold on;
plot(youtA(:,5), youtA(:,6), 'r');
scatter(x_analytic, z_analytic, '*', 'b');
ylabel('zf [m]');
xlabel('xf [m]');
legend('Numerical solution','Analytical solution');
grid on;
hold off;
%ylim([0,1e4]);

%{
figure
plot(x_analytic, z_analytic, 'r');
ylabel('zf [m]');
xlabel('xf [m]');
grid on;
%ylim([0,1e4]);


figure
plot(timeoutD, AoAD)
ylabel('Angle of Attack [deg]');
xlabel('t [s]');
grid on;


tet = rad2deg(youtC(:,4));
figure
yyaxis left
plot(youtC(:,5), tet,'b');
xlabel('$x^f$ [s]','Interpreter','Latex');
ylabel('$\theta$ [deg]]','Interpreter','Latex');
yyaxis right
plot(youtC(:,5), youtC(:,6 ),'r');
ylim([0,1e4]);
ylabel(' $z^f$ [m]','Interpreter','Latex');
legend('$\theta$(t)','Flight orientation','Interpreter','Latex')
grid on;


figure
yyaxis left
plot(timeoutC, youtC(:,4),'b');
xlabel('t [s]');
ylabel('\theta [deg]]');
yyaxis right
plot(timeoutC, youtC(:,1 ),'r');
ylabel(' u [m/s]');
legend('\theta','u')
grid on;


t = rad2deg(youtC(:,4));
figure
plot(t, AoAC)
ylabel('Angle of Attack [deg]');
xlabel('tetha');
grid on;

figure
yyaxis left
plot(timeoutC, t,'b');
xlabel('t [s]');
ylabel('\theta [deg]]');
yyaxis right
plot(timeoutC, AoAC,'r');
ylabel(' \alpha [deg]');
legend('\theta','\alpha');
grid on;
%}
