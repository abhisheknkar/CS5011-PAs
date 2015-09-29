clc;clear all;close all;
% The second feature is the best according to pca()
% Read: http://matlabdatamining.blogspot.in/2010/02/principal-components-analysis.html
% Q: What is the decision boundary?
Xtrain = csvread('data/DS3/train.csv');
Ytrain = csvread('data/DS3/train_labels.csv');
Xtest = csvread('data/DS3/test.csv');
Ytest = csvread('data/DS3/test_labels.csv');
% figure(1);scatter3(Xtrain(:,1),Xtrain(:,2),Xtrain(:,3));

%% Using the pca() approach
% XtrainCen = (Xtrain - repmat(mean(Xtrain,1), size(Xtrain,1), 1))./repmat(std(Xtrain,1), size(Xtrain,1), 1);
% [coeff,score,latent] = pca(XtrainCen);
% figure(2);scatter3(score(:,1),score(:,2),score(:,3));
[coeff,score,latent] = pca(Xtrain);
%% Using the first principles approach gives the same result when normalized
% covariancex = (XtrainCen'*XtrainCen)./(size(Xtrain,1)-1);                 
% [V D] = eigs(covariancex,3);
% Xtrain1D = XtrainCen*V;
% figure(2);scatter3(Xtrain1D(:,1),Xtrain1D(:,2),Xtrain1D(:,3));

%% Feature extracted
% (?) Empirically, it makes sense to extract y as the feature

Xtrain1D = score(:,1);
BETA = Xtrain1D\Ytrain;
% scatter(Xtrain1D,Ytrain);

%% Testing

% XtestCen = (Xtest - repmat(mean(Xtest,1), size(Xtest,1), 1))./repmat(std(Xtest,1), size(Xtest,1), 1);
% [coeff2,score2,latent2] = pca(XtestCen);
[coeff2,score2,latent2] = pca(Xtest);
Xtest1D = score2(:,1);
% scatter(Xtest1D,Ytest);
YhattestLR(BETA*Xtest1D<=0) = 1;
YhattestLR(BETA*Xtest1D>0) = 2;

[pr1 re1 f1 pr2 re2 f2] = PR2class(Ytest, YhattestLR, 1, 2);