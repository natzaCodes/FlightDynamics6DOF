function [dy_dt] = PlaneModel3A(y,y0,Delta_deltae)
%PlaneModel returns vector with dot-values
%   y = [u,w,q,teta,xf,zf]

  %constants
  g = 9.81;
  ft2m = 0.3048;

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
  
  X_m = g*sin(y0(4)) + Xu*(y(1)-y0(1)) + Xw* (y(2)-y0(2));
  Z_m = -g*cos(y0(4)) + Zu*(y(1)-y0(1)) + Zw* (y(2)-y0(2)) + Z_deltae*Delta_deltae
  M_Iyy = Mw*(y(2)-y0(2)) + Mq*(y(3)-y0(3)) + M_deltae*Delta_deltae;
  
  dy_dt(1) =  -y(3)*y(2) - g*sin(y(4)) + X_m;
  dy_dt(2) =   y(3)*y(1) + g*cos(y(4)) + Z_m ;
  dy_dt(3) =   M_Iyy;
  dy_dt(4) =   y(3);
  dy_dt(5) =   y(1)*cos(y(4))  + y(2)*sin(y(4)); 
  dy_dt(6) = (-y(1)*sin(y(4))  + y(2)*cos(y(4)))*(-1);
  
  dy_dt = transpose(dy_dt);

end