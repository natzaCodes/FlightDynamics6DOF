function [Gw,Gq,Gaz] = calcG(l,y0)
%calcG calculates G_w, G_q and G_a_z values
%   calculations based on assignment equations

ft2m = 0.3048;

M_deltae = -18.90;           %s-2
M_alpha = -9.096;            %s-2
M_omega = M_alpha/y0(1);
M_alphadot = -0.134;         %s-1
M_omegadot = M_alphadot/y0(1);
M_q = -0.696;                %s-1
Z_deltae = -99.84 *ft2m;     %m/s2
Z_alpha = -733.6 *ft2m;      %m/s2
Z_omega = Z_alpha/y0(1);     


b1 = M_deltae + M_omegadot*Z_deltae;
b0 = M_omega*Z_deltae - M_deltae*Z_omega;
d1 = Z_deltae;
d0 = -M_q*Z_deltae + y0(1)*M_deltae;
omega_nsp = sqrt(Z_omega*M_q - M_omega*y0(1));
zeta_sp = -(M_q + M_omegadot*y0(1) + Z_omega)/(2*omega_nsp);

s=tf('s');
Gq=tf([b1 b0],[1 (2*zeta_sp*omega_nsp) omega_nsp^2]);
Gw=tf([d1 d0],[1 (2*zeta_sp*omega_nsp) omega_nsp^2]);
Gaz=s*Gw-y0(1)*Gq-l*s*Gq;
%Gaz = tf([(d1-b1*l) (d0-b1*y0(1)-b0*l) b0*y0(1)], [1 (2*zeta_sp*omega_nsp) omega_nsp^2])


end

