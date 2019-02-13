function [J_theta_COM2e] = J_theta_COM2e(T0_rad)

%This function gets COM2e jacobian transform in cartesian space for 
%bevelgear1

L = 30; %needs checking for actual distance

J_theta_COM2e = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];