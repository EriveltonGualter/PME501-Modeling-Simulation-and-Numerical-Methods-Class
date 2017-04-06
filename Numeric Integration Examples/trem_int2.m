% author: Erivelton Gualter
% created: 05/04/2017

% Integra��o Num�rica

close all

ti = 0; % instante inicial
tf = 3; % instante final

y0 = [0; 10]; % condi��es inicias

n = 50;            % n�mero de n�s
h = (tf - ti)/n;    % passo de integra��o

Y = zeros(n+1,length(y0)); % inicializa��o
T = zeros(1, n+1); % inicializa��o

i = 1;
Y(1,:) = y0';
T(1) = ti;
y = y0;
t = ti;
while t < tf
    % m�todo trapezoidal
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
plot(T,Y(:,1), 'LineWidth',2); % posi��o 
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

% c�lculo da acelera��o
Yd = zeros(size(Y));
for j = 1:length(T)
    Yd(j,:) = tremode(T(j), Y(j,:)')';
end

% figure(3);
subplot(133);
plot(T,Yd(:,2), 'LineWidth',2); % acelera��o 
grid on;
xlabel('tempo [s]');
ylabel('acelera��o [m/s^2]');
title('Resposta Sistema Trem-Mola-Amortecedor');




