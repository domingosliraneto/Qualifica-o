Y = Data1.signals(1).values;
U = Data1.signals(2).values;
Fi = [-Y(1:end-2) -Y(2:end-1) U(2:end-1)];
y = Y(3:end);
theta = (Fi'*Fi)^-1*Fi'*y
SOTF = d2c(tf([theta(3)],[1 theta(2) theta(1)],Ts),'matched')
[ysim] = lsim(SOTF,U,0:Ts:Ts*(length(U)-1));
plot(Y)
hold on
plot(ysim)
%%

Y = Data2.signals(1).values(8000:2*8000);
U = Data2.signals(2).values(8000:2*8000);
Fi = [-Y(1:end-2) -Y(2:end-1) U(2:end-1)];
y = Y(3:end);
theta = (Fi'*Fi)^-1*Fi'*y
SOTF = d2c(tf([theta(3)],[1 theta(2) theta(1)],Ts),'matched')
[ysim] = lsim(SOTF,U,0:Ts:Ts*(length(U)-1));
plot(Y)
hold on
plot(ysim)
save('FT.mat','SOTF')