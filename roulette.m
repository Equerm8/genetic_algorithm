function [rand_indiv_1,rand_indiv_2] = roulette(N, roulette_probabillity)
    % search for first individual
    random_num = randi([0 100]);
    
    for i = 1:N
        if random_num <= round(roulette_probabillity(i), 6) + 1e-10
            rand_indiv_1 = i;
            break;
        end
    end

    rand_indiv_2 = rand_indiv_1;
    
    % search for second individual
    while rand_indiv_1 == rand_indiv_2
        random_num = randi([0 100]);
        for i = 1:N
            if random_num <= round(roulette_probabillity(i), 6) + 1e-10
                rand_indiv_2 = i;
                break;
            end
        end
    end
end

