%This is a dynamic model of the myPAM

clc; %clear the command window.
clear; % clear the workspace.

%initilise lengths.
L0 = 0.3; %meters.
L1 = 0.25; %meters.

%Initialse angles.
T0_deg = 0; %degrees.
T1_deg = 90; % degrees.
T0_rad = deg2rad(T0_deg); % radians.
T1_rad = deg2rad(T1_deg); % radians.

% Initialise Jacobian matrices for COMs in cartesian space. Note, this will
% be required every iteration of the loop, thus it is necessary to use
% functions

    %Initialise COM1 Jacobian, J_theta_COM1
    J_theta_COM1 = J_theta_COM1(L0,T0_rad);
    
    %Initialise COM2 Jacobian, J_theta_COM2
    J_theta_COM2 = J_theta_COM2(L0,T0_rad);
    
    %Initialise COM3 Jacobian, J_theta_COM3
    J_theta_COM3 = J_theta_COM3(L0,L1,T0_rad,T1_rad);

    %Initialise end effector Jacobian (COM4), J_ee_theta
    J_ee_theta = J_ee_theta(L0,L1,T0_rad,T1_rad);
    
% Initialise the Mass Matrices in cartesian space for each COM. Note, this
% only needs to be done once, therefore no functions need to be created for
% this.

    %Initialise COM1 Cartesian Mass Matrix, M_x1
    M_x1 = [];
    
    %Initialise COM2 Cartesian Mass Matrix, M_x2
    M_x2 = [];
    
    %Initialise COM3 Cartesian Mass Matrix, M_x3
    M_x3 = [];

    %Initialise COM4 Cartesian Mass Matrix, M_x4
    M_x4 = [];

%Initialise the Mass matrix in joint space. Note that this is a fucntion since it will be called every iteration of the loop.    
M_theta = M_theta(J_theta_COM1,J_theta_COM2,J_theta_COM4,J_ee_theta,M_x1,M_x2,M_x3,M_x4);

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