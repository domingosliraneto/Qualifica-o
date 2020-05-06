function [du] = MultconstrainedMGPC(F,G_,Y,na,U,nbd,Ref,r,w,alpha,N2,Nu,n,k,Pn,Fi,Gi,E)
    freeY = mountVectorY(Y,na,k,1);
    %atualiza entradas passadas
    freeDU = mountVectorU(U,nbd,k,1);
    %------------------<Cálculo da Resposta Livre do GPC>------------------    
    f = G_*freeDU + F*freeY;

%     % Considera referências futuras
%     for i=k:min(simTime,k+N2-1)
%         for j = 1:n
%             r(j+2*(i-k+1)-2)=Ref(j,i); %atualiza o sinal degrau com Ny passo a frente
%         end
%     end

    % Considera apenas referências atuais
    for i=1:N2
        for j = 1:n
            r(j+n*(i-1))=Ref(j,k); %atualiza o sinal degrau com Ny passo a frente
        end
    end

    % Referência ponderada.
    % O termo alfa permite uma aproximação suave da saída para o setpoint w
    % 0 <= alfa < 1, em que quanto maior o alfa mais suave será a
    % aproximação

    for i = 1:N2
        for j = 1:n
            if (i == 1)
                w(j) = alpha*Y(j,k)+(1-alpha)*r(j);
            else
                w(j+n*(i-1)) = alpha*w(j+n*(i-2))+(1-alpha)*r(j+n*(i-1));
            end
        end
    end
    
    if (k > 1) % tratamento para o indice 0 no matlab
%         du = online_MPT([w-f;U(k-1)*ones(Nu,1);f],Pn,Fi,Gi);
        du = online_MPT([w-f;U(k-1)*ones(Nu,1);f(1)],Pn,Fi,Gi);
%         du = online_MPT([w-f;U(k-1);f(1)],Pn,Fi,Gi);
    else
%         du = online_MPT([w-f;zeros(Nu,1);f],Pn,Fi,Gi);
        du = online_MPT([w-f;zeros(Nu,1);f(1)],Pn,Fi,Gi);
%         du = online_MPT([w-f;0;f(1)],Pn,Fi,Gi);
    end
    
    
end 
