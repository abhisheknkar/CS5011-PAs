% clc;clear all;close all;
tic
% mode = 'multinomial';
% mode = 'binomial';
mode = 'dirichlet';
% mode = 'beta';

% load(['Q5Out/Q5_multinomial' '.mat']);
% load(['Q5Out/Q5_binomial' '.mat']);
% disp('Data loaded!');
for iter = 1%:5
    iter
<<<<<<< HEAD
%     [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter});

% Dirichlet
%     alpha = 5*ones(1,size(Xtrain{iter},2));
%     [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_dirichlet( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha);
% % Beta
    alpha0 = 100;
    beta0 = 100;
    [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_beta( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha0,beta0);
end
[mean(pr1) mean(re1) mean(f1) mean(pr2) mean(re2) mean(f2)]
% save(['Q5Out/Q5Out_' mode '_' other '.mat'], 'pr1', 're1', 'f1', 'pr2', 're2', 'f2');
=======
    if strcmp(mode,'binomial') | strcmp(mode,'multinomial')
        [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, mode);
    elseif strcmp(mode, 'dirichlet')
        alpha = 50*ones(1,size(Xtrain{iter},2));
        [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_dirichlet( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha, mode);
    elseif strcmp(mode, 'beta')
        alpha0 = 100;
        beta0 = 100;
        [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_beta( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha0,beta0, mode);
    end
end
[alpha0 beta0 mean(pr1) mean(re1) mean(f1) mean(pr2) mean(re2) mean(f2)]'
% save(['Q5Out/Q5Out_' mode other '.mat'], 'pr1', 're1', 'f1', 'pr2', 're2', 'f2');
>>>>>>> 3202e664e070c0ad8da897699d6810058688a54d
toc