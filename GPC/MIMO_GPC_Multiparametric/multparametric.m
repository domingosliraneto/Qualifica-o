function [Pn,Fi,Gi,details] = multparametric(H,G,R,n,m,Restr,c,E,Nu,N2)
   
%     Matrices.G = [Restr;1 zeros(1,Nu-1);-1 zeros(1,Nu-1);G(1,1:end);-G(1,1:end)];
    Matrices.G = Restr;
%     Matrices.E = [zeros(length(c),N2+2);zeros(1,N2) -1 0;zeros(1,N2) 1 0;zeros(1,N2+1) -1;zeros(1,N2+1) 1];
    Matrices.E = E;
%     Matrices.W = [c;cnstrMatrix(3);-cnstrMatrix(4);cnstrMatrix(5);-cnstrMatrix(6)];
    Matrices.W = c;
    Matrices.H = H;
%     Matrices.F = [-2*G;zeros(1,Nu);zeros(1,Nu)];
    Matrices.F = [-2*R*G;zeros(n*N2+m*Nu,m*Nu)];
%     Matrices.F = [-2*R*G;zeros(1+Nu,Nu)];
%     Matrices.Y = [R*0 zeros(N2,2);zeros(2,N2+2)];
    Matrices.Y = zeros(2*n*N2+m*Nu,2*n*N2+m*Nu);
%     Matrices.Y = zeros(N2+Nu+1,N2+Nu+1);
    Matrices.Cf = zeros(1,length(Matrices.H));
    Matrices.Cx = zeros(1,length(Matrices.Y));
    Matrices.Cc = 0;

    Matrices.bndA=[];
    Matrices.bndb=[];
    
%     Matrices.alphabet{1}   = [-1 0 1];
%     Matrices.alphabet{2}   = [-2  2];
%     Matrices.vartype    = ['C'];

    tic
%     sol = mpt_mpmiqp(Matrices);
    [Pn,Fi,Gi,activeConstraints,Phard,details] = mpt_mpqp(Matrices);
%     sol = mpt_solve(Matrices);
    
%         Pn = sol.Pn;
%         Fi = sol.Fi;
%         Gi = sol.Gi;
%         details = sol;
    
    Pn = toPolyhedron(Pn);
    
    save('mptResult.mat','Pn','Fi','Gi');
    toc
    
%% Mixed-Integer    
%     u = sdpvar(Nu,1);
%     ep = sdpvar(1,1);
%     x = sdpvar(size(Matrices.E,2),1);
% %     LMI = [Matrices.G*U <= Matrices.W + Matrices.E*x, Matrices.bndA*x <= Matrices.bndb,  ismember(u,-0.5:1:0.5)];
%     LMI = [Matrices.G*u <= Matrices.W + Matrices.E*x,  ismember(u,-0.5:1:0.5)];
% %     LMI = [Matrices.G*U <= Matrices.W + Matrices.E*x - ep];
% 
%     objective = 1/2 *u'* Matrices.H* u + x' *Matrices.F *u + x'* Matrices.Y* x + Matrices.Cf *u + Matrices.Cx* x + Matrices.Cc;
% %     objective = ep;
%     option = sdpsettings('solver','pop');
%     [sol,diagnostics,aux,Valuefunction,Optimizer] = solvemp(LMI,objective,option,x,u);
%     Pn = toPolyhedron(sol{1, 1}.Pn);
%     Fi = sol{1, 1}.Fi;
%     Gi = sol{1, 1}.Gi;
%     save('mptResult.mat','Pn','Fi','Gi');
% %     clear PI_MPT.m
% %     plot(Optimizer);
end