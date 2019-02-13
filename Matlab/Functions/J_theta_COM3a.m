function [J_theta_COM3a] = J_theta_COM3a(L0,T0_rad)

%This function gets COM3a jacobian transform in cartesian space for
%bevelpinion and elbow gearbox shaft

J_theta_COM3a = [-L0*sin(T0_rad) 0
                  L0*cos(T0_rad) 0
                  0 0
                  0 0
                  0 0
                  1 1];