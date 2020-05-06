function [Fp,Gp,Fn,Gn] = MontaRestricoes(duMax,duMin,yMax,yMin,uMax,uMin,uk1,A,B,C,X0)

    Fdu = eye(size(B,2));
    Gdu = ones(size(B,2),1)*duMax;
    Fy  = eye(size(C,1));
    Gy  = ones(size(C,1),1)*yMax;
    Fu  = eye(size(B,2));
    Gu  = ones(size(B,2),1)*uMax;
    M = [];
    for i = 1:size(B,2)
       M = [M; ones(1,i) zeros(1,size(B,2)-i)]; 
    end
    L   = ones(size(B,2),1);

    Fp = [Fdu; Fy*C*B; Fu*M];
    Gp = [Gdu; Gy-Fy*C*A*X0; Gu-Fu*L*uk1];
    
    Fdun = [eye(size(B,2))];
    Gdun = [ones(size(B,2),1)*duMin];
    Fyn  = [eye(size(C,1))];
    Gyn  = [ones(size(C,1),1)*yMin];
    Fun  = [eye(size(B,2))];
    Gun  = [ones(size(B,2),1)*uMin];
    M   = [];
    
    for i = 1:size(B,2)
       M = [M; ones(1,i) zeros(1,size(B,2)-i)]; 
    end
    L   = ones(size(B,2),1);

    Fn = [Fdun; Fyn*C*B; Fun*M];
    Gn = [Gdun; Gyn-Fyn*C*A*X0; Gun-Fun*L*uk1];
    
    
    
    
end