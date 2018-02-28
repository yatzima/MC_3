%Number of disasters
load('coal_mine_disasters.mat')
n = length(T);
plot(T, 1:751)

%Gibbs sampling
samples = 2e4;
burn_in = 4e3;
rho = ones(d-1, 1);
psi = 2;
tau = T;

%Defining start and end points
t1 = 1658;
td1 = 1980;

%Initiate random t
d = 4; 
t = [t1 1700, 1801, 1850, td1];

theta = gamrnd(2, psi);
lambda = gamrn(2, theta, 1, d);

thetaAll = zeros(samples, 1);
lambdaAll = zeros(samples, d);
allt = zeros(samples, d + 1);

for i = 1:burn_in
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, tau);
    [t, accepted] = drawt(lambda, t, tau, rho)
end

for i = 1:samples
    
    
    %draw theta
    d = length(lambda);
    theta(i) = gamrnd(2*d + 2, psi + sum(lambda));
    
    n = cumsum(t <= tau);
%    n = zeros(length(t) - 1, 1);
%    for j = 1:(length(t)-1)
%        n(j) = sum(t(j) <= tau) & (tau < (j+1));
%    end
    
    %draw lambda
    tDiff = t(2:end) - t(1:end-1);
    lambda(i) = gamrnd(1, 2, tDiff+theta);
    
end