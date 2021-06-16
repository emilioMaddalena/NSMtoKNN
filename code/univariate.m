% Supplementary material for the paper 'NSM Converges to a k-NN Regressor 
% Under Loose Lipschitz Estimates' by E. T. Maddalena and C. N. Jones

% Univariate example
clear all; clc
close all
rng(3); 

% Ground-truth
f = @(x) cos(x); % L^star is 1

xmin = 0; xmax = 2*pi;
X = xmin:xmax/800:xmax;

nSamples = 12;
indexes = randi(801,nSamples,1);
x = X(indexes);
fx = f(x);

figure(1); hold on; grid on
plot(X,f(X),'--k','LineWidth',2);

% NN model
for i = 1:(numel(X)) 
    point = X(i);
    point = repmat(point,1,nSamples);
    nor = abs(point - x);
    index = find(nor == min(nor));
    Vor(i) = index(1);
    NN(i) = fx(Vor(i));
end
NN = reshape(NN,size(X,1),size(X,2));

% Using a set of Lipschitz estimates
for Lf = 1:0.5:4

    % ceiling and floor
    for i = 1:nSamples
        H{i} = fx(i) + Lf*abs((x(i)'-X(:)')');
        L{i} = fx(i) - Lf*abs((x(i)'-X(:)')');
    end
    Htemp = [];
    Ltemp = [];
    for i = 1:nSamples
        Htemp = [Htemp; H{i}'];
        Ltemp = [Ltemp; L{i}'];
    end
    Ceiling = min(Htemp); Floor = max(Ltemp);
    Ceiling = reshape(Ceiling,size(X,1),size(X,2));
    Floor = reshape(Floor,size(X,1),size(X,2));

    % nominal model
    NSM = .5*(Ceiling+Floor);
    NSM = reshape(NSM,size(X,1),size(X,2));

    figure(1); hold on; grid on
    title('Ground-truth, samples, and several NSM models')
    plot(X,NSM,'-','LineWidth',2);
    plot(x,fx,'o','MarkerSize',8,'LineWidth',3,'MarkerFaceColor', 'r','MarkerEdgeColor', 'w'); axis('tight')
    
    % OBS. Note that all peaks coincide
    figure(2); hold on; grid on
    title('abs(NSM - NN) and sample locations')
    plot(X,abs(NSM-NN),'-','LineWidth',2);
    plot(x,zeros(nSamples,1),'o','MarkerSize',8,'LineWidth',3,'MarkerFaceColor', 'r','MarkerEdgeColor', 'w'); axis('tight')
    
end

% EOF
