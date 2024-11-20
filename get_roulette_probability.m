function roulette_probability = get_roulette_probability(J, N)
    sumation = sum(J);
    involvement = zeros(N, 1);
    for i = 1:N
        involvement(i) = sumation / J(i);
    end
    involv_sumation = sum(involvement);
    real_involvement = involvement / involv_sumation;
    roulette_probability = zeros(N, 1);
    for i = 1:N
        roulette_probability(i) = sum(real_involvement(1:i)) * 100;
    end
end

