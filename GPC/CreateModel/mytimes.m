function p = mytimes(poly)
    len = length(poly);
    p = poly{1};
    if (len >= 2)
        for i = 2:len
            p = conv(p,poly{i});
        end
    end
end