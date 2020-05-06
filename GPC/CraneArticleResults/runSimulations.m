%% Inicialização do GPC multivariável %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Crane

[F,G_,G,K] = initMIMOgpc(A,Bd,N2,Nu,R,Q);

Bd = cell2mat(Bd);
BThd = cell2mat(BThd);

run('CraneArticleResults\unconstrainedGPC_Crane.m')
run('CraneArticleResults\constrainedGPC_Crane.m')
run('CraneArticleResults\multGPC_Crane.m')