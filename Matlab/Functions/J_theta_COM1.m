function [J_theta_COM1] = J_theta_COM1(L0,T0_rad)

%This function gets COM1 jacobian transform in cartesian space.

J_theta_COM1 = [-0.5*L0*sin(T0_rad) 0
              0.5*L0*cos(T0_rad) 0
              0 0
              0 0
              0 0
              1 1];