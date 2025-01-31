% sim('LimbIdentification.slx')
originalSignal         = Data.signals(2).values;
originalSystemOutput   = Data.signals(1).values;
systemOutput                  = Data2.signals(1).values;
inputBeforeNonlinearAdjust    = Data2.signals(2).values;
outputAfterLinearAproximation = Data2.signals(3).values;
inputAfterNonlinearAdjust     = Data2.signals(4).values;
%%
vectorTime = tout;
Umax = 1.4;
Umin = -0.05;
colors = [ 0  0  0;
        .4 .4 .4;
        .7 .7 .7];
    
tempo = 'Time (s)';
angulo = {'Posição Angular (rad)'};
Tensao = {'Tensão de Entrada (V)'};
legendY   = {'Sinal de Entrada Original'; 'MP-PID';'PID'};
savePlot  = 1;
toEPS     = 1;



plothandle = 5:10;

h(plothandle(1)) = figure(plothandle(1)); clf(plothandle(1));
actualHandle = h(plothandle(1));

controle = 'Sinal de Entrada do Sistema';
plotConfig(actualHandle);
    plot(vectorTime,originalSignal,'-','Linewidth',2,'Color', colors(1,:));
    axis([0 1235 -0.5 50.5]);
    grid on; box off;
    xlabel(tempo);
    ylabel(Tensao);
    sTitle = sprintf('Identificação do Membro - %s', controle);
    title(sTitle);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'xCGPC.eps');  
                print(actualHandle,'Uoriginal.fig','-depsc','-r0');
                print(actualHandle,'Uoriginal.eps','-depsc','-r0');
            else                
                print(actualHandle,'Uoriginal.pdf','-dpdf','-r0');
            end
    end

h(plothandle(2)) = figure(plothandle(2)); clf(plothandle(2));
actualHandle = h(plothandle(2));

controle = 'Sinal de Saída para a Tensão Gerada';
plotConfig(actualHandle); 
    hU = stairs(vectorTime,originalSystemOutput,'Linewidth',2,'Color', colors(1,:));
    grid on; box off;
    xlabel(tempo);
    ylabel(angulo);
    sTitle = sprintf('Identificação do Membro - %s', controle);
    title(sTitle);
    axis([0 1235 -0.2 1.35]);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 22);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uCGPC.eps');  
                print(actualHandle,'Yoriginal.fig','-depsc','-r0');
                print(actualHandle,'Yoriginal.eps','-depsc','-r0');
            else                
                print(actualHandle,'Yoriginal.pdf','-dpdf','-r0');
            end
    end
    
    h(plothandle(3)) = figure(plothandle(3)); clf(plothandle(3));
actualHandle = h(plothandle(3));

controle = 'Nova Entrada Antes do Ajuste Não Linear X Saída';
plotConfig(actualHandle); 
    hU = stairs(vectorTime,systemOutput,'--','Linewidth',2,'Color', colors(1,:));
    hold on
    hU = stairs(vectorTime,inputBeforeNonlinearAdjust,'Linewidth',2,'Color', colors(3,:));
    set(legend({'Saída'; 'Entrada'}));
    grid on; box off;
    xlabel(tempo);
    ylabel(angulo);
    sTitle = sprintf('Identificão do Membro - %s', controle);
    title(sTitle);
    axis([0 1235 -0.2 1.35]);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 22);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uCGPC.eps');  
                print(actualHandle,'inputBeforeNonlinearAdjust.fig','-depsc','-r0');
                print(actualHandle,'inputBeforeNonlinearAdjust.eps','-depsc','-r0');
            else                
                print(actualHandle,'inputBeforeNonlinearAdjust.pdf','-dpdf','-r0');
            end
    end
    
        h(plothandle(4)) = figure(plothandle(4)); clf(plothandle(4));
actualHandle = h(plothandle(4));

txtXLabel = 'Blalala';
controle = 'Compensação Não Linear Realizada no Sinal Linear';
plotConfig(actualHandle); 
    hU = stairs(vectorTime,inputAfterNonlinearAdjust,'Linewidth',2,'Color', colors(1,:));
    grid on; box off;
    xlabel(txtXLabel);
    ylabel(Tensao);
    sTitle = sprintf('Identificaçãoo do Membro - %s', controle);
    title(sTitle);
    axis([0 1235 -0.5 45]);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 22);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uCGPC.eps');  
                print(actualHandle,'inputAfterNonlinearAdjust.fig','-depsc','-r0');
                print(actualHandle,'inputAfterNonlinearAdjust.eps','-depsc','-r0');
            else                
                print(actualHandle,'inputAfterNonlinearAdjust.pdf','-dpdf','-r0');
            end
    end
    
    h(plothandle(5)) = figure(plothandle(5)); clf(plothandle(5));
actualHandle = h(plothandle(5));

controle = 'Saida com Dinâmica Aproximada X Saída do Sistema Não Linear';
plotConfig(actualHandle); 
    hU = stairs(vectorTime,systemOutput,'--','Linewidth',2,'Color', colors(1,:));
    hold on
    hU = stairs(vectorTime,outputAfterLinearAproximation,'Linewidth',2,'Color', colors(3,:));
    set(legend({'Aproximada'; 'Não Linear'}));
    grid on; box off;
    xlabel(tempo);
    ylabel(angulo);
    sTitle = sprintf('Identificação do Membro - %s', controle);
    title(sTitle);
    axis([0 1235 -0.2 1.35]);


    if (savePlot)
        figure(actualHandle);
            set(actualHandle,'PaperPositionMode','auto','Units','Inches');
            pos = get(actualHandle,'Position');
            set(actualHandle,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
            set(gca,'FontSize', 22);
            if(toEPS)
%                 print -depsc2 planta.eps   
%                 fixPSlinestyle('planta.eps', 'uCGPC.eps');  
                print(actualHandle,'outputAfterLinearAproximation.fig','-depsc','-r0');
                print(actualHandle,'outputAfterLinearAproximation.eps','-depsc','-r0');
            else                
                print(actualHandle,'outputAfterLinearAproximation.pdf','-dpdf','-r0');
            end
    end
    clc;
 
