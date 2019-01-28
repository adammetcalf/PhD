function [J_theta_COM2] = J_theta_COM2(L0,T0_rad)

%This function gets COM2 jacobian transform in cartesian space.

J_theta_COM2 = [-L0*sin(T0_rad) 0
              L0*cos(T0_rad) 0
              0 0
              0 0
              0 0
              1 1];