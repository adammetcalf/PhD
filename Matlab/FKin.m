function [X0,X1,X2] = FKin (L0,L1,T0,T1);

% This funtion uses the link lengths and angles and performs forward
% kinematics to findnthe end effector position.

%the shoulder is always at the origin
X0 = [0
    0];

%Find the position of the elbow
X1 = [L0*cos(T0)
      L0*sin(T0)];

%find the position of the hand
X2 = [L1*cos(T0+T1)
      L1*sin(T0+T1)];
X2 = X2+X1;
