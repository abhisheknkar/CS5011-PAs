%% Read all files in a folder, add to train / test set
trainfolders = 1;
testfolders = setdiff(1, trainfolders);

% Get train features
Xtrain_ham = containers.Map;
Xtrain_spam = containers.Map;
Xtest_ham = containers.Map;
Xtest_spam = containers.Map;

for i = 1
    foldername = ['data/Q10/part' num2str(i) '/'];
    files = dir([foldername '*.txt']);
    trainortest = sum(ismember(trainfolders,i)) > 0; %1 if train, 0 if test
    for j = 1:size(files,1)
        [i j]
%         if ~exist([foldername files(j).name])
%             [i j]
%         end
        isspam = isempty(strfind(files(j).name,'spm'));
        
        if isspam & trainortest
            Xtrain_spam = updateXfrommail(Xtrain_spam, [foldername files(j).name]);
        elseif ~isspam & trainortest
            Xtrain_spam = updateXfrommail(Xtrain_ham, [foldername files(j).name]);
        elseif isspam & ~trainortest
            Xtest_spam = updateXfrommail(Xtest_spam, [foldername files(j).name]);
        else
            Xtest_spam = updateXfrommail(Xtest_ham, [foldername files(j).name]);
        end
    end
end
