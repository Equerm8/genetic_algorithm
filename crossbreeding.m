function [out1, out2] = crossbreeding(str1, str2, halfIndex)

    part1_1 = extractBefore(str1(1), halfIndex + 1);
    part2_1 = extractAfter(str1(1), halfIndex);
    part1_2 = extractBefore(str2(1), halfIndex + 1);
    part2_2 = extractAfter(str2(1), halfIndex);

    out1 = part1_1 + part2_2;
    out2 = part1_2 + part2_1;
end