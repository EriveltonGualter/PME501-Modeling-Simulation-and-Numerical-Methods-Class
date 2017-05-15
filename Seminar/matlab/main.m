close all, clear all

w = sys_wheelchair();

x0 = 0; 
v0 = 0; 
y0 = [x0, v0];

% options = odeset('Events',@event);

[T, Yout] = ode45('odefun',[0 30],y0);

data.ti = T;
data.phi = zeros(size(T));
data.phid = zeros(size(T));
data.theta = Yout(:,1)/0.3048;
data.thetad = Yout(:,2);

% a = (w.F*(w.Rl/w.R) - w.Fr)/(w.M+w.Jr/w.R^2);

simulation(data);

figure()
hold on


% sim('phase1');
% load('experiment_Mass_wheelchair.mat')
% plot(t,y_ms, 'LineWidth',2);
% load('experiment_Mass_90.mat')
% plot(t,y_ms, 'LineWidth',2);

addpath('data');
load('experiment_Mass_70.mat')
plot(t,y_ms, 'LineWidth',2);

plot(T, Yout(:,2), 'LineWidth',2);
legend('Experiment', 'Simulation');
xlabel('tempo (s)');
ylabel('velocidade (m/s)');

grid


