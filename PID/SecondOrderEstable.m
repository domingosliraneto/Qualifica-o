load('FT.mat','SOTF')
W2 = SOTF.Denominator{1, 1}(1,end); EW2 = SOTF.Denominator{1, 1}(1,end-1);
K = SOTF.Numerator{1, 1}(1,end);
s = tf('s');
% Gs = b/(s+a1);
A = [0 1 0;0 0 1;0 -W2 -EW2]; B = [0;0;-K]; C = [0 0 1]; D = 0;

% a1 = 1; b = 1; %modelo 2
% k = b/a1; tau = 1/a1;
% s = tf('s');
% Gs = b/(s+a1);
% A = [0 1;0 -a1]; B = [0;-b]; C = [0 1]; D = 0;% X = [Ei(t) E(t)];
Ts = 0.11;
SS = ss(A,B,C,D);
SSd = c2d(SS,0.11);
Ad = SSd.a; Bd = SSd.b;

G = [eye(length(A));-eye(length(A))];
rho = [0.1; 0.1; 4.8; 0.1; 0.1; 4.8];
D = [1;-1];
w = [1;1];
phi = [1.3; 0];U = [1;-1];
lambda = 0.95; 
E = zeros(length(A),1);

Gf = G;
rhof = rho;
% [Gf, rhof] = supremalSet(Ad,Bd,G,rho,D,w,U,phi,lambda,E);

[delta] = maxdistvect(E,Gf,D,w); 

%%
[Pn,Fi,Gi,details] = multparametric(Gf, rhof, Ad, Bd, phi, U,delta);
save('C:\Users\hhhhh\Dropbox\ISD\PID.mat','Pn','Fi','Gi')
clear C:\Users\hhhhh\Dropbox\ISD\PID_MPT.m
% save('IPID.mat','IPn','IFi','IGi')
% clear IPID_MPT.m

% sim('SecondOrderEstable/SOS1.slx')
%%
createfigure3(U1(:,1),U1(:,2),Y1(:,1),Y1(:,2))
%%
plot(U(:,1),U(:,2)); hold on; grid on;
title('Integer Control Action')
xlabel('Time (s)')
ylabel('Control Action Magnitude')

figure
plot(Y(:,1),Y(:,2)); hold on;  grid on;
title('System Output')
xlabel('Time (s)')
ylabel('System Output Magnitude')

figure
plot(U1(:,1),U1(:,2)); hold on; grid on;
title('Integer Control Action')
xlabel('Time (s)')
ylabel('Control Action Magnitude')

figure
plot(Y1(:,1),Y1(:,2)); hold on;  grid on;
title('System Output')
xlabel('Time (s)')
ylabel('System Output Magnitude')