clc;
clear;

m = 1;
k = 1;
b = 0.2;
F = 1;

A = [0 1; -k/m -b/m];
B = [0 1/m]';
C = [1 0];
D = [0];

sys = ss(A,B,C,D); %ss builds the system defined by A B C and D.

s = tf('s') %% tf defines s as a transfer function input
sys = 1/(m*s^2+b*s+k) % define the transfer fucntion in the laplace domain