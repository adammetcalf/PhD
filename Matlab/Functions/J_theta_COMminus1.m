function [J_theta_COMminus1] = J_theta_COMminus1(T0_rad)

%This function gets COM-1 jacobian transform in cartesian space for L9 Link
%Aluminium cover

L = -30; %needs checking for actual negative distance

J_theta_COMminus1 = [-L*sin(T0_rad) 0
                      L*cos(T0_rad) 0
                      0 0
                      0 0
                      0 0
                      1 1];