clc;
clear;

xi= 0;
xf = 100;
tf = 2;
t = (0:0.001:tf);
ti = t/tf;

%Acceleration
x_0t = xi + (xf-xi)*(-2*(ti).^3+3*(ti).^2);
xdot_0t = (xf-xi)*(-6*(t.^2/tf^3)+6*(t.^1/tf^2));
Jpeak0 = max(xdot_0t);
Jav0 = mean(xdot_0t);
J0 = Jpeak0/Jav0;

%Jerk
x_1t = xi + (xf-xi)*(6*(ti).^5-15*(ti).^4+10*(ti).^3);
xdot_1t = (xf-xi)*(30*(t.^4/tf^5)-60*(t.^3/tf^4)+30*(t.^2/tf^3));
Jpeak1 = max(xdot_1t);
Jav1 = mean(xdot_1t);
J1 = Jpeak1/Jav1;

%Snap
x_2t = xi + (xf-xi)*(-20*(ti).^7+70*(ti).^6-84*(ti).^5+35*(ti).^4);
xdot_2t = (xf-xi)*(-140*(t.^6/tf^7)+420*(t.^5/tf^6)-420*(t.^4/tf^5)+140*(t.^3/tf^4));
Jpeak2 = max(xdot_2t);
Jav2 = mean(xdot_2t);
J2 = Jpeak2/Jav2;

%Crackle
x_3t = xi + (xf-xi)*(70*(ti).^9-315*(ti).^8+540*(ti).^7-420*(ti).^6+126*(ti).^5);
xdot_3t = (xf-xi)*(630*(t.^8/tf^9)-2520*(t.^7/tf^8)+3780*(t.^6/tf^7)-2520*(t.^5/tf^6)+630*(t.^4/tf^5));
Jpeak3 = max(xdot_3t);
Jav3 = mean(xdot_3t);
J3 = Jpeak3/Jav3;

%Pop
x_4t = xi + (xf-xi)*(-252*(ti).^11+1386*(ti).^10-3080*(ti).^9+3465*(ti).^8-1980*(ti).^7+462*(ti).^6);
xdot_4t = (xf-xi)*(-2772*(t.^10/tf^11)+13860*(t.^9/tf^10)-27720*(t.^8/tf^9)+27720*(t.^7/tf^8)-13860*(t.^6/tf^7)+2772*(t.^5/tf^6));
Jpeak4 = max(xdot_4t);
Jav4 = mean(xdot_4t);
J4 = Jpeak4/Jav4;


figure (1)
subplot(1,2,1)
plot(t,x_0t,'c',t,x_1t,'r',t,x_2t,'b',t,x_3t,'k',t,x_4t,'g');
xlabel('Time(s)')
ylabel('Position (mm)')
legend('Minimum Acceleration','Minimum Jerk', 'Minimum Snap','Minimum Crackle', 'Minimum Pop','Location','northwest')
subplot(1,2,2)
plot(t,xdot_0t,'c',t,xdot_1t,'r',t,xdot_2t,'b',t,xdot_3t,'k',t,xdot_4t,'g')
xlabel('Time(s)')
ylabel('Speed (mm/s)')

