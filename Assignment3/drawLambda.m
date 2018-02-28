function lambda = drawLambda(theta, t, tau)
    tDiff = t(2:end) - t(1:end-1);
    d = length(t) - 1;
    n = zeros(d, 1);
    for i = 1:d
        n(i) = sum(tau); %??
    end
    lambda = gamrnd(n + 2, theta+ tDiff);
end