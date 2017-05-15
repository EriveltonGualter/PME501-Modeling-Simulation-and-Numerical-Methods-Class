    function yd = ax(t,y, F)
        %   Inputs: t e y.
        %   Output: yd
        sys = sys_wheelchair

        Rl = sys.Rl
        R = sys.R
        M = sys.Mcr + 70;
        JR = sys.JR
        FR = sys.FR
        
        F = 20;
        
        s = y(1);   
        v = y(2);

        sd = v;
        vd = (F*(Rl/R) - FR) / (M+JR/R^2);

        yd = [sd; vd];

    end