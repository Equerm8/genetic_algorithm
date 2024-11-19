function [Kp2, Ti2, Td2] = dec2binFunc(Kp, Ti, Td, mult)
    Kp = Kp * mult;
    Ti = Ti * mult;
    Td = Td * mult;

    Kp2 = dec2bin(Kp, 10);
    Ti2 = dec2bin(Ti, 10);
    Td2 = dec2bin(Td, 10);
end