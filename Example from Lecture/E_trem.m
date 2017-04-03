m = 2000; % [kg]
k = 40000; % [N/m]
c = 20000; % 20000 [Ns/m]

k = 2500;
c = 5000;

vo = 10; % [m/s]
% xo = 0; % [m] solução adiante válida somente para xo = 0

% Fator de amortecimento
zeta = c/(2*sqrt(k*m))

% Freq. natural
wn = sqrt(k/m)

% Constantes da solução geral para sistema super-amortecido
a = vo/(2*wn*sqrt(zeta^2 - 1));
b = -a;

% vetor tempo
t = 0:0.001:3;

% Solução
x = exp(-zeta*wn*t).*(a*exp(wn*sqrt(zeta^2-1).*t) + b*exp(-wn*sqrt(zeta^2-1).*t));

% Encontrar xmax
xmax = max(x)

txmax = t(x == xmax)

% Tempo para deslocamento máximo calculado analiticamente
txmax_eq = - log((-zeta + sqrt(zeta^2 - 1))/(-zeta - sqrt(zeta^2 - 1)))/(2*wn*sqrt(zeta^2 - 1)) 

% Deslocamento máximo para txmax_eq
xmax_eq = exp(-zeta*wn*txmax_eq).*(a*exp(wn*sqrt(zeta^2-1).*txmax_eq) + b*exp(-wn*sqrt(zeta^2-1).*txmax_eq))

% Posição
figure
plot(t,x)
grid on
xlabel('tempo [s]')
ylabel('deslocamento x [m]')
title('Resposta Sistema Trem-Mola-Amortecedor')


% Velocidade
v = (x(2:end) - x(1:end-1))./(t(2:end)-t(1:end-1));
figure
plot(t(1:end-1),v);
grid on
xlabel('tempo [s]')
ylabel('velocidade [m/s]')
title('Resposta Sistema Trem-Mola-Amortecedor')

% Aceleracao
a = (v(2:end) - v(1:end-1))./(t(3:end)-t(2:end-1));
figure
plot(t(1:end-2),a)
grid on
xlabel('tempo [s]')
ylabel('aceleração [m/s^2]')
title('Resposta Sistema Trem-Mola-Amortecedor')

% % Força por deslocamento
% a = (v(2:end) - v(1:end-1))./(t(3:end)-t(2:end-1));
% figure
% plot(x,)
% grid on
% xlabel('deslocamento [s]')
% ylabel('força [N]')
% title('Curva força-deslocamento')

