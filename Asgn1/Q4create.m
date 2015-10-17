clc;clear all;close all;
tic
addpath ../libsvm-3.20/libsvm-3.20/matlab
% Multi-class 1 vs all: http://stackoverflow.com/questions/9041753/multi-class-classification-in-libsvm

%% Read data
totrain = 0;
folds = 5;
types = {'coast', 'forest', 'insidecity', 'mountain'};
bins = 32;
Xtrain = [];
Ytrain = [];
Xtest = [];
Ytest = [];

trainsave = 1;
testsave = 0;

if trainsave
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
    save('Q4Out/Q4traindata.mat', 'Xtrain', 'Ytrain');

    [Xtrainf Ytrainf Xtestf Ytestf] = generateKfolds(Xtrain, Ytrain, folds, 1);
    save('Q4Out/Q4folds.mat', 'Xtrainf', 'Ytrainf', 'Xtestf', 'Ytestf');
end

if testsave
    for i = 1:4
        datafolder = ['data/DS4/data_students/' types{i} '/Test/'];
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
            Xtest = [Xtest;features];
            Ytest = [Ytest;i];
        end
    end
    save('Q4Out/Q4testdata.mat', 'Xtest', 'Ytest');
end
toc