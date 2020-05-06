function u = online_MPT(X,Pn,Fi,Gi,m)
%     persistent Fi;
%     persistent Gi;
    %persistent Bi;    persistent Ci;    persistent A;   persistent B;    persistent E;    persistent d;
%     persistent Pn;
    persistent utemp;
    
    [isin, inwhich] = isInside(Pn,X);
    if (isin)
        utemp = Fi{1,inwhich(1)}(1:m,:)*X + Gi{1,inwhich(1)}(1:m,:);
%         disp(['Região ' num2str(inwhich)])
    else 
        disp('O sistema nao entrou em nenhuma regiao');
    end
    u = utemp;
end