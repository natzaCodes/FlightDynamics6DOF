function [r] = idealpoles(y0)
%idealpoles
%  Calculates ideal poles for aeroplane according to CAP-criterion giving
%  lvl 1 flying qualities
ft2m = 0.3048;
g = 9.81;

M_deltae = -18.90;           %s-2
M_alpha = -9.096;            %s-2
M_omega = M_alpha/y0(1);
M_alphadot = -0.134;         %s-1
M_omegadot = M_alphadot/y0(1);               %s-1
Z_deltae = -99.84 *ft2m;     %m/s2
Z_alpha = -733.6 *ft2m;      %m/s2
Z_omega = Z_alpha/y0(1);     

b1 = M_deltae + M_omegadot*Z_deltae;
b0 = M_omega*Z_deltae - M_deltae*Z_omega;
T_theta2 = b1/b0;

%ideal parameters
CAP = 1;
zeta_sp = 0.7;
omega_nsp = sqrt((CAP*y0(1))/(g*T_theta2));

r(1,1) = -zeta_sp*omega_nsp + (1i)*omega_nsp*sqrt(1-zeta_sp^2);
r(2,1) = -zeta_sp*omega_nsp - (1i)*omega_nsp*sqrt(1-zeta_sp^2);

end

