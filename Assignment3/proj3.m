%Number of disasters
load('coal_mine_disasters.mat')
n = length(T);
plot(T, 1:751)

%Gibbs sampling
samples = 2e4;
burn_in = 4e3;
d = 3; 

rho = 0.5*ones(d,1);
psi = 2;
tau = T;

%Defining start and end points
t1 = 1658;
td1 = 1980;

%Initiate random t
t = [t1 1700, 1801, 1850, td1];

theta = gamrnd(2, psi);
lambda = gamrnd(2, theta, 1, d);

thetaAll = zeros(samples, 1);
lambdaAll = zeros(samples, d);
allt = zeros(samples, d + 1);

for i = 1:burn_in
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, tau);
    [t, accepted] = drawt(lambda, t, tau, rho);
end

NTrials = 0;
NAccepted = zeros(1,d-1);

for i = 1:samples
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, T);
    [t, accepted] = drawt(lambda, t, T, rho);
    NTrials = NTrials + 1;
    NAccepted = NAccepted + accepted;
    allTheta(i, :) = theta;
    allLambda(i, :) = lambda;
    allt(i, :) = t;
end