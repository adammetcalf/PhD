function [J_theta_COM2c] = J_theta_COM2c(T0_rad)

%This function gets COM2c jacobian transform in cartesian space for maxon
%motor

L = 30; %needs checking for actual distance

J_theta_COM2c = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];