clc;
clear;

xi = 0;
xf = 71.7;
yi = 120;
yf = 98.4;

x = xi:1:xf;

d=length(x)-1;
yd = (yf-yi)/d;
y = yi:yd:yf;

plot(xi,yi,'bx','MarkerSize', 10,'LineWidth', 2)
hold on
plot(x,y,'r.')
hold on
plot(xf,yf,'kx','MarkerSize', 10,'LineWidth', 2);
ylabel('Y-position (mm)')
xlabel('X-position (mm)')
legend('Initial Position', 'Intermediate Positions','Final Target Position')
xlim([-10 80])
ylim([95 125])
