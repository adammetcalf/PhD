function [J_theta_COM2f] = J_theta_COM2f(T0_rad)

%This function gets COM2f jacobian transform in cartesian space for 
%bevelgear2

L = 30; %needs checking for actual distance

J_theta_COM2f = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];