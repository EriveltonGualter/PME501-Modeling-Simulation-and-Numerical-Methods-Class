function E = evaporacao( Asup, w, hi, Tpele, Tar, um)
    
    E = w*Asup*(hi*16.5)*(pressao(Tpele)-pressao(Tar)*um/100);
    
    function P = pressao(T)
        P = 0.61078*exp( (17.27*T)/(T+273.3) );
    end
end

