%% Simula��o %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vetor de sa�da
Y = zeros(n,samples);

% Vetor do sinal de controle
U = 0*ones(m,samples);

% Vetor da varia��o do sinal de controle
DU = zeros(m,samples);

% Inicializa��o dos vetores
r = zeros(n*N2,1);
w = zeros(n*N2,1);
save('gpcData.mat','Y','Ref','K','F','G','G_','na','U','nbd','r','w','alpha','N2','Nu','R','Q','n','m','withCnstr','cnstrMatrix')
sim('limbControl1.slx')

%%
% tstart = tic;
% for k = 1:samples
%     % Simulando Planta
%     
%     % Displacement X
%     usim = mountVectorU(U,nbd,k,0);
%     ysim = mountVectorY(Y,na,k,0);
%     Y(:,k) = -Asim*ysim+Bd*usim;
%  
%     %----------------------------------------------------------------------
%     % MIMO GPC - C�lculo da varia��o do sinal de controle
%     du = constrainedMGPC(K,F,G,G_,Y,na,U,nbd,Ref,r,w,alpha,N2,Nu,R,Q,n,m,withCnstr,cnstrMatrix,k);
%     
%     DU(:,k) = du;
%     %----------------------------------------------------------------------
%     % Lei de controle do GPC
%     if (k > 1) % tratamento para o indice 0 no matlab
%         U(:,k) = U(:,k-1) + du;
%     else
%         U(:,k) = du;
%     end
% end
% tCGPC = toc(tstart);

%% Plotagem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

controledOutput = Data.signals.values(:,1);
gpcReference    = Data.signals.values(:,2);
inputBeforeNonlinearAdjust   = Data1.signals(1).values;
inputAfterNonlinearAdjust    = Data1.signals(2).values;

GPC_ind = showIndices(tout,gpcReference,controledOutput,inputBeforeNonlinearAdjust);
save('controlerIndices.mat','GPC_ind')

vectorTime = tout;
Umax = 1.4;
Umin = -0.05;
colors = [ 0  0  0;
        .4 .4 .4;
        .7 .7 .7];
    
txtXLabel = 'Time (s)';
txtYLabel = {'Angle Position (rad)'};
txtULabel = {'Input Voltage (V)'};
legendY   = {'Referencia'; 'GPC'};
savePlot  = 1;
toEPS     = 1;

controle = 'GPC';

uUpLim = 1.04*Umax;
uBotLim = 1.04*Umin;

Umaxplot = Umax*ones(1,length(vectorTime));
Uminplot = Umin*ones(1,length(vectorTime));

plothandle = 5:8;

h(plothandle(1)) = figure(plothandle(1)); clf(plothandle(1));
actualHandle = h(plothandle(1));

plotConfig(actualHandle);
    plot(vectorTime,gpcReference,'--','Linewidth',2,'Color', colors(1,:));
    hold on
    hY = plot(vectorTime,controledOutput,'-','Linewidth',2,'Color', colors(1,:));
    set(legend(legendY));
%         hsmax(i) = plot(vectorTime,1.02*Ref(i,:),'r--','Linewidth',2);
%         hsmin(i) = plot(vectorTime,0.98*Ref(i,:),'r--','Linewidth',2);
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtYLabel);
    sTitle = sprintf('Controle do Membro - %s', controle);
    title(sTitle);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'xCGPC.eps');  
                print(actualHandle,'YGPC.fig','-depsc','-r0');
                print(actualHandle,'YGPC.eps','-depsc','-r0');
            else                
                print(actualHandle,'YGPC.pdf','-dpdf','-r0');
            end
    end

h(plothandle(2)) = figure(plothandle(2)); clf(plothandle(2));
actualHandle = h(plothandle(2));

plotConfig(actualHandle); 
    hU = stairs(vectorTime,inputBeforeNonlinearAdjust,'Linewidth',2,'Color', colors(1,:));
    set(legend(legendY{2,1}));
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtULabel);
    sTitle = sprintf('Controle do Membro - %s', controle);
    title(sTitle);
    axis([0 300 Umin Umax]);
%     hLegendU = legend(legendU);
%     set(hLegendU,'Box','off');

    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 28);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uCGPC.eps');  
                print(actualHandle,'Ugpc.fig','-depsc','-r0');
                print(actualHandle,'Ugpc.eps','-depsc','-r0');
            else                
                print(actualHandle,'Ugpc.pdf','-dpdf','-r0');
            end
    end
    clc;
    acabou
 




