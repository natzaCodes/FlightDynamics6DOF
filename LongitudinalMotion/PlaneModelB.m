function [dy_dt] = PlaneModelB(y)
%PlaneModel returns vector with dot-values
%   y = [u,w,q,teta,xf,zf]

  %constants
  g = 9.81;
  slugft2kgm2=1.356;
  lbmtokg = 0.4536;
  m  = 21889 *lbmtokg;
  Iyy = 58970*slugft2kgm2;
  
  X = 0;
  Z= -g*m;
  M = 0;
    
  dy_dt(1) =  -y(3)*y(2) - g*sin(y(4)) + X/m;
  dy_dt(2) =   y(3)*y(1) + g*cos(y(4)) + Z/m;
  dy_dt(3) =   M/Iyy;
  dy_dt(4) =   y(3);
  dy_dt(5) =   y(1)*cos(y(4))  + y(2)*sin(y(4)); 
  dy_dt(6) = (-y(1)*sin(y(4))  + y(2)*cos(y(4)))*(-1);
  
  dy_dt = transpose(dy_dt);



end


