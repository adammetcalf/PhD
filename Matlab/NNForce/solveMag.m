clc;
clear;

syms B Br z Hm Dm

equation = B == ((Br/2)*(((z+Hm)/((((z+Hm)^2)+(Dm/2)^2))^(1/2))-(z/(((z+Hm)^2)+(Dm/2)^2)^(1/2))));

z = solve(equation,z);
z = simplify(z)