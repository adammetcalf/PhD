%clear workspace and command window
clc;
clear;
 
%define inputs
X = [ 0 0 1 1 ; %x1 coordinates
      0 1 0 1
      0 0 1 1
      0 1 0 1]; %x2 coordinates
T = [0 1 1 0
    0 1 1 0]; %XOR
 
%create a forwards propagation Neural Network with 1 hidden layer
%containing 2 neurons, and use a training fucntion which is one of the
%fastest in the Neural network toolbox
net = feedforwardnet(40,'trainlm'); 
 
%Set a training goal
net.trainParam.goal = [0.01*var(T(1)',1)];

 net1.layers{1}.transferFcn='logsig';
 net1.layers{2}.transferFcn='logsig';

%View the net
view(net);

%Train the net
net = train(net,X,T);

%Extract weights and biases
wb = formwb(net,net.b,net.iw,net.lw);
[b2,iw2,lw2] = separatewb(net,wb);
save('june10')