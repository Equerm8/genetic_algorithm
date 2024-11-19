% random mutation
function [individual_1, individual_2] = mutation(individual_1, individual_2, probabillity_of_mutation)
    drawn_probabillity = randi([0, 100]);
    if drawn_probabillity <= probabillity_of_mutation
        indiv_index = randi(2);
        chromosome_index = randi(3);
        allel_index = randi(10);
        if indiv_index == 1
            chromosome = individual_1(chromosome_index);
            allel = chromosome{1}(allel_index);
            allelDouble = str2double(allel);
            allelDouble = num2str(~allelDouble);
            allelStr = string(allelDouble);
            chromosome{1}(allel_index) = allelStr;
            individual_1(chromosome_index) = chromosome;
        else
            chromosome = individual_2(chromosome_index);
            allel = chromosome{1}(allel_index);
            allelDouble = str2double(allel);
            allelDouble = num2str(~allelDouble);
            allelStr = string(allelDouble);
            chromosome{1}(allel_index) = allelStr;
            individual_2(chromosome_index) = chromosome;
        end
    end
end