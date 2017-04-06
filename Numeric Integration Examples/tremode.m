function yd = tremode(t,y)
%ODE do problema do trem
%   Detailed explanation goes here

    % Parametros
    m = 2000; % [kg]
    k = 40000; % [N/m]
    c = 20000; % 20000 [Ns/m]
    
    a = 1;
    b = 0;

    yd = [y(2); -(a+b*y(1)^2)*c*y(2)/m - k*y(1)/m];
end

