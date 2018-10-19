clc; %clear the command window.
clear; % clear the workspace.

%initilise lengths.
L0 = 0.3; %meters.
L1 = 0.25; %meters.

%Initialse angles.
T0_deg = 0; %degrees.
T1_deg = 90; % degrees.
T0_rad = degtorad(T0_deg); % radians.
T1_rad = degtorad(T1_deg); % radians.

%Perform Forward Kinematics.
[X0,X1,X2] = FKin(L0,L1,T0_rad,T1_rad);

%Create chart.
[x,y] = cartesian(X0,X1,X2);
hold on
plot (x,y)
linkdata on

% Begin State Machine loop.
Stop = false; %set stop tag to false.
while Stop == false

    if state==getuserinput
    %Build vector X2des, which is the desired x and y of the end effector
        
        %Next state = Inverse Kinematics
        state = IK;
        
    elseif state ==Ik
    %Perform Inverse Kinematics to turn X2des into Desired Angles.
        
        %Next state = Forward Kinematics
        state = FK;
        
    elseif state==FK
    %Perform Forward kinematics to obtain current positions.
        
    elseif state ==control
    %Implement control algorithm
    
    elseif state == display
    %Update chart
        
    elseif state == finish
    % change stop tag to true to stop loop
    Stop = True;
    
    end
    
end