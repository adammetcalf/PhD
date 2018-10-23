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

%Initialise end effector Jacobian (J_ee_theta)(should probably make this a
%function, since it will be called every iteration of the loop).
J_ee_theta = [-L0*sin(T0_rad)-L1*sin(T0_rad+T1_rad) -L1*sin(T0_rad+T1_rad)
              L0*cos(T0_rad)+L1*cos(T0_rad+T1_rad) +L1*cos(T0_rad+T1_rad)
              0 0
              0 0
              0 0
              1 1];

%Perform Forward Kinematics.
[X0,X1,X2] = FKin(L0,L1,T0_rad,T1_rad);

%Create chart.
[x,y] = cartesian(X0,X1,X2);
hold on
plot (x,y)
linkdata on

% Begin State Machine loop.
Stop = false; %set stop tag to false.
state = "getuserinput"; %set 1st state to get the desired coordinates
while Stop == false

    if state=="getuserinput"
    %Build vector X2des, which is the desired x and y of the end effector
        
        %Get the desired x-coordinate
        x2des = input('what is the desired x coordinate?');
        
        %Get the desired y-coordinate
        y2des = input('what is the desired y coordinate?');
        
        %Build the desired end effector vector
        X2des = [x2des, y2des];    
    
        %Next state = Inverse Kinematics
        state = "IK";
        
    elseif state =="IK"
    %Perform Inverse Kinematics to turn X2des into Desired Angles.
        
        %Perform Forward Kinematics.
        [T0_des, T1_des] = IKin(L0,L1,X2des);
        
        %Next state = Forward Kinematics
        state = "FK";
        
    elseif state=="FK"
    %Perform Forward kinematics to obtain current positions.
    
        %Perform Forward Kinematics.
        [X0,X1,X2] = FKin(L0,L1,T0_rad,T1_rad);
        
        %Next state = Control
        state = "control";
        
    elseif state =="control"
    %Implement control algorithm
    
        %Next state = display
        state = "display";
        
    elseif state == "display"
    %Update chart
    [x,y] = cartesian(X0,X1,X2);
        
    elseif state == "finish"
    % change stop tag to true to stop loop
    Stop = True;
    
    end
    
end