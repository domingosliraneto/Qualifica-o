Crane_Analise

%% Configura��o do n�mero de entradas e sa�das %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N�mero de sa�das
n = 2;
% N�mero de entradas
m = 1;

%% Atraso %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = zeros(n,m);

%% Forma��o das matrize polinomiais A e B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Bd, A] = createModel(N,D,d,n,m);
nbd = length(Bd)-1;
na = length(A)-1;
Asim = cell2mat(A(2:end));

%%  Configura��o dos par�metros GPC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Complete Multiparametric
Nu = 2;
N2 = 40;
R  = eye(n*N2,n*N2);
R(1:2:n*N2,:) = 0.4*R(1:2:n*N2,:);
R(2:2:n*N2,:) = 40*R(2:2:n*N2,:);
Q  = 5e-4*eye(m*Nu,m*Nu);

% % Complete Multiparametric
% Nu = 2;
% N2 = 40;
% R  = eye(n*N2,n*N2);
% R(1:2:n*N2,:) = 1*R(1:2:n*N2,:);
% R(2:2:n*N2,:) = 500*R(2:2:n*N2,:);
% Q  = 6e-3*eye(m*Nu,m*Nu);

%% Configura��o das Restri��es para o Caso SISO    

DUmax = 5;
DUmin = -5;
Umax = 5;
Umin = -5;
Ymax = [0.8;0.002];
Ymin = [0;-0.002];
cnstrMatrix = {DUmax DUmin Umax Umin Ymax Ymin};

%% Configura��o da simula��o %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
simTime = 50;
% T = 0.1;
vectorTime = 0:T:simTime;
samples = simTime/T+1;

% Vetor de refer�ncia
setPoint1 = 0.75;
setPoint2 = 0;
Ref1 = setPoint1*ones(1,samples);
Ref2 = setPoint2*ones(1,samples);
Ref = [Ref1;Ref2];

alpha = 0;

controle = 'Crane';
txtXLabel = 'Tempo (seg)';
legendY = {'y'};
legendU = {'u'};
legendDU = {'\Delta u'};