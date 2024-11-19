function roulette_probability = get_roulette_probability(J)
    sumation = sum(J);
    involvement = zeros(30, 1);
    for i = 1:30
        involvement(i) = sumation / J(i);
    end
    involv_sumation = sum(involvement);
    real_involvement = involvement / involv_sumation;
    roulette_probability = zeros(30, 1);
    for i = 1:30
        roulette_probability(i) = sum(real_involvement(1:i)) * 100;
    end
end

