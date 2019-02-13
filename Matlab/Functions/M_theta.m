function [M_theta] = M_theta(J_theta_COM1,J_theta_COM2,J_theta_COM3,J_ee_theta,M_x1,M_x2,M_x3,M_x4)

%This function works out the single mass matrix in joint space using the
%cartesian mass matrices for each COM and the jacobian for each COM

M_theta1 = J_theta_COM1'*M_x1*J_theta_COM1;

M_theta2 = J_theta_COM2'*M_x2*J_theta_COM2;

M_theta3 = J_theta_COM3'*M_x3*J_theta_COM3;

M_theta4 = J_ee_theta'*M_x4*J_ee_theta;

M_theta = M_theta1+M_theta2+M_theta3+M_theta4;