clc;clear all;close all;

%% Load data
logistic = 1;
l1logistic = 0;
normalize = 1;
load('Q4/Q4traindata.mat');
load('Q4/Q4testdata.mat');

%% Normalize
if normalize
    Xtrain = stdnormalize(Xtrain);
    Xtest = stdnormalize(Xtest);
end

%% Logistic Regression
if logistic
    [B,dev,stats] = mnrfit(Xtrain,Ytrain);
end

%% L1-Logistic Regression
if l1logistic
    %% Write model to file
    mmwrite('Q4/Xtrain.mm',Xtrain);
    mmwrite('Q4/Ytrain.mm',Ytrain);

    mmwrite('Q4/Xtest.mm',Xtest);
    mmwrite('Q4/Ytest.mm',Ytest);

    %% Train model
    system('./l1_logreg_train -s Q4/Xtrain.mm Q4/Ytrain.mm  0.01 Q4/modelf01.mm'); 
    % model_logreg = mmread('Q4/model.mm');

    system('./l1_logreg_classify Q4/model.mm Q4/Xtest.mm Q4/Ypred.mm'); 
end