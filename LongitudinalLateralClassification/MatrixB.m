function [Blong, Blat] = MatrixB(y0)
%MatrixB returns B from xdot=Ax+Bdeltae
%   y = [u,w,q,teta,xf,zf]

  %constants
  g = 9.81;
  ft2m = 0.3048;

  % Longitudinal data 
  Z_deltae = -99.84 *ft2m;         %m/s2
  M_deltae = -18.90;               %s-2
  M_alphadot = -0.134;             %s-1
  M_omegadot = M_alphadot/y0(1);   %s-1
  
  % Lateral data
  Y_deltar = 34.07 *ft2m;     %m/s2
  L_deltaa= 17.66;            %s-2
  L_deltar= 6.487;            %s-2
  N_deltaa= 0.36;             %s-2
  N_deltar= -5.948;           %s-2
  

  Blong = [0;
           Z_deltae;
           M_deltae + M_omegadot*Z_deltae;
           0];
   
  Blat = [0 Y_deltar/y0(1);
          L_deltaa L_deltar;
          N_deltaa N_deltar;
          0 0];

end