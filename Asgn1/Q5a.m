% Maximum Likelihood Estimation assuming likelihood L ? Multinomial

%% Read all files in a folder, add to train / test set
clc;clear all; close all;
tic
trainfolders = 1:8;
testfolders = setdiff(1:10, trainfolders);

totrain = 0;

if totrain
    % Get train features
    Xtrain_ham = containers.Map;
    Xtrain_spam = containers.Map;
%     Xtest_ham = containers.Map;
%     Xtest_spam = containers.Map;
    
    spam_count = 0;
    ham_count = 0;
    for i = 1:10
        i
        foldername = ['data/Q10/part' num2str(i) '/'];
        files = dir([foldername '*.txt']);
        trainortest = sum(ismember(trainfolders,i)) > 0; %1 if train, 0 if test
        for j = 1:size(files,1)
            isspam = ~isempty(strfind(files(j).name,'spm'));
            if isspam & trainortest
                Xtrain_spam = updateXfrommail(Xtrain_spam, [foldername files(j).name], 1, 'multinomial');
                spam_count = spam_count + isspam;
            elseif ~isspam & trainortest
                Xtrain_ham = updateXfrommail(Xtrain_ham, [foldername files(j).name],  1, 'multinomial');
                ham_count = ham_count + (1-isspam);
%             elseif isspam & ~trainortest
%                 Xtest_spam = updateXfrommail(Xtest_spam, [foldername files(j).name], 1);
%             else
%                 Xtest_ham = updateXfrommail(Xtest_ham, [foldername files(j).name], 1);
            end
        end
    end
    %% Construct likelihood matrix
    spam_li = containers.Map;
    ham_li = containers.Map;
    words_ham = sum(cell2mat(Xtrain_ham.values));
    words_spam = sum(cell2mat(Xtrain_spam.values));
    keys_ham = Xtrain_ham.keys;
    keys_spam = Xtrain_spam.keys;

    for i = 1:length(keys_ham)
        ham_li(keys_ham{i}) = (Xtrain_ham(keys_ham{i}) + 1) / (words_ham + length(Xtrain_ham));
    end
    for i = 1:length(keys_spam)
        spam_li(keys_spam{i}) = (Xtrain_spam(keys_spam{i}) + 1) / (words_spam + length(Xtrain_spam));
    end
    save('TRAIN_F1_Q5.mat', 'Xtrain_spam', 'Xtrain_ham', 'ham_count', 'spam_count', 'ham_li', 'spam_li', 'words_ham', 'words_spam');
else 
    load('TRAIN_F1_Q5.mat');
end

% Priors
pi_ham = ham_count / (ham_count + spam_count);
pi_spam = 1 - pi_ham;
P_ham = pi_ham; P_spam = pi_spam;

trainfolders = 1:8;
testfolders = setdiff(1:10, trainfolders);

test_map = containers.Map;
count = 1;
for i = testfolders
    foldername = ['data/Q10/part' num2str(i) '/'];
    files = dir([foldername '*.txt']);
    for j = 1:size(files,1)
        [i j]
        P_ham = log(pi_ham); P_spam = log(pi_spam);
        isspam = ~isempty(strfind(files(j).name,'spm'));
        Ytest(count) = ~isspam;  %True value
        [~,words] = updateXfrommail(test_map, [foldername files(j).name], 0, 'multinomial');
        for k = 1:length(words)
            if spam_li.isKey(words{k})
                P_spam = P_spam + log(spam_li(words{k}));
            else 
                P_spam = P_spam + log(1 / (words_spam + length(Xtrain_spam)));
            end
            if ham_li.isKey(words{k})
                P_ham = P_ham + log(ham_li(words{k}));
            else 
                P_ham = P_ham + log(1 / (words_ham + length(Xtrain_ham)));
            end
%             [mult_ham mult_spam]
        end
        Yhattest(count) = P_ham > P_spam;
        count = count + 1;
    end
end
[ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 )
conf_mat = confusionmat(Ytest, Yhattest);
toc