function aceleracao
% Dinâmica de Sistemas Veiculares, terceiro trimestre de 2013.
% Prof. Marko Ackermann
% Gillispie, 1992 - exemplo 1 na pág. 32 (http://esfahanian.iut.ac.ir/sites/esfahanian.iut.ac.ir/files//files_course/fundamentals_of_vehicle_dynamics_-_thomas_d_gillespie.pdf)
% 
% Pede-se:
% a) Entender o código
% b) Incorporar perdas devidas ao arrasto (pág. 97, Gillespie, utilizar Eq. 4-2 e adotar Cd e A razoáveis)
% c) Incorporar perdas devidas ao atrito de rolamento (pág.110-..., Gillespie, utilizar valores na tabela da pág. 117 ou Eq. 4-15)
% d) Determinar influência destas perdas sobre o desempenho em aceleração do
% veículo (em particular, sobre tempo para aceleração de 0 a 100 km/h). Plotar curvas de velocidade em função do tempo para cada caso.
% e) Determinar a influência da força trativa máxima que pode ser
% transmitida pelas rodas trativas sem derrapagem.
% f) Encontrar velocidade máxima atingida pelo automóvel considerando as perdas adicionadas acima.

% Massa do veiculo
M_a = 2500; % [lb]
M = 0.45359237*M_a % [kg] -- conversão para SI

% Momento de inercia do motor
Ie_a = 0.8; % momento de inercia do motor [in.lb.s2] onde lb é unidade de peso (libra-forca), equivalente a [lb.in2] com lb unidade de peso
Ie = 0.11298483*Ie_a % [kg*m2] -- conversão para SI

% Momento de inercia da transmissao (visto do motor)
% diferente para cada marcha
It_a = [1.3 0.9 0.7 0.5 0.3]; % [in.lb.s2]
It = 0.11298483*It_a; % [kg*m2] -- conversão para SI

% Momento de inercia do diferencial (visto do eixo cardan)
Id_a =1.2; % [in.lb.s2]
Id = 0.11298483*Id_a; % [kg*m2] -- conversão para SI

% Momento de inercia das rodas (e semi-eixos)
Iw_a = 11; % [in.lb.s2]
Iw =  0.11298483*Iw_a % [kg*m2] -- conversão para SI

% Lista de pontos para a curva rpm vs. torque
% RPM
RPM = [800 1200 1600 2000 2400 2800 3200 3600 4000 4400 4800 5200]; % [rpm]

% Extensão do vetor para incluir 0 rpm e 6500 rpm
RPM_n = 6500;
RPMe = [0 RPM RPM_n]; % -- extensão para simulação

% Torque
T_a = [120 132 145 160 175 181 190 198 200 201 198 180]; % [ft*lb]
T = 1.355818*T_a; % [N*m] -- conversão para SI

% Vetor de torques incluindo torques a 0 rpm e 6500 rpm
% Torque calculado por simples extrapolação linear
T0 = T(1) - RPM(1)*(T(2)-T(1))/(RPM(2)-RPM(1));
Tn = T(end) + (RPM_n-RPM(end))*(T(end)-T(end-1))/(RPM(end)-RPM(end-1));
Te = [T0 T Tn]; % -- Vetor de torques para cada rpm

% Redução da transmissão (para cada uma das cinco marchas)
Nt = [4.28 2.79 1.83 1.36 1.00];

% Eficiência da transmissão (diferente para cada uma das cinco marchas) 
ni_t = [0.966 0.967 0.972 0.973 0.970];
% ni_t = ones(1,5);

% Redução no diferencial
Nf = 2.92;

% Eficiência do diferencial
ni_f = 0.99;
% ni_f = 1;

% Raio das rodas (dianteira e traseira)
r_a = 12.59; % [in]
r = 0.0254*r_a; % [m] -- conversão para SI

