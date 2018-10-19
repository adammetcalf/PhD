function [x,y] = cartesian(X0,X1,X2);

% The purpose of this fucntion is to manipulate the matrices to create
% plottable x and y matrices

x = [X0(1),X1(1),X2(1)];
y = [X0(2),X1(2),X2(2)];