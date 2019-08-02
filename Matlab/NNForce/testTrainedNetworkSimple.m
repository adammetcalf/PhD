clc;
clear;

load('xandymapped.mat');


%test the neural network

%load the weights
wi1 = load('Wi1.csv');
w12 = load('W12.csv');
w2o = load('W2o.csv');

%load the biases
b1 = load('bias1.csv');
b2 = load('bias2.csv');
b3 = load('bias3.csv');


for i=1:sizedata(1)

    in = [raw1(i);raw2(i);raw3(i);raw4(i)];
    out = [Fx(i)*100,Fy(i)*100];
    
    out1 = threshold((wi1*in)+b1);
    
    out2 = threshold((w12*out1)+b2);
    
    out3 = threshold((w2o*out2)+b3);
 
       
    output = [out3(1)*100,out3(2)*100,out]
    
    pause(2);
end


