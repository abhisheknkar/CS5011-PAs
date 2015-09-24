clc;clear all;close all;
addpath ../libsvm-3.20/libsvm-3.20/matlab
% Multi-class 1 vs all: http://stackoverflow.com/questions/9041753/multi-class-classification-in-libsvm

%% Read data
totrain = 0;
types = {'coast', 'forest', 'insidecity', 'mountain'};
bins = 32;
Xtrain = [];
Ytrain = [];

if totrain == 1
    for i = 1:4
        datafolder = ['data/DS4/data_students/' types{i} '/Train/'];
        files = dir([datafolder '*.jpg']);
        for j = 1:size(files,1)
            features = [];
            [i j]
            I = imread([datafolder files(j).name]);
            for k = 1:3
                layer = I(:,:,k);
                lhist = imhist(layer,bins);
                features = [features lhist'];
            end
            Xtrain = [Xtrain;features];
            Ytrain = [Ytrain;i];
        end
    end
    save('Q4train.mat', 'Xtrain', 'Ytrain');
else
    load('Q4train.mat');
end

%% Train classifier
% model = svmtrain(Xtrain, Ytrain);
[Xtrainf Ytrainf Xtestf Ytestf] = generateKfolds(Xtrain, Ytrain, 5, 1);
numTest = size(Xtestf,1);
numLabels = 4;
acc = zeros(5,1);
C = cell(5,1);
model = cell(numLabels,1);
for i = 1:5
    for k=1:numLabels
%         model{k} = svmtrain(Xtrainf{i}, double(Ytrainf{i}==k));
        model{k} = svmtrain(Xtrainf{i}, double(Ytrainf{i}==k), '-s 0 -t 0 -g 0.2 -c 1 -b 1');
    end
    prob = zeros(numTest,numLabels);
    for k=1:numLabels
        [~,~,p] = svmpredict(Ytestf{i}==k, Xtestf{i}, model{k}, '-b 1');
        prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
    end

    %# predict the class with the highest probability
    [~,pred] = max(prob,[],2);
    acc(i) = sum(pred == Ytestf{i}) ./ numel(Ytestf{i})    %# accuracy
    C{i} = confusionmat(Ytestf{i}, pred)                   %# confusion matrix    
end


