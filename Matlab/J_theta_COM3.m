function [J_theta_COM3] = J_theta_COM3(L0,L1,T0_rad,T1_rad)

%This function gets COM3 jacobian transform in cartesian space.

J_theta_COM3 = [-L0*sin(T0_rad)-0.5*L1*sin(T0_rad+T1_rad) -0.5*L1*sin(T0_rad+T1_rad)
              L0*cos(T0_rad)+0.5*L1*cos(T0_rad+T1_rad) +0.5*L1*cos(T0_rad+T1_rad)
              0 0
              0 0
              0 0
              1 1];