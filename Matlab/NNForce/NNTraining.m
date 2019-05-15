
% clear command window and workspace
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
    
    %initialise dead zone for desired accuracy of errors
    DeadZone = 0.02;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%% End of data processing %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Initialise Neural Network %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% input layer = 4 nodes %%%
    %%% hidden layer 1 = n nodes, defined by user input hL1 %%%
    %%% hidden layer 2 = n nodes, defined by user input hL2 %%%
    %%% hidden layer 3 = n nodes, defined by user input hL3 %%%
    %%% output layer = 2 nodes (for Fx and Fy) %%%
    hL1 = 600;
    hL2 = 500;
    hL3 = 400;
    
    %define Learning Rate
    learningRate = 0.5;
    
    %define weights matrices, where weights matrix[rows,columns]
    % = [number of nodes on output layer, number of nodes on input layer]
    Weights_i_1 = -0.5 + (1).*rand(hL1,4);
    Weights_1_2 = -0.5 + (1).*rand(hL2,hL1);
    Weights_2_3 = -0.5 + (1).*rand(hL3,hL2);
    Weights_3_o = -0.5 + (1).*rand(2,hL3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%% End Neural Network Initialisation %%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Train the Neural Network %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %init i, which defines the row of data to test
    i=1;
    
    %init T, the count of how many times the network has been correct.
    % Note that T resets to zero every time the network is incorrect
    T = 0;


    while (T < 10000) %run until the network has been correct 10000 times in a row
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%% Forward propogation %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%% Input Layer Through Hidden Layer 1 %%%%%%%%%%

        inputs = [raw1(i);raw2(i);raw3(i);raw4(i)];
        
        %calculate signals into hidden layer 1
        out_layer_1 = Weights_i_1*inputs;
        %calculate signals emerging from hidden layer 1
        in_layer_2 =  threshold(out_layer_1);
        
        %%%%%%%%%% Layer 1 Complete %%%%%%%%%%

        %%%%%%%%%% Hidden Layer 1 Layer Through Hidden Layer 2 %%%%%%%%%%

        %calculate signals into hidden layer 2
        out_layer_2 = Weights_1_2*in_layer_2;
        %calculate signals emerging from hidden layer 2
        in_layer_3 =  threshold(out_layer_2);
        
        %%%%%%%%%% Layer 2 Complete %%%%%%%%%%

        %%%%%%%%%% Hidden Layer 2 Layer Through Hidden Layer 3 %%%%%%%%%%

        %calculate signals into hidden layer 3
        out_layer_3 = Weights_2_3*in_layer_3;
        %calculate signals emerging from hidden layer 3
        in_layer_4 =  threshold(out_layer_3);
        
        %%%%%%%%%% Layer 3 Complete %%%%%%%%%%    

        %%%%%%%%%% Hidden Layer 3 Layer Through Output layer %%%%%%%%%%

        %calculate signals into output layer
        out_layer_4 = Weights_3_o*in_layer_4;
        %calculate signals emerging from output layer
        output =  threshold(out_layer_4);

        %%%%%%%%%% Output Layer Complete %%%%%%%%%%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%% End of Forward propogation %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%% Check error %%%%%%%%%%

        Fxmin = Fx(i)-DeadZone;
        Fxmax = Fx(i)+DeadZone;
        Fymin = Fy(i)-DeadZone;
        Fymax = Fy(i)+DeadZone;

        if (output(1) >= Fxmin && output(1) <= Fxmax && output(2) >= Fymin && output(2) <= Fymax)
            % network is correct
            i = i+1;           
            T = T+1; %increase true count
 
        else   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%% Backwards propogation %%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            T =0;
            
            Target = [Fx(i);Fy(i)];
            
            %Evaluate Errors for output of each layer
            outputError = Target - output;
            hiddenError3_o = Weights_3_o'*outputError;
            hiddenError2_3 = Weights_2_3'*hiddenError3_o;
            hiddenError1_2 = Weights_1_2'*hiddenError2_3;
            
            %Update the weights
            deltaWeights_3_o = learningRate*((outputError.*output.*(1-output))*in_layer_4');
            deltaWeights_2_3 = learningRate*((hiddenError3_o.*in_layer_4.*(1-in_layer_4))*in_layer_3');
            deltaWeights_1_2 = learningRate*((hiddenError2_3.*in_layer_3.*(1-in_layer_3))*in_layer_2');
            deltaWeights_i_1 = learningRate*((hiddenError1_2.*in_layer_2.*(1-in_layer_2))*inputs');
            
            Weights_i_1 = Weights_i_1 + deltaWeights_i_1;
            Weights_1_2 = Weights_1_2 + deltaWeights_1_2;
            Weights_2_3 = Weights_2_3 + deltaWeights_2_3;
            Weights_3_o = Weights_3_o + deltaWeights_3_o;

        end

        
        if i > sizedata(1)
            i=1;
        end
        
        iT = [i,T,outputError(1),outputError(2)]
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%% End of Training of the Neural Network %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%