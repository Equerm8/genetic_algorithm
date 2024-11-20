%% object - first-order inertial object with delay
K = 1.1;
T1 = 3.5;
T2 = 2.5;
tau = 1.5;

% transmittance
G=tf(K,[T1*T2, T1+T2, 1],'iodelay',tau);

%% initial population and cost function
N = 30;
population = initPop(0, 2, N);

%% main loop
for iteration = 1:20
    %% estimate cost funciton 
    J = zeros(N, 1);
    for i = 1:N
        J(i) = costFunc(population(i, :), G, 2);
    end

    %% getting roulette probabillity 
    roulette_probabillity = get_roulette_probability(J, N);

    %% conversion of doubles to strings for crossbreeding
    [cols, rows] = size(population);
    populationBin = string(zeros(cols, rows));
    mult = 100;
    for i = 1:cols
        [KpDouble, TiDouble, TdDouble] = deal(population(i, 1), population(i, 2), population(i, 3));
        if KpDouble ~= -1
            [KpBin, TiBin, TdBin] = dec2binFunc(KpDouble, TiDouble, TdDouble, mult);
            [populationBin(i, 1), populationBin(i, 2), populationBin(i, 3)] = deal(KpBin, TiBin, TdBin);
        else
            populationBin(i, 1:3) = [-1 -1 -1];
        end
    end

    %% elitarism + crossbreeding + mutation + inversion
    crossIndex = 5;
    individual_1 = ["0" "0" "0"];
    individual_2 = ["0" "0" "0"];
    
    new_population = string(zeros(N, 3));
    [max_index, ~] = size(populationBin);
    

    is_elitarism = false;
    indiv_num_elitarism = 1;

    is_mutation = false;
    mutation_probabillity = 4;
    
    is_inversion = false;
    inversion_probabillity = 4;


    % elitarism
    elitarism_index = 0;
    if is_elitarism
        J_cpy = sort(J);
        for elitarism_index = 1:indiv_num_elitarism
            best_index = find(J == J_cpy(1));
            best_index = best_index(1);
            new_population(elitarism_index, :) = populationBin(best_index, :);
        end
    end
    new_index = elitarism_index + 1;


    for i = 1:N/2 + 1
        
        % choose individuals based on roulette selection
        [rand_indiv_1, rand_indiv_2] = roulette(N, roulette_probabillity);
        
        individual_1(:) = populationBin(rand_indiv_1, :);
        individual_2(:) = populationBin(rand_indiv_2, :);

        [Kp_1, Ti_1, Td_1] = deal(individual_1(1), individual_1(2), individual_1(3));
        [Kp_2, Ti_2, Td_2] = deal(individual_2(1), individual_2(2), individual_2(3));
        
        % Kp crossbreeding
        [individual_1(1), individual_2(1)] = crossbreeding(Kp_1, Kp_2, crossIndex);
        % Ti crossbreeding
        [individual_1(2), individual_2(2)] = crossbreeding(Ti_1, Ti_2, crossIndex);
        % Td crossbreeding
        [individual_1(3), individual_2(3)] = crossbreeding(Td_1, Td_2, crossIndex);
        
        % mutation
        if is_mutation
            [individual_1, individual_2] = mutation(individual_1, individual_2, mutation_probabillity);
        end

        % inversion
        if is_inversion
            [individual_1, individual_2] = mutation(individual_1, individual_2, inversion_probabillity);
        end

        new_population(new_index, :) = individual_1;
        new_index = new_index + 1;
        if new_index > N 
            break 
        end
        new_population(new_index, :) = individual_2;
        new_index = new_index + 1;
        if new_index > N 
            break 
        end
    end

    %% back to double
    for i = 1:cols
        population(i, :) = bin2dec(new_population(i, :)) / mult;
    end

end

% Test of the best individual
best = find(J == min(J));
best = best(1);
s = tf('s');
Kp = population(best, 1);
Ti = population(best, 2);
Td = population(best, 3);
C = Kp * (1 + Ti/s + Td*s);
Go = C*G;
Gc = Go / (1 + Go);
figure(1)
grid on
step(Gc);
