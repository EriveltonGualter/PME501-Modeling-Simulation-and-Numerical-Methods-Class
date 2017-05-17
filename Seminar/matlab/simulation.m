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
    phio = [-atan2(r_wheel_size-f_wheel_size*2, dist_rodas); pi/2];
    % Fase 2
%      phio = [atan2(dist_rodas, r_wheel_size-f_wheel_size*2); pi];
    
    first_frame = true;
    while time < 10
        % Compute the position of the system at the current real world time
        posDraw = interp1(opt.ti',(opt.theta.*0.3048)',time')';
        phiDraw = interp1(opt.ti',(opt.phi)',time')';

        % Redraw the image
        drawWheelchair(time, posDraw, phio, phiDraw, extents);

        % Update current time
        time = toc;
        
        % gif utilities
        set(gcf,'color','w'); % set figure background to white
        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        outfile = 'DijkstraGrid.gif';

        % On the first loop, create the file. In subsequent loops, append.
        if first_frame
            imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
            first_frame = false;
        else
            imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
        end
        
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

