% random inversion
function [individual_1, individual_2] = inversion(individual_1, individual_2, probabillity_of_inversion)
    drawn_probabillity = randi([0, 100]);
    if drawn_probabillity <= probabillity_of_inversion
        indiv_index = randi(2);
        chromosome_index = randi(3);
        first_index = randi(9);
        last_index = randi([first_index+1 10]);
        disp(indiv_index)
        disp(chromosome_index)
        disp(first_index)
        disp(last_index)
        if indiv_index == 1
            chromosome = individual_1(chromosome_index);
            slice = chromosome{1}(first_index:last_index);
            chromosome{1}(first_index:last_index) = flip(slice);
            individual_1(chromosome_index) = chromosome;
        else
            chromosome = individual_2(chromosome_index);
            slice = chromosome{1}(first_index:last_index);
            chromosome{1}(first_index:last_index) = flip(slice);
            individual_2(chromosome_index) = chromosome;
        end
    end
end
