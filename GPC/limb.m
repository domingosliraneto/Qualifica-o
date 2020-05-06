limbModel_Analise
%% Planta (TF)
N = {NX(2:end)};
D = {DX};

%% Configura��o do n�mero de entradas e sa�das %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N�mero de sa�das
n = 1;
% N�mero de entradas
m = 1;

%% Atraso %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 0;

%% Forma��o das matrize polinomiais A e B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Bd, A] = createModel(N,D,d,n,m);
nbd = length(Bd)-1;
na = length(A)-1;
Asim = cell2mat(A(2:end));

% [BThd, ATh] = createModel({NTh(2:end)},{DTh},d,n,m);
% nbdTh = length(BThd)-1;
% naTh = length(ATh)-1;
% AThsim = cell2mat(ATh(2:end));

%%  Configura��o dos par�metros GPC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Sem restri��es
% Horizonte de controle
% Nu = 13;
% 
% Horizonte de Predi��o
% N1 = d+1;
% N2 = N1 + 55;
% 

% R  = 13*eye(n*N2,n*N2);
% Q  = 1e-2*eye(m*Nu,m*Nu);

% % Com restri��es

% % Best Multiparametric
% Nu = 2;
% N2 = 46;
% R  = 0.4*eye(n*N2,n*N2);
% Q  = 6e-4*eye(m*Nu,m*Nu);

% Nu = 2;
% N2 = 62;
% R  = 0.93*eye(n*N2,n*N2);
% Q  = 8e-5*eye(m*Nu,m*Nu);

% % Best
% Nu = 2;
% N2 = 102;
% R  = 1.04*eye(n*N2,n*N2);
% Q  = 5e-5*eye(m*Nu,m*Nu);

% % Complete Multiparametric
Nu = 2;
N2 = 35;
R  = 0.1*eye(n*N2,n*N2);
Q  = 6e-1*eye(m*Nu,m*Nu);

%% Configura��o das Restri��es para o Caso SISO    

DUmax = 0.005;
DUmin = -0.005;
Umax = 1.3;
Umin = 0;
Ymax = 1.35;
Ymin = -0.5;
cnstrMatrix = [DUmax DUmin Umax Umin Ymax Ymin];

%% Configura��o da simula��o %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
simTime = 300;
% T = 0.1;
vectorTime = 0:Ts:simTime;
samples = simTime/Ts+1;

% Vetor de refer�ncia
% setPoint1 = 0.1;
% Ref1 = setPoint1*(1:samples);
setPoint1 = 0.7;
Ref1 = setPoint1*ones(1,samples);
Ref = Ref1;

alpha = 0;

controle = 'Caso SISO';
txtXLabel = 'Tempo (seg)';
legendY = {'y'};
legendU = {'u'};
legendDU = {'\Delta u'};