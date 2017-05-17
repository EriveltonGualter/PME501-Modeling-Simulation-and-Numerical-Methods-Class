function [] = simulation(opt)
% simulation(ti, phi, phid, theta, thetad)
%
% INPUTS:
%   opt = [matrix] = structure of optimal control
%
% OUTPUTS:
%   --> Simulation of the wheelchair and plots of the states

    %% Animation of the wheelchair 
    extents = [-1 opt.theta(end)*0.3048+1 -1.5 1.5];
    time = 0;
    tic;
    
    dist_rodas = 0.6;
    r_wheel_size = 24*0.0254;
    f_wheel_size = 8*0.0254;
    
    % Fase 1
    %phio = [-atan2(r_wheel_size-f_wheel_size*2, dist_rodas); pi/2];
    % Fase 2
     phio = [atan2(dist_rodas, r_wheel_size-f_wheel_size*2); pi];
    
    while time < 20

        
        % Compute the position of the system at the current real world time
        posDraw = interp1(opt.ti',(opt.theta.*0.3048)',time')';
        phiDraw = interp1(opt.ti',(opt.phi)',time')';

        % Redraw the image
        drawWheelchair(time, posDraw, phio, phiDraw, extents);

        % Update current time
        time = toc;
    end


    
%     for i = 1: size(opt.ti, 1)
%         % Compute the position of the system at the current real world time
%         posDraw = opt.theta(i).*0.3048;
%         phiDraw = opt.phi(i);
% 
%         % Redraw the image
%         %drawWheelchair(time, posDraw, opt.phi(1), phiDraw, extents);
%         drawWheelchair(time, posDraw, phio, phiDraw, extents);
% 
%     end
    
    disp(sprintf('      Simulation Time    : %2.2f s \n      Travelled distance : %2.2f meters ',time, opt.theta(end)*0.3048))
    
    % t = %2.2f%',time));
end