% Velocidade longitudinal do automovel [m/s]
v1 = 2*pi*(1/60)*RPMe*(1/Nt(1))*(1/Nf)*r; % marcha 1
v2 = 2*pi*(1/60)*RPMe*(1/Nt(2))*(1/Nf)*r; % marcha 2
v3 = 2*pi*(1/60)*RPMe*(1/Nt(3))*(1/Nf)*r; % marcha 3
v4 = 2*pi*(1/60)*RPMe*(1/Nt(4))*(1/Nf)*r; % marcha 4
v5 = 2*pi*(1/60)*RPMe*(1/Nt(5))*(1/Nf)*r; % marcha 5

% Forca trativa (sem considerar reducao devido a inercia do powertrain)
Fx1 = Te*Nt(1)*Nf*ni_t(1)*ni_f/r;
Fx2 = Te*Nt(2)*Nf*ni_t(2)*ni_f/r;
Fx3 = Te*Nt(3)*Nf*ni_t(3)*ni_f/r;
Fx4 = Te*Nt(4)*Nf*ni_t(4)*ni_f/r;
Fx5 = Te*Nt(5)*Nf*ni_t(5)*ni_f/r;

% Potencia no motor
P = Te.*RPMe*2*pi*(1/60);

% Potencia maxima
v = 10:1:60;
P_max = P(end-2);
F_max_v = P_max./v; % forca trativa sem considerar reducao divido a inercia e eficiencia do powertrain


% Calculo do tempo de aceleraçao de 0 a 100 km/h considerando transmissao
% ideal, carro operando na potencia maxima, desconsiderando massa efetiva do powertrain
% e sem considerar qualquer tipo de dissipaçao de energia
Mr = 0*M; % massa equivalente media do powertrain
vmax = 100/3.6; % [m/s] - 100 km/h
ni_pt = 1; % eficiencia do powertrain 100%
Tf = ((M+Mr)*vmax^2)/(2*P_max*ni_pt)

% Curva tempo vs velocidade
v_ideal = 0:0.1:65;
t_ideal = ((M+Mr)*v_ideal.^2)/(2*P_max*ni_pt);

% Figura 1 - torque motor vs. rmp
figure
hold on
plot(RPMe,Te)
plot(RPMe,P/1000,'k'); % [kw]
legend('torque do motor','potencia do motor');
ylabel('Torque [N.m] ou Potencia [kw]')
xlabel('Rotações por minuto [rpm]')
hold off


% Figura 2 - força trativa (sem considerar perda devido ao momento de inercia do
% powetrain, ja incluida na massa) vs. velocidade longitudinal
figure
hold on
plot(v1*3.6,Fx1,'r')
plot(v2*3.6,Fx2,'m')
plot(v3*3.6,Fx3,'b')
plot(v4*3.6,Fx4,'c')
plot(v5*3.6,Fx5,'g')

% Curva potencia maxima
plot(v*3.6,F_max_v,'k')
legend('marcha 1','marcha 2','marcha 3','marcha 4','marcha 5','Pmax constante')
xlabel('Velocidade [km/h]')
ylabel('Força Trativa [N]')
hold off

% Calcular velocidade do automovel em funçao do tempo e tempo de aceleração de 0 a 100 km/h sem considerar perdas de
% rolamento ou arrasto aerodinamico
options = odeset('Events',@event);
options = odeset('RelTol',1e-8,'AbsTol',1e-8,'Events',@event);

% Primeira marcha
marcha = 1;
v10 = 0; % velocidade inicial
[t1 v1] = ode45(@(t,v) ax(t,v,marcha),0:0.01:200,v10, options);

% Segunda marcha
marcha = 2;
[t2 v2] = ode45(@(t,v) ax(t,v,marcha),t1(end):0.01:200,v1(end), options);

% Terceira marcha
marcha = 3;
[t3 v3] = ode45(@(t,v) ax(t,v,marcha),t2(end):0.01:200,v2(end), options);

% Quarta marcha
marcha = 4;
[t4 v4] = ode45(@(t,v) ax(t,v,marcha),t3(end):0.01:200,v3(end), options);

