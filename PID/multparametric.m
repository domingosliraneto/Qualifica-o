function [Pn,Fi,Gi,details] = multparametric(Gf, rhof, A, B, phi, U,delta)

    save('intLoop.mat','Gf','rhof','A','B','phi','U','delta')
    clear intProgLoop.m

    Matrices.bndA       = Gf;   %Limits on exploration space, i.e. bndA*x<=bndb
    Matrices.bndb       = rhof;
    Matrices.H          = [0 1];  
%     Matrices.alphabet{1}   = [-1 0 1];
%     Matrices.alphabet{1}   = [-phi(2)  phi(1)];
    Matrices.W          = [-delta ;phi];
    Matrices.E          = [(-Gf*A) ;zeros(2,size(Gf*A,2))];
    Matrices.G          = [[Gf*B; U] [-rhof; zeros(length(Gf*B)+length(U)-length(rhof),1)]]; 
%     Matrices.vartype    = ['C' 'C'];
    Matrices.F          = zeros(1,length(A));
    tic
%     sol = mpt_mpmilp(Matrices);
    [Pn,Fi,Gi,activeConstraints,Phard,details] = mpt_mplp_26(Matrices);
    toc
    Pn = toPolyhedron(Pn);

%     u = sdpvar(1,1);
%     ep = sdpvar(1,1);
%     x = sdpvar(3,1);
%     LMI = [Matrices.G*[u;ep] <= Matrices.W + Matrices.E*x, Matrices.bndA*x <= Matrices.bndb];
%     %LMI = [Matrices.G*[u;ep] <= Matrices.W + Matrices.E*x, Matrices.bndA*x <= Matrices.bndb,  ismember(u,-9.9999:2*9.9999:9.9999)];
%     %LMI = [Matrices.G*[u;ep] <= Matrices.W + Matrices.E*x, Matrices.bndA*x <= Matrices.bndb,  ismember(u,-0.9999:0.9999:0.9999)];
% 
% 
%     objective = Matrices.H*[u;ep] + Matrices.F*x;
% %     objective = ep*ep;
%     [Isol,diagnostics,aux,Valuefunction,Optimizer] = solvemp(LMI,objective,[],x,u);
% %     IPn = toPolyhedron(Isol{1, 1}.Pn);
%     IFi = Isol{1, 1}.Fi;
%     IGi = Isol{1, 1}.Gi;
    
    

end