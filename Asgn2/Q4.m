clc;clear all;close all;

%% Load data
prc = 6;
lambda = 0.013;
% pairs = [1,2;1,3;1,4;2,3;2,4;3,4];
pairs = [1,2;1,3;1,4;2,3;2,4;3,4;2,1;3,1;4,1;3,2;4,2;4,3];
logistic = 0;
l1logistic = 1;
normalize = 1;
savefolds = 0;
load('Q4/Q4traindata.mat');
load('Q4/Q4testdata.mat');

%% Normalize
if normalize
    Xtrain = stdnormalize(Xtrain);
    Xtest = stdnormalize(Xtest);
end
mmwrite('Q4/Xtest.mm',Xtest);
mmwrite('Q4/Ytest.mm',Ytest);
Ytest1v1 = zeros(size(Ytest,1),4);
%% Create one-vs-one vectors, prc of them
if savefolds
    Xtrain1v1 = cell(prc,1);
    Ytrain1v1 = cell(prc,1);
    for i = 1:prc
        disp(['Saving fold ' num2str(i)]);
        indices = [find(Ytrain==pairs(i,1));find(Ytrain==pairs(i,2))];
        Xtrain1v1{i} = Xtrain(indices,:);
        Ytrain1v1{i} = (Ytrain(indices)==pairs(i,1))*2-1; %+1,-1 mapping

        % Write model to file
        Xtrainfile = ['Q4/Xtrain' num2str(i) '.mm'];
        Ytrainfile = ['Q4/Ytrain' num2str(i) '.mm'];
        mmwrite(Xtrainfile,Xtrain1v1{i});
        mmwrite(Ytrainfile,Ytrain1v1{i});
    end
end    
%% Train models and classify
for i = 1:prc
    disp(['Classifying fold ' num2str(i)]);
    Xtrainfile = ['Q4/Xtrain' num2str(i) '.mm'];
    Ytrainfile = ['Q4/Ytrain' num2str(i) '.mm'];
    % Logistic Regression
    %     [B,dev,stats] = mnrfit(Xtrain,Ytrain);
    if logistic
        system(['./l1_logreg_train -s ' Xtrainfile ' ' Ytrainfile ' 0 Q4/model' num2str(i) '.mm']); 
        system(['./l1_logreg_classify Q4/model' num2str(i) '.mm Q4/Xtest.mm Q4/Ypred' num2str(i) '.mm']); 
    end

    % L1-Logistic Regression
    if l1logistic
        system(['./l1_logreg_train -s ' Xtrainfile ' ' Ytrainfile ' ' num2str(lambda) ' Q4/modelLog' num2str(i) '.mm']); 
        system(['./l1_logreg_classify Q4/modelLog' num2str(i) '.mm Q4/Xtest.mm Q4/YpredLog' num2str(i) '.mm']); 
    end
end

%% Performance computation
for i = 1:prc
    if logistic
        ypred = mmread(['Q4/Ypred' num2str(i) '.mm']);
    end
    if l1logistic
        ypred = mmread(['Q4/YpredLog' num2str(i) '.mm']);
    end
    plus1 = find(ypred == 1);
    minus1 = find(ypred == -1);
    for j = 1:length(plus1)
        Ytest1v1(plus1(j),pairs(i,1)) = Ytest1v1(plus1(j),pairs(i,1)) + 1;
    end
    for j = 1:length(minus1)
        Ytest1v1(minus1(j),pairs(i,2)) = Ytest1v1(minus1(j),pairs(i,2)) + 1;
    end
end
[ymax Ypred] = max(Ytest1v1,[],2);
cm = confusionmat(Ytest, Ypred)
disp(['Corrects: ' num2str(sum(diag(cm)))]);
prf = getPRF(cm)