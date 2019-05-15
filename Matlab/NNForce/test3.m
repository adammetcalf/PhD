clc;
clear;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Get data and process %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %import testdata
    sizedata = size(csvread('testdata.csv',1,0));
    rawdata = csvread('testdata.csv',1,0,[1,0,sizedata(1),5]);
    %randomise row order to limit the risk of local minima
    data = rawdata(randperm(size(rawdata, 1)), :);
    %force,orientation,raw1,raw2,raw3,raw4

    %Create training vectors
    raw1 = data(:,3)/1000; %Raw bits from sensor 1
    raw2 = data(:,4)/1000; %Raw bits from sensor 2
    raw3 = data(:,5)/1000; %Raw bits from sensor 3
    raw4 = data(:,6)/1000; %Raw bits from sensor 4

    %Create answer vectors
    Fx = (data(:,1).*cos((deg2rad(data(:,2)))));
    
    %Process data to remove any tiny numbers (such as xE-17)caused by trig
    c=0;
    for count = 1:sizedata(1)
        c=c+1;
        if Fx(c) <0.01 && Fx(c) > -0.01
            Fx(c) = 0;
        end
    end
    
    %Scale to work nicely with NN maths
    Fx = Fx/100;
    
    Fy = (data(:,1).*sin((deg2rad(data(:,2)))));
    
    %Process data to remove any tiny numbers (such as xE-17)caused by trig
    c=0;
    for count = 1:sizedata(1)
        c=c+1;
        if Fy(c) <0.01 && Fy(c) > -0.01
            Fy(c) = 0;
        end
    end
    
    %Scale to work nicely with NN maths
    Fy = Fy/100;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%% End of data processing %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%define inputs
X3 = [raw1'
      raw2'    
      raw3'  
      raw4']; 
  
T3 = [Fx'
      Fy'];

%create a forwards propagation Neural Network with 1 hidden layer
%containing 2 neurons, and use a training fucntion which is one of the
%fastest in the Neural network toolbox
net = feedforwardnet([50,20],'trainlm'); 
 
%Set a training goal
net.trainParam.goal= 1e-6;

%Set epochs to 5000
net.trainParam.epochs=5000;

%Set the activation functions
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';

%Train the net
net.inputs{1}.processFcns= {};
net.outputs{2}.processFcns= {};
net = train(net,X3,T3);

 
%Extract weights and biases
wb = formwb(net,net.b,net.iw,net.lw);
[b,iw,lw] = separatewb(net,wb);

save('xandyunmapped');
