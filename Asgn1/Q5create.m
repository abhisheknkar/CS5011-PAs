% Create the dataset
clc;clear all; close all;
tic

Xtrain = cell(5,1);    
Ytrain = cell(5,1);
Xtest = cell(5,1);    
Ytest = cell(5,1);
for iter = 1:5
    testfolders = (2*iter-1):2*iter;
    trainfolders = setdiff(1:10, testfolders);

    mode = 'binomial';
    % Get train features

    for i = 1:10
        [iter i]
        foldername = ['data/Q10/part' num2str(i) '/'];
        files = dir([foldername '*.txt']);
        trainortest = sum(ismember(trainfolders,i)) > 0; %1 if train, 0 if test
        for j = 1:size(files,1)
            isspam = ~isempty(strfind(files(j).name,'spm'));

            if trainortest
                Xtrain{iter}(end+1,:) = getXfrommail([foldername files(j).name], 'multinomial');
                Ytrain{iter}(end+1)=double(~isspam);
            else
                Xtest{iter}(end+1,:) = getXfrommail([foldername files(j).name], 'multinomial');
                Ytest{iter}(end+1)=double(~isspam);;
            end
        end
    end
    save(['Q5Out/Q5_' mode '.mat'], 'Xtrain', 'Ytrain', 'Xtest', 'Ytest');
end
toc