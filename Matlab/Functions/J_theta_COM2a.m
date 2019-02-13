function [J_theta_COM2a] = J_theta_COM2a(T0_rad)

%This function gets COM2a jacobian transform in cartesian space for steel
%link rods

L = 30; %needs checking for actual distance

J_theta_COM2a = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];