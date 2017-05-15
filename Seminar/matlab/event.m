function pulse = event(t, v)
    
    if t > 2
        pulse = 0;
    else
        pulse = 1;
    end
end