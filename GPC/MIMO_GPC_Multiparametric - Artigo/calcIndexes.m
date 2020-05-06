function [goodHart,MSE,IE,IAE,ISE,ITAE,ITSE] = calcIndexes(erro,U,simTime)

goodHart = goodhart(simTime,erro,U);
MSE = sum(erro.^2)/simTime;
IE = sum(erro);
IAE = sum(abs(erro));
ISE = sum(erro.^2);
ITAE = zeros(1,simTime+1);
ITSE = zeros(1,simTime+1);
for k = 1:simTime+1
    ITAE(k) = k*abs(erro(k));
    ITSE(k) = k*erro(k)^2;
end
ITAE = sum(ITAE);
ITSE = sum(ITSE);