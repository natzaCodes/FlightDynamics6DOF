function [dy_dt,AoA] = PlaneModelD(y,y0)
%PlaneModel returns vector with dot-values
%   y = [u,w,q,teta,xf,zf]

  %constants
  g = 9.81;
  ft2m = 0.3048;
  Xu = -0.0098;
  Xalpha = -16.96 *ft2m;
  Xw = Xalpha/y0(1); 
  Zu = -0.109;
  Zalpha = -733.6 *ft2m;
  Zw = Zalpha/y0(1);
  Malpha = -9.096;
  Mw= (-1)*(Malpha/y0(1));
  Mq = -0.696;
  
  
  dy_dt(1) =  -y(3)*y(2) - g*sin(y(4)) + g*sin(y0(4)) + Xu*(y(1)-y0(1)) + Xw*(y(2)-y0(2));
  dy_dt(2) =   y(3)*y(1) + g*cos(y(4)) - g*cos(y0(4)) + Zu*(y(1)-y0(1)) + Zw*(y(2)-y0(2));
  dy_dt(3) =   Mw*(y(2)-y0(2)) + Mq*(y(3)-y0(3));
  dy_dt(4) =   y(3);
  dy_dt(5) =   y(1)*cos(y(4))  + y(2)*sin(y(4)); 
  dy_dt(6) = (-y(1)*sin(y(4))  + y(2)*cos(y(4)))*(-1);
  
  dy_dt = transpose(dy_dt);

end