clc;
clear;

%%%%%% Init %%%%%%

startPoint = [0,0]; %set the start point (mm)
targetPoint = [1000,1000]; %set the target point (mm)
currentPoint = startPoint; %initialise the current point
adjustedPoint = currentPoint; %initialise the adjusted point
AttractorPoint = [470,500]; %initialise attractor point
k = 1000; %arbitrary spring const
c = 0.001; %arbitrary damping const
t_const = 0.02; %Arbitrary const time for filter
velocity = 200; %mm/s
dt = 0.1; %set dt (seconds)
t = 0; %set start time
i = 1; %init loop count
%%%%%% End Init %%%%%%%

%%%%% Process data %%%%%%

xi = startPoint(1);
yi = startPoint(2);
xf = targetPoint(1);
yf = targetPoint(2);
a = (xf-xi)^2;
b = (yf-yi)^2;
totalDistance = sqrt(a+b); %find total distance with pythagoras
tf = totalDistance/velocity; %find the final time from start
x_triangle = xf-xi; %for min jerk
y_triangle = yf-yi; %for min jerk

%%%%%% End Process data %%%%%

%%%%-----------------Start Loop-----------------------------%%%%%
while (t <= tf)

t = t+dt; %increment time

%Evaluate x and y distance from attractor 
x_dis = AttractorPoint(1)-currentPoint(1); %is the absolute distance correct? or do I need direction too?
y_dis = AttractorPoint(2)-currentPoint(2);  %is the absolute distance correct? or do I need direction too?

%Evaluate Fx and Fy applied by attractor
%Fx = k/x_dis;
%Fy = k/y_dis;

%Evaluate Virtual Admittance Filter
%deltaX = (Fx/k)*(1-exp(((-k*t_const)/c)))
%deltaY = (Fy/k)*(1-exp(((-k*t_const)/c)))
deltaX = (100/(x_dis))*(1-exp(((-1/2.5))))
deltaY = (100/(y_dis))*(1-exp(((-1/2.5))))

%evaluate min jerk
t_triangle = t/tf;
currentPoint(1) = xi + (x_triangle*(6*(t_triangle)^5-15*(t_triangle)^4+10*(t_triangle)^3));   
currentPoint(2) = yi + (y_triangle*(6*(t_triangle)^5-15*(t_triangle)^4+10*(t_triangle)^3));

%Evaluate adjusted point
adjustedPoint(1) = currentPoint(1)+deltaX;
adjustedPoint(2) = currentPoint(2)+deltaY;


Allx(i) = currentPoint(1); %keep a log of all x points generated
Ally(i) = currentPoint(2); %keep a log of all y points generated
AllAdjustedx(i) = adjustedPoint(1); %keep a log of all x points generated
AllAdjustedy(i) = adjustedPoint(2); %keep a log of all y points generated

%evaluate min jerk vel
velx(i) = (x_triangle)*(30*(t^4/tf^5)-60*(t^3/tf^4)+30*(t^2/tf^3));
vely(i) = (y_triangle)*(30*(t^4/tf^5)-60*(t^3/tf^4)+30*(t^2/tf^3));

%%%% Plot %%%%%
f = figure(1); %figure 1 is the desired position
clf(f);
%subplot(1,3,1)
plot(startPoint(1),startPoint(2),'kx','MarkerSize', 10,'LineWidth', 2) %start point
hold on
plot(AttractorPoint(1),AttractorPoint(2),'rx','MarkerSize', 10,'LineWidth', 2) %attractor point
hold on
plot(currentPoint(1),currentPoint(2),'b.','MarkerSize', 20) %current point
hold on
plot(adjustedPoint(1),adjustedPoint(2),'r.','MarkerSize', 20) %adjusted point
hold on
plot(targetPoint(1),targetPoint(2),'kx','MarkerSize', 10,'LineWidth', 2) %target point
hold on
plot(AllAdjustedx,AllAdjustedx,'r.-') %adjusted point history
hold on
plot(Allx,Ally,'b.-') %current point history
xlabel('Desired x (mm)')
ylabel('Desired y (mm)')

%subplot(1,3,2)
%plot(currentPoint(1),velx(i),'b.','MarkerSize', 20) %vel vs pos
%hold on
%plot(Allx,velx,'r.-') %vel vs pos history
%hold on

%subplot(1,3,3)
%plot(currentPoint(2),vely(i),'b.','MarkerSize', 20) %vel vs pos
%hold on
%plot(Ally,vely,'r.-') %vel vs pos history
%hold on
%%%% End Plot %%%%%

i=i+1; %increase loop count
end
%%%%-------------------End Loop-----------------------%%%%%