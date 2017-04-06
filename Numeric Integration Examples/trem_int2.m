% author: Erivelton Gualter
% created: 05/04/2017

% Integração Numérica

close all

ti = 0; % instante inicial
tf = 3; % instante final

y0 = [0; 10]; % condições inicias

n = 50;            % número de nós
h = (tf - ti)/n;    % passo de integração

Y = zeros(n+1,length(y0)); % inicialização
T = zeros(1, n+1); % inicialização

i = 1;
Y(1,:) = y0';
T(1) = ti;
y = y0;
t = ti;
while t < tf
    % método trapezoidal
    dydt = tremode(t,y);
    y_est = y + dydt*h; 
    y = y + (dydt + tremode(t+h,y_est))*h/2;
    
    t = t + h;
    i = i + 1;
    T(i) = t;
    Y(i,:) = y';
end

% Plots
hold on
% figure(1);
subplot(131);
plot(T,Y(:,1), 'LineWidth',2); % posição 
xlabel('tempo [s]');
ylabel('deslocamento x [m]')
title('Resposta Sistema Trem-Mola-Amortecedor');
grid;

% figure(2);
subplot(132);
plot(T,Y(:,2), 'LineWidth',2); % velocidade 
grid on
xlabel('tempo [s]');
ylabel('velocidade [m/s]');
title('Resposta Sistema Trem-Mola-Amortecedor');

% cálculo da aceleração
Yd = zeros(size(Y));
for j = 1:length(T)
    Yd(j,:) = tremode(T(j), Y(j,:)')';
end

% figure(3);
subplot(133);
plot(T,Yd(:,2), 'LineWidth',2); % aceleração 
grid on;
xlabel('tempo [s]');
ylabel('aceleração [m/s^2]');
title('Resposta Sistema Trem-Mola-Amortecedor');




