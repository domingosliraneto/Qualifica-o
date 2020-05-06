function out = gpcOnline(ref,y,t,variables)
    persistent K
    persistent F
    persistent G
    persistent G_
    persistent na
    persistent nbd
    persistent r
    persistent w
    persistent alpha
    persistent N2
    persistent Nu
    persistent R
    persistent Q
    persistent n
    persistent m
    persistent withCnstr
    persistent cnstrMatrix
    persistent k
    persistent U
    persistent Ref
    persistent Y
    
    if(isempty(k))
       load(variables); 
       k = 1;
    end
    if(t >= (k-1)*0.01)
        Ref(k) = ref;
        Y(k) = y;
        du = constrainedMGPC(K,F,G,G_,Y,na,U,nbd,Ref,r,w,alpha,N2,Nu,R,Q,n,m,withCnstr,cnstrMatrix,k);
        k = k+1;
        U(k) = U(k-1) + du;
        
    end
    out =  U(k);
end