% sim('limbControl.slx')
Ref = Outputs{1}.Values.Data(:,1);
Ymppid = Outputs{1}.Values.Data(:,2);
Ypid = Outputs{1}.Values.Data(:,3);
Upid = Upid{1}.Values.Data;
Umppid = Umppid{1}.Values.Data;
%%
PID_ind = showIndices(tout,Ref,Ypid,Upid);
MPPID_ind = showIndices(tout,Ref,Ymppid,Umppid);
save('controlerIndices.mat','PID_ind', 'MPPID_ind')

vectorTime = tout;
Umax = 1.4;
Umin = -0.05;
colors = [ 0  0  0;
        .4 .4 .4;
        .7 .7 .7];
    
txtXLabel = 'Time (s)';
txtYLabel = {'Angle Position (rad)'};
txtULabel = {'Input Voltage (V)'};
legendY   = {'Referencia'; 'MP-PID';'PID'};
savePlot  = 1;
toEPS     = 1;

controle = 'MP-PID X PID';

uUpLim = 1.04*Umax;
uBotLim = 1.04*Umin;

Umaxplot = Umax*ones(1,length(vectorTime));
Uminplot = Umin*ones(1,length(vectorTime));

plothandle = 1:4;

h(plothandle(1)) = figure(plothandle(1)); clf(plothandle(1));
actualHandle = h(plothandle(1));

plotConfig(actualHandle);
    plot(vectorTime,Ref,'--','Linewidth',2,'Color', colors(1,:));
    hold on
    hY = plot(vectorTime,Ymppid,'-','Linewidth',2,'Color', colors(1,:));
    hY = plot(vectorTime,Ypid,'--','Linewidth',2,'Color', colors(3,:));
    set(legend(legendY));
%         hsmax(i) = plot(vectorTime,1.02*Ref(i,:),'r--','Linewidth',2);
%         hsmin(i) = plot(vectorTime,0.98*Ref(i,:),'r--','Linewidth',2);
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtYLabel);
    sTitle = sprintf('Controle do Membro - %s', controle);
    title(sTitle);
    axis([0 250 Umin Umax]);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'xCGPC.eps');  
                print(actualHandle,'Ypidxmppid.fig','-depsc','-r0');
                print(actualHandle,'Ypidxmppid.eps','-depsc','-r0');
            else                
                print(actualHandle,'Ypidxmppid.pdf','-dpdf','-r0');
            end
    end

h(plothandle(2)) = figure(plothandle(2)); clf(plothandle(2));
actualHandle = h(plothandle(2));

plotConfig(actualHandle); 
    hU = stairs(vectorTime,Umppid,'Linewidth',2,'Color', colors(1,:));
    hold on;
    hU = stairs(vectorTime,Upid,'Linewidth',2,'Color', colors(3,:));
    set(legend(legendY{2:3,1}));
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(txtULabel);
    sTitle = sprintf('Controle do Membro - %s', controle);
    title(sTitle);
    axis([0 250 Umin Umax]);
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
                print(actualHandle,'Upidxmppid.fig','-depsc','-r0');
                print(actualHandle,'Upidxmppid.eps','-depsc','-r0');
            else                
                print(actualHandle,'Upidxmppid.pdf','-dpdf','-r0');
            end
    end
    clc;
 
