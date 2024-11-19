%% Cost function based on lecture

function J = costFunc(O, G, criterion)
    % Controller
    Kp = O(1);
    Ti = O(2);
    Td = O(3);
    s = tf('s');
    C = Kp * (1 + Ti * 1/s + Td*s);
    Go = C*G;
    Gc = Go / (1 + Go);
    
    % time-domain performance criterion
    if criterion == 1
        S = stepinfo(Gc); 
        J = 0.3*S.RiseTime + 0.3*S.Overshoot + 0.4*S.SettlingTime;
        if (isnan(J)) || J == Inf
            J = 2e12;
        end

    elseif criterion == 2
         % integral criterion
        Ts = 0.1;
        t = 0 : Ts : 100;
        r = heaviside(t);
        y = lsim(Gc, r, t);
    
        e = r' - y;
        J = Ts * sum(abs(e));
    end
end

