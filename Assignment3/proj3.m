%Defining start and end points
t1 = 1658;
td1 = 1980;

%Defining the length of the data set
a = 1;
d = (td1 - t1)*a;
s =(td1 - t1)/d;

%Defining the vector t
t = 1658:s:1980;

%Number of disasters
load('coal_mine_disasters.mat')
n = length(T);
plot(T, 1:751)
lambda = 0.1*ones(d,1);

%Gamma(2, theta)-hyperprior on theta
psi = 1;
theta = gampdf(1,2,psi + sum(lambda));

%Gamma(2, theta)-prior on the intensitetes/lambda
lambda = gampdf(1:d,2,theta);

%Metropolis-Hasting algorithm
rho = 1;
N = 1e4;
X = zeros(N, 1);
X(1) = rand(1);

for k = 1:d-1
    R = rho*(t(k+1)-t(k-1));
    tstar =  t - R + (2*R)*rand(d, 1);
    alpha = min(1, 1);  
    U = rand(1);
    if U <= alpha
        X(k) = 0;
    else
        X(k) = 0;
    end
end

tau = mean(X);

%Gibbs sampling
