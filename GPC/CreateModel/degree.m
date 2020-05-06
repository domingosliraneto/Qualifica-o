function d = degree(poly) 
    d = 0;
    n = numel(poly);
    for i = 1:n
        if (poly(i) ~= 0)
            d = n-i;
            break;
        end
    end
end