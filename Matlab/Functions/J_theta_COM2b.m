function [J_theta_COM2b] = J_theta_COM2b(T0_rad)

%This function gets COM2b jacobian transform in cartesian space for L8 
%aluminium tube cover

L = 30; %needs checking for actual distance

J_theta_COM2b = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];