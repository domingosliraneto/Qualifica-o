function u = online_MPT(X,Pn,Fi,Gi)
%     persistent Fi;
%     persistent Gi;
    %persistent Bi;    persistent Ci;    persistent A;   persistent B;    persistent E;    persistent d;
%     persistent Pn;
    persistent utemp;
    
    if(isempty(Pn))
       load(nomeArquivo) 
       utemp = 0;
    end

    [isin, inwhich] = isInside(Pn,X);
    if (isin)
        utemp = Fi{1,inwhich(1)}(1,:)*X + Gi{1,inwhich(1)}(1,:);
%         disp(['Região ' num2str(inwhich)])
    else 
        disp('O sistema nao entrou em nenhuma regiao');
    end
    u = utemp;
end