% Quinta marcha
marcha = 5;
[t5 v5] = ode45(@(t,v) ax(t,v,marcha),t4(end):0.01:200,v4(end), options);

% Figura 3 - Velocidade vs. tempo
figure
hold on
plot(t1,v1*3.6,'r')
plot(t2,v2*3.6,'m')
plot(t3,v3*3.6,'b')
plot(t4,v4*3.6,'c')
plot(t5,v5*3.6,'g')
plot(t_ideal,v_ideal*3.6,'k')
xlabel('Tempo [s]')
ylabel('Velocidade [km/h]')
legend('marcha 1','marcha 2','marcha 3','marcha 4','marcha 5','curva ideal')
hold off

% Encontrar tempo para atingir velocidade 100 km/h
t100 = interp1([v1(2:end)' v2(2:end)' v3(2:end)' v4(2:end)' v5(2:end)']*3.6,[t1(2:end)' t2(2:end)' t3(2:end)' t4(2:end)' t5(2:end)'],100)

    function dv = ax(t,v,marcha)
        % Calcular aceleracao atual
        
        % Massa efetiva no powertrain
        Mr = ((Ie+It(marcha))*(Nt(marcha)*Nf)^2 + Id*Nf^2 + 2*Iw)/(r^2);

        % Massa efetiva total (carro + powertrain)
        Meff = M + Mr;

        % RPM atual do motor
        rpm_atual = v*60*(1/(2*pi))*Nt(marcha)*Nf/r; % rpm atual

        % Torque atual do motor
        Te_atual = interp1(RPMe,Te,rpm_atual,'linear','extrap');

        % Força trativa sem considerar inercia do powertrain
        Fx = Te_atual*Nt(marcha)*Nf*ni_t(marcha)*ni_f/r;
        
        % Forças resistivas
        rho = 1.2754;
        Cd = 0.33;
        A = 1.83;
        Da = 0.5*rho*Cd*A*v^2;
        fr = 0.1;
        Rx = M*9.81*fr;
        Fr =  Da + Rx;
        
        % Aceleracao
        dv = (Fx-Fr)/Meff;
    end 

    function [value,isterminal,direction] = event(t,v)
        % Funçao evento que identifica troca de marcha e interrompe o
        % integrador
        
        if marcha <= 4
            % RPM atual do motor
            rpm_atual = v*60*(1/(2*pi))*Nt(marcha)*Nf/r; % rpm atual

            % Torque atual do motor
            Te_atual = interp1(RPMe,Te,rpm_atual,'linear','extrap');

            % Força trativa sem considerar inercia do powertrain
            Fx = Te_atual*Nt(marcha)*Nf*ni_t(marcha)*ni_f/r;


            % rpm do motor em marcha subsequente para mesma velocidade de
            % translação do carro
            rpm_m =  v*60*(1/(2*pi))*Nt(marcha+1)*Nf/r; % rpm marcha subsequente

            % Torque do motor na marcha subsequente
            Te_m = interp1(RPMe,Te,rpm_m);

            % Força trativa na marcha subsequente (sem considerar inercia
            % do powertrain)
            Fx_m = Te_m*Nt(marcha+1)*Nf*ni_t(marcha+1)*ni_f/r;
            
            % Diferença entra as forças trativas na marcha atual e na
            % marcha subsequente (quando zero ha troca de marcha)
            value = Fx - Fx_m;
            
        else
            % RPM atual do motor
            rpm_atual = v*60*(1/(2*pi))*Nt(marcha)*Nf/r; % rpm atual

            % Torque atual do motor
            Te_atual = interp1(RPMe,Te,rpm_atual,'linear','extrap');
            
            % Força trativa sem considerar inercia do powertrain
            Fx = Te_atual*Nt(marcha)*Nf*ni_t(marcha)*ni_f/r;
            
            % Na quinta marcha o critério de parada é a força trativa
            % atingir 0
            value = Fx;

        end

        isterminal = 1; % terminar integracao quando value(1) = 0
        direction = 0;
        
    end
end