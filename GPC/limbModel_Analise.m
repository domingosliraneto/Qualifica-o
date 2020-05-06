load('FT.mat','SOTF')
Ts = 0.01;
Xd = c2d(SOTF,Ts);
[NX,DX] = tfdata(Xd,'v');

