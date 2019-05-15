clc;
clear;

load('xandymapped.mat');

for i=1:sizedata(1)
    output = net([raw1(i);raw2(i);raw3(i);raw4(i)])*100;
    output = [output(1),Fx(i)*100,output(2),Fy(i)*100,output(1)-Fx(i)*100,output(2)-Fy(i)*100]
    pause(2);
end