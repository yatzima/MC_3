function ft = f(lambda, t, n)
exponent = 0;
d = length(t);
tdiff = zeros(d, 1);
for l = 1:d-1
    tdiff(l) = t(l+1) - t(l);
    exponent = exponent + lambda(l)*(t(l+1) -t(l));
end

ft = -exponent + sum(log(lambda.^n)) + sum(log(tdiff));

