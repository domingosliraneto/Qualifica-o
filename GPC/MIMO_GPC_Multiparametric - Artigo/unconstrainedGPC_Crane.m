%% Simula��o %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Habilitando restri��es
restricaoDU = 0;
restricaoU = 0;
restricaoY = 0;
withCnstr = [restricaoDU restricaoU restricaoY];

% Vetor de sa�da
Y = zeros(n,samples);

% Vetor do sinal de controle
U = 0*ones(m,samples);

% Vetor da varia��o do sinal de controle
DU = zeros(m,samples);

% Inicializa��o dos vetores
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
    % MIMO GPC - C�lculo da varia��o do sinal de controle

    du = constrainedMGPC(K,F,G,G_,Y,na,U,DU,nbd,Ref,r,w,alpha,N2,N2r,Nu,R,Q,n,m,withCnstr,cnstrMatrix,k);
   
    DU(:,k) = du;
    %----------------------------------------------------------------------
    % Lei de controle do GPC
    if (k > 1) % tratamento para o indice 0 no matlab
        U(:,k) = U(:,k-1) + du;
        if (U(:,k) > Umax)
            U(:,k) = Umax;
        elseif (U(:,k) < Umin)
            U(:,k) = Umin;
        end
    else
        U(:,k) = du;
        if (U(:,k) > Umax)
            U(:,k) = Umax;
        elseif (U(:,k) < Umin)
            U(:,k) = Umin;
        end
    end
end
tUGPC = toc(tstart);

%% Plotagem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
controle = 'Unconstrained GPC';

uUpLim = 1.02*Umax;
uBotLim = 1.02*Umin;

Umaxplot = Umax*ones(1,length(vectorTime));
Uminplot = Umin*ones(1,length(vectorTime));
DUmaxplot = DUmax*ones(1,length(vectorTime));
DUminplot = DUmin*ones(1,length(vectorTime));

plothandle = 1:4;

h(plothandle(1)) = figure(plothandle(1)); clf(plothandle(1))
actualHandle = h(plothandle(1));

plotConfig(actualHandle);
    plot(vectorTime,Ref,'--','Linewidth',2,'Color', colors(1,:));
    hY = plot(vectorTime,Y(1,:),'-','Linewidth',2,'Color', colors(1,:));
%         hsmax(i) = plot(vectorTime,1.02*Ref(i,:),'r--','Linewidth',2);
%         hsmin(i) = plot(vectorTime,0.98*Ref(i,:),'r--','Linewidth',2);
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtYLabel);
    sTitle = sprintf('Crane Control - %s', controle);
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
%                 fixPSlinestyle('planta.eps', 'xUGPC.eps');  
                print(actualHandle,'xUGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'xUGPC.pdf','-dpdf','-r0')
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
    sTitle = sprintf('Crane Control - %s', controle);
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
%                 fixPSlinestyle('planta.eps', 'uUGPC.eps');  
                print(actualHandle,'uUGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'uUGPC.pdf','-dpdf','-r0')
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
    sTitle = sprintf('Crane Control - %s', controle);
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
%                 fixPSlinestyle('planta.eps', 'duUGPC.eps');  
                print(actualHandle,'duUGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'duUGPC.pdf','-dpdf','-r0')
            end
    end
    
h(plothandle(4)) = figure(plothandle(4)); clf(plothandle(4))
actualHandle = h(plothandle(4));

plotConfig(actualHandle);
    plot(vectorTime,Ref(2,:),'--','Linewidth',2,'Color', colors(1,:));
    plot(vectorTime,Y(2,:),'linewidth',2)    
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtYthLabel);
    sTitle = sprintf('Crane Control - %s', controle);
    title(sTitle)
    axis([0 simTime -0.01 0.01])   
%     hLegendU = legend(legendU);
%     set(hLegendU,'Box','off');

    if (savePlot)
        figure(actualHandle)
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'ythUGPC.eps');  
                print(actualHandle,'ythUGPC.eps','-depsc','-r0')
            else                
                print(actualHandle,'ythUGPC.pdf','-dpdf','-r0')
            end
    end
    
%}