close all, clear all

w = sys_wheelchair();

y0 = [pi/2, 0, 0, 0];

% options = odeset('Events',@event);

options = odeset('AbsTol',1E-8,'RelTol',1E-8);
[T, Yout] = ode45('odefun2',[0 10],y0, options);

data.ti = T;
data.phi = Yout(:,1);
data.phid = Yout(:,2);
data.theta = Yout(:,3);
data.thetad = Yout(:,4);

%%
simulation(data);

%%
pt(data);




