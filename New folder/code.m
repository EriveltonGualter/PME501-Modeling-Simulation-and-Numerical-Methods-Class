function code

    
    % F (Rl / R) = (Mt + JR/(R^2))* + FR
    s = tf('s');
    
    TSPAN = [0; 60]; 
    Y0  = [0; 10];  

    [TOUT,YOUT] = ode45('ax',TSPAN,Y0);
    
    % Plot results
    hold on 
    plot(TOUT, YOUT(:,1))
    plot(TOUT, YOUT(:,2))

end


