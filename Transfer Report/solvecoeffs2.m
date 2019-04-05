clc;
clear;

syms c11 c10 c9 c8 c7 c6 c5 c4 c3 c2 c1 c0 t;

%Acceleration
x_t0 = c3*t^3+c2*t^2+c1*t+c0
xd_t0 = diff(x_t0)


%Jerk
x_t1 = c5*t^5+c4*t^4+c3*t^3+c2*t^2+c1*t+c0;
xd_t1 = diff(x_t1);
xdd_t1 =diff(xd_t1);

%snap
x_t2 = c7*t^7+c6*t^6+c5*t^5+c4*t^4+c3*t^3+c2*t^2+c1*t+c0;
xd_t2 = diff(x_t2);
xdd_t2 =diff(xd_t2);
xddd_t2 = diff(xdd_t2);


%crackle
x_t3 = c9*t^9+c8*t^8+c7*t^7+c6*t^6+c5*t^5+c4*t^4+c3*t^3+c2*t^2+c1*t+c0;
xd_t3 = diff(x_t3);
xdd_t3 =diff(xd_t3);
xddd_t3 = diff(xdd_t3);
xdddd_t3 = diff(xddd_t3);

%pop
x_t4 = c11*t^11+c10*t^10+c9*t^9+c8*t^8+c7*t^7+c6*t^6+c5*t^5+c4*t^4+c3*t^3+c2*t^2+c1*t+c0;
xd_t4 = diff(x_t4);
xdd_t4 =diff(xd_t4);
xddd_t4 = diff(xdd_t4);
xdddd_t4 = diff(xddd_t4);
xddddd_t4 = diff(xdddd_t4);
