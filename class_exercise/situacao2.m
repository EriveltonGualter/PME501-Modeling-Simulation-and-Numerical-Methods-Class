% Dados para atividade leve, situação de conforto, em regime transitório
Tpele = 33.4;
Ti = 36.8;
Tar = 15;

Asup = 1.8;
hi = 5;
w = 0.1;
um = 50;

m = 70;
c = 3220;


propriedades.C = convencao(Asup, hi, Tpele, Tar);
propriedades.E = evaporacao(Asup, w, hi, Tpele, Tar, um);
propriedades.R = radiacao(Asup, propriedades.E, Tpele, Tar);

propriedades

