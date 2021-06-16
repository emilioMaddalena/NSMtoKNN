% Supplementary material for the paper 'NSM Converges to a k-NN Regressor 
% Under Loose Lipschitz Estimates' by E. T. Maddalena and C. N. Jones

% Bivariate example
clear all; clc
close all
rng(2); 

% Ground-truth
f = @(x1,x2) cos(x1) + sin(x2); % L^star is sqrt(2) for the 2-norm

% Acquiring samples
nSamples = 30;
x1 = 10.*rand(1,nSamples);
x2 = 10.*rand(1,nSamples);
z = f(x1,x2);

[X1,X2] = meshgrid(0:0.05:10,0:0.05:10);
sz = size(X1,1);

% NN regressor 
for i = 1:numel(X1)
    point = [X1(i); X2(i)];
    point = repmat(point,1,nSamples);
    nor = vecnorm(point - [x1; x2],2);
    minVal = min(nor);
    index = find(nor == minVal);
    Vor(i) = index(1);
    NN(i) = z(index(1));
end
NN = reshape(NN,sz,sz);

% Using different Lipschitz estimates
k = 1; errorInteg = [];
for Lf = 2:30

    for i = 1:nSamples
        H{i} = z(i) + Lf*vecnorm(([x1(i) x2(i)]'-[X1(:) X2(:)]'),2);
        L{i} = z(i) - Lf*vecnorm(([x1(i) x2(i)]'-[X1(:) X2(:)]'),2);
    end
    Htemp = []; Ltemp = [];
    for i = 1:nSamples
        Htemp = [Htemp; H{i}];
        Ltemp = [Ltemp; L{i}];
    end

    Ceiling = min(Htemp); Ceiling = reshape(Ceiling,sz,sz);
    Floor = max(Ltemp); Floor = reshape(Floor,sz,sz);
    NSM = .5*(Ceiling+Floor); NSM = reshape(NSM,sz,sz);

    E = NN - NSM;

    % Only plot these 3 cases
    if Lf == 2 || Lf == 4 || Lf == 16
        
        figure(1)
        subplot(2,3,k)
        surf(X1,X2,NSM,'EdgeColor','none');
        xticks([0 5 10]); yticks([0 5 10]); zticks([0 5 10]); hold on
        for i = 1:nSamples
            plot3(x1(i),x2(i),5,'ow','MarkerSize',5);
            hold on
        end
        view(2)

        figure(1)
        subplot(2,3,k+3)
        surf(X1,X2,E.^2,'EdgeColor','none'); 
        xticks([0 5 10]); yticks([0 5 10]); zticks([0 5 10]); hold on
        for i = 1:nSamples
            plot3(x1(i),x2(i),10,'ow','MarkerSize',5);
            hold on
        end
        view(2)
        
        k = k + 1;
    end
    
end

% A view of the Ceiling and Floor functions
figure(2)
title('Ceiling and Floor functions')
pl1 = surf(X1,X2,Ceiling); hold on
set(pl1,'LineStyle','none','FaceAlpha',0.9);
pl2 = surf(X1,X2,Floor);
set(pl2,'LineStyle','none','FaceAlpha',0.9);
plot3(x1,x2,z,'o','MarkerSize',8,'MarkerFaceColor','w','MarkerEdgeColor','w');
light; lighting gouraud

% EOF