function [Along, Alat] = MatrixA(y0)
%MatrixA returns A from xdot=Ax+Bdeltae
%   y = [u,w,q,teta,xf,zf]

  %constants
  g = 9.81;
  ft2m = 0.3048;

  % Longitudinal data
  Xu = -0.0098;                %s-1
  Xalpha = -16.96 *ft2m;       %m/s2
  Xw = Xalpha/y0(1);
  Zu = -0.109;                 %s-1
  Zalpha = -733.6 *ft2m;       %m/s2
  Zw = Zalpha/y0(1);
  %Z_deltae = -99.84 *ft2m;     %m/s2
  Malpha = -9.096;             %s-2
  Mw= Malpha/y0(1);
  Mq = -0.696;                 %s-1
  %M_deltae = -18.90;           %s-2
  M_alphadot = -0.134;         %s-1
  M_omegadot = M_alphadot/y0(1);   %s-1
  Mu = 0.0001/ft2m;                  %m-1s-1
  
  % Lateral data
  Y_beta = -118.6*ft2m;       %m/s2
  Yp= 0;
  Yr= 0;
  L_beta= -28.59;             %s-2
  Lp= -2.665;                 %s-1
  Lr= 0.979;                  %s-1
  N_beta= 4.787;              %s-2
  Np= -0.001;                 %s-1
  Nr= -0.591;                 %s-1
  

  Along = [Xu Xw 0 -g; 
           Zu Zw y0(1) 0;
           Mu+M_omegadot*Zu Mw+M_omegadot*Zw Mq+M_omegadot*y0(1) 0;
           0 0 1 0];
   
  Alat = [Y_beta/y0(1) Yp/y0(1) -(1-Yr/y0(1)) g/y0(1);
          L_beta Lp Lr 0;
          N_beta Np Nr 0;
          0 1 0 0];

end