function y = threshold(n)
  y = 2 ./ (1 + exp(-2*n)) - 1;

  %This function performs the tansig activation fucntion on the output of
%the neural network layers