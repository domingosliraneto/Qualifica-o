function [du,xMp] = MultconstrainedMGPC(F,G_,Y,na,U,nbd,Ref,r,w,alpha,N2,N2r,Nu,Nur,n,m,k,Pn,Fi,Gi)
    freeY = mountVectorY(Y,na,k,1);
    %atualiza entradas passadas
    freeDU = mountVectorU(U,nbd,k,1);
    %------------------<C�lculo da Resposta Livre do GPC>------------------    
    f = G_*freeDU + F*freeY;

%     % Considera refer�ncias futuras
%     for i=k:min(simTime,k+N2-1)
%         for j = 1:n
%             r(j+2*(i-k+1)-2)=Ref(j,i); %atualiza o sinal degrau com Ny passo a frente
%         end
%     end

    % Considera apenas refer�ncias atuais
    for i=1:N2
        for j = 1:n
            r(j+n*(i-1))=Ref(j,k); %atualiza o sinal degrau com Ny passo a frente
        end
    end

    % Refer�ncia ponderada.
    % O termo alfa permite uma aproxima��o suave da sa�da para o setpoint w
    % 0 <= alfa < 1, em que quanto maior o alfa mais suave ser� a
    % aproxima��o

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
        xMp = [w-f;mountUk(U(1:m,k-1),Nur);f(1:n*N2r)];
        du = online_MPT(xMp,Pn,Fi,Gi,m);
%         du = online_MPT([w-f;U(k-1)*ones(Nu,1);f(1)],Pn,Fi,Gi);
%         du = online_MPT([w-f;U(k-1);f(1)],Pn,Fi,Gi);
    else
        xMp = [w-f;zeros(m*Nur,1);f(1:n*N2r)];
        du = online_MPT(xMp,Pn,Fi,Gi,m);
%         du = online_MPT([w-f;zeros(Nu,1);f(1)],Pn,Fi,Gi);
%         du = online_MPT([w-f;0;f(1)],Pn,Fi,Gi);
    end
    
    
end 

function vectorU = mountUk(U,Nu)
vectorU = [];
    for i = 1:Nu
        vectorU = [vectorU; U];
    end
end