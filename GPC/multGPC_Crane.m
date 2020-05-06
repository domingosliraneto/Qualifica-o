%% Simulação %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    H = 2*(G'*R*G+Q);

    % Make sure it is symmetric
    if norm(H-H',inf) > eps || ~issymmetric(H) 
        H = (H+H')*0.5;
    end

    Restr = [];
    c = [];
    E = [];
    RDu = [eye(m*Nu); -eye(m*Nu)];
    cDu = [mountCstrMatrix(DUmax,m,Nu);mountCstrMatrix(-DUmin,m,Nu)];
    RU = [auxMatrixCstr(1,0,m,Nu);auxMatrixCstr(-1,0,m,Nu)];   
    cU = [mountCstrMatrix(Umax,m,Nu);...
          mountCstrMatrix(-Umin,m,Nu)];
%     RY = [G;-G];
    RY = [G(1,1:end);-G(1,1:end)];
%     cY = [mountCstrMatrix(Ymax,n,N2); mountCstrMatrix(-Ymin,n,N2)];
    cY = [Ymax; -Ymin];
    if (restricaoDU)
        Restr = [Restr; RDu];
        c = [c; cDu];
        E = zeros(2*Nu,N2+Nu+1);
    end
    if (restricaoU)
        Restr = [Restr; RU];
        c = [c; cU];
%         E =[E; zeros(Nu,N2) -eye(Nu,Nu) zeros(Nu,N2);zeros(Nu,N2) eye(Nu,Nu) zeros(Nu,N2)];
        E =[E; zeros(Nu,N2) -eye(Nu,Nu) zeros(Nu,1);zeros(Nu,N2)  eye(Nu,Nu) zeros(Nu,1)]; %Crane
    end
    if (restricaoY)
        Restr = [Restr; RY];
        c = [c; cY];
%         E = [E; zeros(N2,N2+Nu) -eye(N2,N2);zeros(N2,N2+Nu)
%         eye(N2,N2)];%Crane
        E = [E; zeros(1,Nu+N2) -1;zeros(1,Nu+N2) 1]; 
    end

% if (toSave)
%     tstart = tic;
    [Pn,Fi,Gi,details] = multparametric(H,G,R,cnstrMatrix,Restr,c,E);
%     tTuningMult = toc(tstart);
% end
clear online_MPT
load('mptResult.mat')
% load('mptCraneNp46D500.mat') 
    
% Vetor de saída
Y = zeros(n,samples);

% Vetor do sinal de controle
U = 0*ones(m,samples);

% Vetor da variação do sinal de controle
DU = zeros(m,samples);

% Inicialização dos vetores
r = zeros(n*N2,1);
w = zeros(n*N2,1);

%%
tstart = tic;
for k = 1:samples
    % Simulando Planta
    
    % Displacement X
    usim = mountVectorU(U,nbd,k,0);
    ysim = mountVectorY(Y,na,k,0);
    Y(:,k) = -Asim*ysim+Bd*usim;
 
    %----------------------------------------------------------------------
    % MIMO GPC - Cálculo da variação do sinal de controle
    du = MultconstrainedMGPC(F,G_,Y,na,U,nbd,Ref,r,w,alpha,N2,Nu,n,k,Pn,Fi,Gi,E);
    DU(:,k) = du;
    %----------------------------------------------------------------------
    % Lei de controle do GPC
    if (k > 1) % tratamento para o indice 0 no matlab
        U(:,k) = U(:,k-1) + du;
    else
        U(:,k) = du;
    end
end
tEGPC = toc(tstart);

%% Plotagem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
controle = 'Explicity GPC';

uUpLim = 1.02*Umax;
uBotLim = 1.02*Umin;

Umaxplot = Umax*ones(1,length(vectorTime));
Uminplot = Umin*ones(1,length(vectorTime));
DUmaxplot = DUmax*ones(1,length(vectorTime));
DUminplot = DUmin*ones(1,length(vectorTime));

plothandle = 9:12;

h(plothandle(1)) = figure(plothandle(1)); clf(plothandle(1))
actualHandle = h(plothandle(1));

plotConfig(actualHandle);
    plot(vectorTime,Ref,'--','Linewidth',2,'Color', colors(1,:));
    hY = plot(vectorTime,Y,'-','Linewidth',2,'Color', colors(1,:));
%         hsmax(i) = plot(vectorTime,1.02*Ref(i,:),'r--','Linewidth',2);
%         hsmin(i) = plot(vectorTime,0.98*Ref(i,:),'r--','Linewidth',2);
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtYLabel);
    sTitle = sprintf('Limb Control - %s', controle);
    title(sTitle)
%     axis(h(plothandle(1)), [0 simTime 0 0.75])
%     hLegendY = legend(hY,legendY);
%     set(hLegendY,'Box','off');

    if (savePlot)
        figure(actualHandle)
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'xEGPC.eps');  
                print(actualHandle,'xEGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'xEGPC.pdf','-dpdf','-r0')
            end
    end

h(plothandle(2)) = figure(plothandle(2)); clf(plothandle(2))
actualHandle = h(plothandle(2));

plotConfig(actualHandle);
    hU = stairs(vectorTime,U,'Linewidth',2,'Color', colors(1,:));
%     hU = plot(vectorTime,U(i,:),'Linewidth',2,'Color', colors(i,:));
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtULabel);
    sTitle = sprintf('Limb Control - %s', controle);
    title(sTitle)
%     axis([0 simTime 1.1*Umin 1.1*Umax])
%     hLegendU = legend(legendU);
%     set(hLegendU,'Box','off');

    if (savePlot)
        figure(actualHandle)
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 28);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uEGPC.eps');  
                print(actualHandle,'uEGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'uEGPC.pdf','-dpdf','-r0')
            end
    end
    
h(plothandle(3)) = figure(plothandle(3)); clf(plothandle(3))
actualHandle = h(plothandle(3));

plotConfig(actualHandle);
    hDU = stairs(vectorTime,DU,'Linewidth',2,'Color', colors(1,:));
%     hDU = plot(vectorTime,DU(i,:),'Linewidth',2,'Color', colors(i,:));
    hold on;
%     hU = plot(vectorTime,U(i,:),'Linewidth',2,'Color', colors(i,:));
%     plot(vectorTime,DUmaxplot,'r--');
%     plot(vectorTime,DUminplot,'r--');
    hold off;
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtDULabel);
    sTitle = sprintf('Limb Control - %s', controle);
    title(sTitle)
%     axis([0 simTime 1.1*DUmin 1.1*DUmax])   
%     hLegendU = legend(legendU);
%     set(hLegendU,'Box','off');

    if (savePlot)
        figure(actualHandle)
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 28);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'duEGPC.eps');  
                print(actualHandle,'duEGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'duEGPC.pdf','-dpdf','-r0')
            end
    end
