% generate initial population with tuning range <z1, z2>
function pop = initPop(z1, z2, os)
    pop = (z2 - z1) .* rand(os, 3) + z1;
end
