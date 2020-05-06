%% Inicialização do GPC multivariável %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Crane

[F,G_,G,K,tTuningUGPC] = initMIMOgpc(A,Bd,N2,Nu,R,Q);

Bd = cell2mat(Bd);

basicPlotConfigCrane
toPlot = 1;
savePlot = 0;
toSave = 0;
toEPS = 1;

% Habilitando restrições
restricaoDU = 0;
restricaoU = 1;
restricaoY = 1;
withCnstr = [restricaoDU restricaoU restricaoY];

% unconstrainedGPC_Crane
% UGPC_ind = showIndices(vectorTime,Ref,Y,U);
constrainedGPC_Crane
CGPC_ind = showIndices(vectorTime,Ref(1,:),Y(1,:),U)
% multGPC_Crane
% multGPC_ind = showIndices(vectorTime,Ref,Y(:,1),U);

if(~toPlot)
    close all;
end

%%
if (toSave)
    indices = UGPC_ind;
    indices(:,3) = CGPC_ind(:,2);
    indices(:,4) = multGPC_ind(:,2);

    Tempo = cell(3,4);
    Tempo{1,1} = 'Time/Algorithm';
    Tempo{1,2} = 'UGPC';
    Tempo{1,3} = 'CGPC';
    Tempo{1,4} = 'EGPC';

    Tempo{2,1} = 'Tuning Time (s)';
    Tempo{3,1} = 'Online Time (s)';

    Tempo{2,2} = tTuningUGPC;
    Tempo{2,3} = 0;
    Tempo{2,4} = tTuningMult;

    Tempo{3,2} = tUGPC;
    Tempo{3,3} = tCGPC;
    Tempo{3,4} = tEGPC;

    save('indAndTime.mat','indices','Tempo');
end