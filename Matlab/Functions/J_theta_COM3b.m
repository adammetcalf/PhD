function [J_theta_COM3b] = J_theta_COM3b(L0,T0_rad,T1_rad)

%This function gets COM3b jacobian transform in cartesian space for handlebar.

J_theta_COM3b = [-L0*sin(T0_rad)-L*sin(T0_rad+T1_rad) -L*sin(T0_rad+T1_rad)
                  L0*cos(T0_rad)+L*cos(T0_rad+T1_rad) +L*cos(T0_rad+T1_rad)
                  0 0
                  0 0
                  0 0
                  1 1];