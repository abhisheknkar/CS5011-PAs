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
model = svmtrain(Xtrain, Ytrain);