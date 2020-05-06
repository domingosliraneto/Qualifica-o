function [Bd,A] = createModel(num,den,delay,nOutputs,nInputs)
    tempA = cell(1,nOutputs);
    tempB = cell(nOutputs,nInputs);
       
    maxADegree = 0;
    maxBDegree = 0;
    for i = 1:nOutputs
        numB = cell(1,nInputs);
        denLCM = mylcm(den(i,:));
        maxADegree = max(maxADegree, degree(denLCM));
        tempA{i} = denLCM;
        for j = 1:nInputs
            aux = mytimes({deconv(denLCM,den{i,j}),num{i,j}});
            maxBDegree = max(maxBDegree, degree(aux));
            numB{j} = aux;
        end
        tempB(i,:) = numB;
    end

    A = cell(1, maxADegree+1);
    A{1} = eye(nOutputs, nOutputs);   
    for k = 2:maxADegree+1
        a = zeros(nOutputs,nOutputs);
        for i = 1:nOutputs
            if (k <= degree(tempA{i})+1)
                a(i,i) = tempA{i}(k);
            end
        end
        A{1, k} = a;
    end

    B = cell(1, maxBDegree+1);
    for k = 1:maxBDegree+1
        b = zeros(nOutputs,nInputs);
        for i = 1:nOutputs
            for j = 1:nInputs
                if (k <= degree(tempB{i,j})+1)
                    b(i, j) = tempB{i,j}(k);
                end
            end
        end       
        B{1, k} = b;
    end 
    
    nb = maxOrders(B,nOutputs,nInputs);
    Bd = delayingB(B,nb,delay,nOutputs,nInputs);