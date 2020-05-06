function Indices = showIndices(vectorTime,Ref,Y,U)

simTime = vectorTime(end);
erro = Ref-Y;
overshoot = (max(Y(1:1100))/Ref(1100)-1)*100;

ref2max = 1.02*Ref(1100);
ref2min = 0.98*Ref(1100);

settlingTime = vectorTime(find(~(Y(1:1100) >= ref2min & Y(1:1100) <= ref2max), 1, 'last'));

goodHart = goodhart(simTime,erro,U);
MSE = sum(erro.^2)/simTime;
IE = sum(erro);
IAE = sum(abs(erro));
ISE = sum(erro.^2);
ITAE = zeros(1,simTime+1);
ITSE = zeros(1,simTime+1);
for k = vectorTime(2):vectorTime(end)+vectorTime(2)
    ITAE(floor(k/vectorTime(2))) = k*abs(erro(floor(k/vectorTime(2))));
    ITSE(floor(k/vectorTime(2))) = k*erro(floor(k/vectorTime(2)))^2;
end
ITAE = sum(ITAE);
ITSE = sum(ITSE);

Indices = cell(8,2);
Indices{1,1} = 'GoodHart';
Indices{2,1} = 'MSE';
Indices{3,1} = 'IE';
Indices{4,1} = 'IAE';
Indices{5,1} = 'ISE';
Indices{6,1} = 'ITAE';
Indices{7,1} = 'ITSE';
Indices{8,1} = 'Overshoot';
Indices{9,1} = 'Settling';

Indices{1,2} = goodHart;
Indices{2,2} = MSE;
Indices{3,2} = IE;
Indices{4,2} = IAE;
Indices{5,2} = ISE;
Indices{6,2} = ITAE;
Indices{7,2} = ITSE;
Indices{8,2} = overshoot;
Indices{9,2} = settlingTime;