function R = radiacao(w, Asup, E, Tpele, Tr)
    R = Asup*E*6.87e-8*((Tpele+273.3)^4-(Tr+273.3)^-4);
end

