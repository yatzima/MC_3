%Defining start and end points
t1 = 1658;
td1 = 1980;

%Defining the length of the data set
a = 1;
d = (td1 - t1)*a;
s =(td1 - t1)/d;

%Number of disasters
load('coal_mine_disasters.mat')
n = length(T);
plot(T, 1:751)

%Gamma(2, theta)-hyperprior on theta
psi = 1;
%theta = gampdf(1,2,psi + sum(lambda));
%Gamma(2, theta)-prior on the intensitetes/lambda
%lambda = gampdf(1,2,theta);

%Gibbs sampling
N = 1e4;
rho = 1;
theta = zeros(N, 1);
lambda = 0.1*ones(N,1);
tau = T;

%Initiate random t
d = 4;
t = [1700, 1801, 1850, 1900];

for i = 1:N
    
    %Metropolis-Hasting algorithm
    X = zeros(N, 1);
    X(1) = rand(1);
    
    for k = 2:d-1
        R = rho*(t(k+1)-t(k-1));
        tstar =  t - R + (2*R)*rand(d, 1);
        
        alpha = min(1, f(lambda, tstar, n)/f(lambda, t, n));
        U = rand(1);
        if U <= alpha
            X(k) = 0;
        else
            X(k) = 0;
        end
    end
    
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

tau = mean(X);

