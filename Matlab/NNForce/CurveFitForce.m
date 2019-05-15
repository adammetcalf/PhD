clc;
clear;

%This is for curve fitting

Force = [0;1;1.5;2;2.5;3;3.5;4;4.5;5;5.5;6;6.5;7;7.5;8;8.5;9;9.5;10;10.5;11;25];

Displacement = [0
0.11421
0.17131
0.22841
0.28552
0.34262
0.39972
0.45682
0.51393
0.57103
0.62813
0.68542
0.74234
0.79944
0.85655
0.91365
0.97075
1.0279
1.085
1.1421
1.1992
1.2563
2.8552];

coeffs = polyfit(Force, Displacement, 1);
coeffs2 = polyfit( Displacement,Force, 1);

test = coeffs(1)*Force + coeffs(2);
test2 = coeffs2(1)*Displacement;

%disp = m*(Force)+c: m = coeffs(1) c = coeffs(2) === 0
%force = m*(displacement)+c: m = coeffs2(1) c = coeffs2(2) === 0
