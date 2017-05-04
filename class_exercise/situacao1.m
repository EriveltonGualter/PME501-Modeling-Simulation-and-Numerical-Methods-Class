% Dados para atividade leve, situação de conforto, em regime permanent
Tpele = 33.4;
Ti = 36.8;
Tar = 30;

Asup = 1.8;
hi = 5;
w = 0.1;
um = 50;

propriedades.C = convencao(Asup, hi, Tpele, Tar);
propriedades.E = evaporacao(Asup, w, hi, Tpele, Tar, um);
propriedades.R = radiacao(w, Asup, propriedades.E, Tpele, Tar);

propriedades