clc;clear all;close all;
% The second feature is the best according to pca()


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
Yhattest(Xtest1D<=1.5) = 1;
Yhattest(Xtest1D>1.5) = 2;

%% Precision, Recall
P = find(Yhattest == 1);
TP = intersect(P, find(Ytest==1));
FP = setdiff(P,TP);

N = find(Yhattest == 2);
TN = intersect(N, find(Ytest==2));
FN = setdiff(P,TP);

pr1 = length(TP)/length(P)
re1 = length(TP)/(length(TP)+length(FN))
pr2 = length(TN)/length(N)
re2 = length(FP)/(length(FP)+length(TN))