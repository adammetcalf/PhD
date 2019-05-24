clc;
clear;

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

%load the weights
W1 = load('Wi1.csv');
W2 = load('W12.csv');
W3 = load('W2o.csv');

%load the biases
b1 = load('bias1.csv');
b2 = load('bias2.csv');
b3 = load('bias3.csv');


for i=1:sizedata(1)

    in = [raw1(i);raw2(i);raw3(i);raw4(i)];
    out = [Fx(i)*100,Fy(i)*100];
 
    % Layer 1
    
    a1 = threshold(b1 + W1*in);
    

    % Layer 2
    
    a2 = threshold(b2 + W2*a1);
    
    
    % Layer 3
    
    a3 = threshold(b3 + W3*a2);
    
         
    output(:,i) = [a3(1)*100,a3(2)*100]-out;
    
end

it = 1:1:sizedata(1);
figure (1)
subplot(1,2,1)
plot(it, output(1,:));
xlabel('iteration')
ylabel('X-error (N)')

subplot(1,2,2)
plot(it, output(2,:));
xlabel('iteration')
ylabel('Y-error (N)')

avx = sum(abs(output(1,:)))/count
avy = sum(abs(output(2,:)))/count
maxerrorx = max(abs(output(1,:)))
maxerrory = max(abs(output(2,:)))