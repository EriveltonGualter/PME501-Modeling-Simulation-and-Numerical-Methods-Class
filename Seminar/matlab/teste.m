close all, clear all

w = sys_wheelchair();

y0 = [0, 0, 0, 0];

% options = odeset('Events',@event);

[T, Yout] = ode45('odefun2',[0 30],y0);