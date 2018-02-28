function [t, accepted] = drawt(lambda, t, tau, rho)
    d = length(t) - 1;
    accepted = zeros(1,d-1);
    
    %Metropolis-Hasting algorithm
    for i = 2:d
        R = rho(i-1)*(t(i+1)-t(i-1));
        Xstar =  t(i) - R + (2*R)*rand(d, 1);
        
        alpha = min(1, f(lambda, Xstar, n)/f(lambda, t, n));
        U = rand(1);
        if U <= alpha
            X(i+1) = Xstar;
        else
            X(i+1) = X(i);
        end
    end
end