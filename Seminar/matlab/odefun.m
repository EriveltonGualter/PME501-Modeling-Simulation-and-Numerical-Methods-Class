function dv = odefun( t, v )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    Rl = 11*25.4/1000;  
    R = 12*25.4/1000; 

    % Mass and Inertial Moments
    Mc = 12.71;  
    Mr = 2.546; 
    M  = Mc + 2*Mr + 70;
    Jr = 0.140; 

    Fr = 30; 
    F = 70;
    
%     if v > 0
%         Fr = -abs(Fr);
%     else
%         Fr = +abs(Fr);
%     end
    
%     if t>10
%         F = 0;
%     end
    
    dv = (F*(Rl/R) - Fr*0.3)/(M+Jr/R^2);
v
end

