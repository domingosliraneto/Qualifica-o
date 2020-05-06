function goodhartValue = goodhart(t,erro,u)
    alfa1 = 0.2; 
    alfa2 = 0.3;
    alfa3 = 0.5;
    
    epsilon1 = sum(u)/t;
    epsilon2 = sum((u-epsilon1).^2)/t;
    epsilon3 = sum(abs(erro))/t;
    
    goodhartValue = alfa1*epsilon1 + alfa2*epsilon2 + alfa3*epsilon3;