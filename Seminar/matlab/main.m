close all, clear all

Rl = 11*25.4/1000;  
R = 12*25.4/1000; 

% Mass and Inertial Moments
Mc = 12.71;  
Mr = 2.546; 
M  = Mc + 2*Mr + 70;
Jr = 0.140; 

Fr = 30; 
F = 70;

x0 = 0; 
v0 = 0; 

[T,v] = ode45('odefun',[0 20],v0);

a = (F*(Rl/R) - Fr)/(M+Jr/R^2);

hold on
plot(T,v)
A = a*ones(size(T))
plot(T,A)