function [dy_dt] = PlaneModel5A(y,y0)
%PlaneModel returns vector with dot-values
%   y = [u,v,w,p,q,r,phi,teta,psi,xf,yf,zf]

  %constants
  g = 9.81;
  ft2m = 0.3048;
  slugft2kgm2=1.356;

  Xu = -0.0098;                %s-1
  Xalpha = -16.96 *ft2m;       %m/s2
  Xw = Xalpha/y0(1);
  Zu = -0.109;                 %s-1
  Zalpha = -733.6 *ft2m;       %m/s2
  Zw = Zalpha/y0(1);
  Z_deltae = -99.84 *ft2m;     %m/s2
  Malpha = -9.096;             %s-2
  Mw= Malpha/y0(1);
  Mq = -0.696;                 %s-1
  M_deltae = -18.90;           %s-2
  Y_beta = -118.6*ft2m;        %m/s2
  Yv = Y_beta/y0(1);
  I_xx = 13490 * slugft2kgm2;  %kgm2 
  I_yy = 58970 * slugft2kgm2;  %kgm2
  I_zz = 67700 * slugft2kgm2;  %kgm2 
  I_xz = -848 * slugft2kgm2;   %kgm2 
  L_beta = -28.59;             %s-2
  Lv = L_beta/y0(1);
  Lp = -2.665;                 %s-1
  Lr = 0.979;                  %s-1
  N_beta = 4.787;              %s-2
  Nv = N_beta/y0(1);
  Np = -0.001;                 %s-1
  Nr = -0.591;                 %s-1
  
  
  
  X_m = g*sin(y0(8)) + Xu*(y(1)-y0(1)) + Xw*(y(3)-y0(3));
  Y_m = -g*cos(y0(8))*sin(y0(7)) + Yv*(y(2)-y0(2));
  Z_m = -g*cos(y0(8))*cos(y0(7)) + Zu*(y(1)-y0(1)) + Zw*(y(3)-y0(3));
  M_Iyy = Mw*(y(3)-y0(3)) + Mq*(y(5)-y0(5));
  L = I_xx*(Lv*(y(2)-y0(2)) + Lp*(y(4)-y0(4)) + Lr*(y(6)-y0(6)));
  N = I_zz*(Nv*(y(2)-y0(2)) + Np*(y(4)-y0(4)) + Nr*(y(6)-y0(6)));
  
  
  
  dy_dt(1) =  -y(5)*y(3) + y(6)*y(2) - g*sin(y(8)) + X_m;                      %u=1
  dy_dt(2) =   y(4)*y(3) - y(6)*y(1) +g*cos(y(8))*sin(y(7)) + Y_m;             %v=2
  dy_dt(3) =   y(5)*y(1) - y(4)*y(2) + g*cos(y(8))*cos(y(7)) + Z_m ;           %w=3
  dy_dt(5) =  -y(6)*y(5)*(I_xx-I_zz)/I_yy - I_xz*(y(4)^2-y(6)^2)/I_yy + M_Iyy; %q=5
%solving p  and r as system of eqs AY=B, where Y = [dy_dt(4);dy_dt(6)]=p;r 
  A=[I_xx -I_xz;
     -I_xz I_zz];
  B = [L - y(5)*y(6)*(I_zz-I_yy)+I_xz*y(4)*y(5);
       N - y(4)*y(5)*(I_yy-I_xx)-I_xz*y(5)*y(6)];
  [solution] = linsolve(A,B);
  dy_dt(4) = solution(1);                                                      %p=4
  dy_dt(6) = solution(2);                                                      %r=6
  
  dy_dt(7) =  y(4) + y(5)*sin(y(7))*tan(y(8)) + y(6)*cos(y(7))*tan(y(8));      %phi=7
  dy_dt(8) =  y(5)*cos(y(7)) - y(6)*sin(y(7));                                 %theta=8
  dy_dt(9) =  (y(5)*sin(y(7)) + y(6)*cos(y(7)))*sec(y(8));                     %psi=9
  dy_dt(10) =   y(1)*cos(y(8))*cos(y(9)) + y(2)*(cos(y(7))*sin(y(8))*cos(y(9))-cos(y(7))*sin(y(9))) + y(3)*(cos(y(7))*sin(y(8))*cos(y(9))+sin(y(7))*sin(y(9))); %xf
  dy_dt(11) =   y(1)*cos(y(7))*sin(y(9)) + y(2)*(cos(y(7))*sin(y(8))*cos(y(9))+cos(y(7))*cos(y(9))) + y(3)*(cos(y(7))*sin(y(8))*sin(y(9))-sin(y(7))*sin(y(9))); %yf
  dy_dt(12) =  -y(1)*sin(y(8))  + y(2)*sin(y(7))*cos(y(8)) + y(3)*cos(y(7))*cos(y(8));%zf
  
  dy_dt = transpose(dy_dt);
  
  
  
  