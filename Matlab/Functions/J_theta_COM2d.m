function [J_theta_COM2d] = J_theta_COM2d(T0_rad)

%This function gets COM2d jacobian transform in cartesian space for L9 Link
%Cover

L = 30; %needs checking for actual distance

J_theta_COM2d = [-L*sin(T0_rad) 0
                  L*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];