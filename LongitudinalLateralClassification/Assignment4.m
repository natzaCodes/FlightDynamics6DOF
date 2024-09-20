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

[Along, Alat] = MatrixA(y0);
[Blong, Blat] = MatrixB(y0);

%% Part A
% diagonal matrix D of eigenvalues and matrix V whose columns are the corresponding right eigenvectors
%[Vlong,Dlong] = eig(Along)
%[Vlat,Dlat] = eig(Alat)

Dlong(1,1) = -19.33312 +0.00000i;
Dlong(2,2) = -7.14874 +0.00000i;
Dlong(3,3) = -0.04254 +0.64181i;
Dlong(4,4) = -0.04254 -0.64181i;

Dlat(1,1) = -20.84182 +0.00000i;
Dlat(2,2)= -1.51248 +5.42156i;
Dlat(3,3)= -1.51248 -5.42156i;
Dlat(4,4)= -0.02024 +0.00000i;


%% Part B
% Longitudinal SP
[zeta_sp] = eqSysSolver(real(Dlong(1,1)),imag(Dlong(1,1))); %lvl 2

% Longitudinal the phugoid
[zeta_p] = eqSysSolver(real(Dlong(4,4)),imag(Dlong(4,4)));  %lvl 1

% Lateral roll mode
T_r = -1/Dlat(1,1); %lvl 1

% Lateral the spiral mode
T_s = log(2)/Dlat(4,4); %lvl 1
T_s2 = -log(2)/(Dlat(4,4));

%Lateral directional oscilations
[zeta_dr] = eqSysSolver(real(Dlat(2,2)),imag(Dlat(2,2)));  %lvl 2
omega_dr = -real(Dlat(2,2))/zeta_dr;
omegazeta= zeta_dr*omega_dr;


%% Part C
%transfer function
sysLong = ss(Along,Blong,eye(4),0);
tfsysLong = tf(sysLong);
Gq = tfsysLong(3);

time1 =200; %s
figure
hold on;
step(Gq,time1);
t=-1:0.05:time1;
plot(t, heaviside(t), 'LineWidth',2);
%axis([-1 time1 -6 1.1]);
legend('Transfer function for 100s','input $\delta_e$','Interpreter','Latex');
hold off

%% Part D
g =9.81;
p = [-18.88 -20.62 -0.1449 0];
r = roots(p);
T_theta2 = 1/1.0851;
omega_nsp = -real(Dlong(1,1))/zeta_sp;
CAP = omega_nsp^2*g*T_theta2/y0(1);


