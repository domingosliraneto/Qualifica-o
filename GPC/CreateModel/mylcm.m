function lcmPoly = mylcm(p)
    len = length(p);
    lcmPoly = p{1};

    if (len >= 2)
        for i = 2:len
            nextPoly = p{i};
            gcdPoly = mygcd(nextPoly,lcmPoly);
            factorB = deconv(nextPoly,gcdPoly);
            factorA = deconv(lcmPoly,gcdPoly);

            lcmPoly = mytimes({gcdPoly,factorB,factorA});
        end
    end
end