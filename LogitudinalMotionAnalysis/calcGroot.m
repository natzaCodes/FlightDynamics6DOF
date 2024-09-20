function [G] = calcGroot(y0)
%calcG calculates G walue for task c
%   calculations based on assignment equations

ft2m = 0.3048;

M_alpha = -9.096;            %s-2
M_omega = M_alpha/y0(1);
M_alphadot = -0.134;         %s-1
M_omegadot = M_alphadot/y0(1);
M_q = -0.696;                %s-1
Z_alpha = -733.6 *ft2m;      %m/s2
Z_omega = Z_alpha/y0(1);     


omega_nsp = sqrt(Z_omega*M_q - M_omega*y0(1));
zeta_sp = -(M_q + M_omegadot*y0(1) + Z_omega)/(2*omega_nsp);

G=tf([1 (2*zeta_sp*omega_nsp) omega_nsp^2],[1]);
end
