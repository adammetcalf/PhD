%This is a dynamic model of the myPAM. Need to do jacobians for all parts,
%mass matrices for all parts. Work out link lengths etc.

clc; %clear the command window.
clear; % clear the workspace.

%initilise lengths.
L0 = 0.42; %meters (Correct)
L1 = 0.25; %meters.

%Initialse angles.
T0_deg = 0; %degrees.
T1_deg = 90; % degrees.
T0_rad = deg2rad(T0_deg); % radians.
T1_rad = deg2rad(T1_deg); % radians.

% Initialise Jacobian matrices for COMs in cartesian space. Note, this will
% be required every iteration of the loop, thus it is necessary to use
% functions

    %initialise COM-1 Jacobian, J_theta_COM_neg1 for L9 Link cover
    J_theta_COMminus1 = J_theta_COMminus1(T0_rad); %Function built

    %Initialise COM1 Jacobian, J_theta_COM1 for Spur gear, waist gearbox
    %shaft and L6 Waist End Plate
    J_theta_COM1 = [0 0
                    0 0
                    0 0
                    0 0
                    0 0
                    1 1];
    
    %Initialise COM2a Jacobian, J_theta_COM2a for steel link rods
    J_theta_COM2a = J_theta_COM2a(T0_rad); %Function built
    
    %Initialise COM2b Jacobian, J_theta_COM2b for L8 aluminium tube cover
    J_theta_COM2b = J_theta_COM2b(T0_rad); %Function built
    
    %Initialise COM2c Jacobian, J_theta_COM2c for maxon motor
    J_theta_COM2c = J_theta_COM2c(T0_rad); %Function built
    
    %Initialise COM2d Jacobian, J_theta_COM2d for L9 Link cover
    J_theta_COM2d = J_theta_COM2d(T0_rad); %Function Built
    
    %Initialise COM2e Jacobian, J_theta_COM2e for bevelgear1
    J_theta_COM2e = J_theta_COM2e(L0,T0_rad); %Function Built
    
    %Initialise COM2f Jacobian, J_theta_COM2f for bevelgear2
    J_theta_COM2f = J_theta_COM2f(L0,T0_rad); %Function Built
        
    %Initialise COM3a Jacobian, J_theta_COM3a for bevelpinion and
    %elbowshaft
    J_theta_COM3a = J_theta_COM3a(L0,T0_rad); %Function Built
    
    %Initialise COM3b Jacobian, J_theta_COM3b for handlebar
    J_theta_COM3b = J_theta_COM3b(L0,T0_rad,T1_rad); %Function Built
    
    %Initialise end effector Jacobian (COM4), J_ee_theta
    J_ee_theta = J_ee_theta(L0,L1,T0_rad,T1_rad);
    
% Initialise the Mass Matrices in cartesian space for each COM. Note, this
% only needs to be done once, therefore no functions need to be created for
% this.

    %Initialise COM1 Cartesian Mass Matrix for spur gear, M_x1
    M_x1 = [0.444 0.444 0.444 0 0 0 %kg
            0.444 0.444 0.444 0 0 0
            0.444 0.444 0.444 0 0 0
            0 0 0 120738200 0 0     %kg*m^2
            0 0 0 0 120738200 0
            0 0 0 0 0 211899560];
    
    %Initialise COM2 Cartesian Mass Matrix for waist gearbox shaft, M_x2
    M_x2 = [0.191 0.191 0.191 0 0 0 %kg
            0.191 0.191 0.191 0 0 0
            0.191 0.191 0.191 0 0 0
            0 0 0 306195460 0 0     %kg*m^2
            0 0 0 0 306195460 0
            0 0 0 0 0 5359500];
    
    %Initialise COM3 Cartesian Mass Matrix for L6 waist endplate, M_x3
    M_x3 = [0.222 0.222 0.222 0 0 0 %kg
            0.222 0.222 0.222 0 0 0
            0.222 0.222 0.222 0 0 0
            0 0 0 1200555170 0 0    %kg*m^2
            0 0 0 0 68551490 0
            0 0 0 0 0 68551490];

    %Initialise COM4 Cartesian Mass Matrix for link rod, M_x4
    M_x4 = [0.042 0.042 0.042 0 0 0 %kg
            0.042 0.042 0.042 0 0 0
            0.042 0.042 0.042 0 0 0
            0 0 0 83120 0 0         %kg*m^2
            0 0 0 0 622658300 0
            0 0 0 0 0 622658300];
        
    %Initialise COM5 Cartesian Mass Matrix for L8 Aluminium Tube cover, M_x5
    M_x5 = [0.398 0.398 0.398 0 0 0 %kg
            0.398 0.398 0.398 0 0 0
            0.398 0.398 0.398 0 0 0
            0 0 0 387878080 0 0     %kg*m^2
            0 0 0 0 6811391540 0
            0 0 0 0 0 6811391540];
        
    %Initialise COM6 Cartesian Mass Matrix for maxon motor, M_x6
    M_x6 = [0 0 0 0 0 0 %kg
            0 0 0 0 0 0
            0 0 0 0 0 0
            0 0 0 0 0 0 %kg*m^2
            0 0 0 0 0 0
            0 0 0 0 0 0];

    %Initialise COM7 Cartesian Mass Matrix for L9 Link cover, M_x7
    M_x7 = [0.034 0.034 0.034 0 0 0 %kg
            0.034 0.034 0.034 0 0 0
            0.034 0.034 0.034 0 0 0
            0 0 0 17239260 0 0      %kg*m^2
            0 0 0 0 8665230 0
            0 0 0 0 0 8665230];
        
    %Initialise COM8 Cartesian Mass Matrix for bevel gear, M_x8
    M_x8 = [0.018 0.018 0.018 0 0 0 %kg
            0.018 0.018 0.018 0 0 0
            0.018 0.018 0.018 0 0 0
            0 0 0 779160 0 0        %kg*m^2
            0 0 0 0 632370 0
            0 0 0 0 0 632370];
        
    %Initialise COM9 Cartesian Mass Matrix for bevel pinion, M_x9
    M_x9 = [0.021 0.021 0.021 0 0 0 %kg
            0.021 0.021 0.021 0 0 0
            0.021 0.021 0.021 0 0 0
            0 0 0 1227310 0 0       %kg*m^2
            0 0 0 0 1227310 0
            0 0 0 0 0 2375120];      

    %Initialise COM10 Cartesian Mass Matrix for gearbox elbow shaft, M_x10
    M_x10 = [0.076 0.076 0.076 0 0 0 %kg
             0.076 0.076 0.076 0 0 0
             0.076 0.076 0.076 0 0 0
             0 0 0 68076850 0 0      %kg*m^2
             0 0 0 0 68076850 0
             0 0 0 0 0 1154790];         

    %Initialise COM11 Cartesian Mass Matrix for gearbox handlebar, M_x11
    M_x11 = [0.110 0.110 0.110 0 0 0 %kg
             0.110 0.110 0.110 0 0 0
             0.110 0.110 0.110 0 0 0
             0 0 0 10242970 0 0      %kg*m^2
             0 0 0 0 426310740 0
             0 0 0 0 0 426310740];          
         
%Initialise the Mass matrix in joint space. Note that this is a function since it will be called every iteration of the loop.    
M_theta = M_theta(J_theta_COM1,J_theta_COM2,J_theta_COM3,J_ee_theta,M_x1,M_x2,M_x3,M_x4);

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