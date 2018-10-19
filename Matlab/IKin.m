function [T0_des, T1_des] = IKin (L0,L1,X2des)

%this fucntion perfroms the inverse kinematics which converts the desired
%end effector positions into the desired angles.

L = sqrt((X2des(1))^2+(X2des(2))^2);

Alpha = acos((L^2 + L0^2 + L1^2)/(2*L*L0));

Beta = atan(X2des(2)/X2des(1));

T0_des = Beta-Alpha;

Zeta = acos((L^2 + L0^2 - L^2)/(2*L0*L1));

T1_des = degtorad(180) - Zeta;