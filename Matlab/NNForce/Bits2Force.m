%This m file turns the raw bits into a force reading

%Magnet layout as below:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                  m4                      %%%%%
%%%%%                                          %%%%%
%%%%%           m1            m2               %%%%%
%%%%%                                          %%%%%
%%%%%                  m3                      %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

z1_base = 0; %unloaded z1 baseline
z2_base = 0; %unloaded z2 baseline
z3_base = 0; %unloaded z3 baseline
z4_base = 0; %unloaded z4 baseline

Br = 1.4; %N48 magnet has a Br o 1380-1420 mT
Hm = 0.0015; %Height of 1.5mm
Dm = 0.0065; %Diameter of 6.5mm

%Get Raw values from arduino
Raw1 = 0; %Rawbits1
Raw2 = 0; %Rawbits2
Raw3 = 0; %Rawbits3
Raw4 = 0; %Rawbits4

% Convert Raw bits to Voltage, offset by 2.5 to bring to 0V when unloaded
V1 = (Raw1*0.0048828125)-2.5;
V2 = (Raw1*0.0048828125)-2.5;
V3 = (Raw1*0.0048828125)-2.5;
V4 = (Raw1*0.0048828125)-2.5;

%Convert voltage to gauss
B1 = V1/0.00312; %Mag1
B2 = V2/0.00312; %Mag2
B3 = V3/0.00312; %Mag3
B4 = V4/0.00312; %Mag4

%Convert gauss to Tesla
B1 = B1/10000;
B2 = B2/10000;
B3 = B3/10000;
B4 = B4/10000;

%Convert gauss to height
z1 =   ((Br^2*Hm^2 - B1^2*Dm^2)^(1/2) - 2*B1*Hm)/(2*B1) -((Br^2*Hm^2 - B1^2*Dm^2)^(1/2) + 2*B1*Hm)/(2*B1);
z2 =   ((Br^2*Hm^2 - B2^2*Dm^2)^(1/2) - 2*B2*Hm)/(2*B2) -((Br^2*Hm^2 - B2^2*Dm^2)^(1/2) + 2*B2*Hm)/(2*B2);
z3 =   ((Br^2*Hm^2 - B3^2*Dm^2)^(1/2) - 2*B3*Hm)/(2*B3) -((Br^2*Hm^2 - B3^2*Dm^2)^(1/2) + 2*B3*Hm)/(2*B3);
z4 =   ((Br^2*Hm^2 - B4^2*Dm^2)^(1/2) - 2*B4*Hm)/(2*B4) -((Br^2*Hm^2 - B4^2*Dm^2)^(1/2) + 2*B4*Hm)/(2*B4);

%Get change in z, in mm
dz1 = (z1-z1_base)*1000;
dz2 = (z2-z2_base)*1000;
dz3 = (z3-z3_base)*1000;
dz4 = (z4-z4_base)*1000;

%Get magnitudes:
fx = (8.76/2)*(abs(dz1-3.75)+abs(dz2-3.75));
fy = (8.76/2)*(abs(dz3-3.75)+abs(dz4-3.75));

%Get directions
if dz1>dz2
    fx=-fx;
end

if dz1>dz2
    fy=-fy;
end
