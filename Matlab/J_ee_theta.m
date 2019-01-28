function [J_ee_theta] = J_ee_theta(L0,L1,T0_rad,T1_rad)

%This function gets the end effector jacobian transform in cartesian space.

J_ee_theta = [-L0*sin(T0_rad)-L1*sin(T0_rad+T1_rad) -L1*sin(T0_rad+T1_rad)
              L0*cos(T0_rad)+L1*cos(T0_rad+T1_rad) +L1*cos(T0_rad+T1_rad)
              0 0
              0 0
              0 0
              1 1];