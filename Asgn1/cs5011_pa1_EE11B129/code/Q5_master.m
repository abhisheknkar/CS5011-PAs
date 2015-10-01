% clc;clear all;close all;
tic
mode = 'multinomial';
% other = 'dir';
other = 'beta';
% other='';
% mode = 'binomial';
% load(['Q5Out/Q5_' mode '.mat']);
% disp('Data loaded!');

for iter = 1:5
    iter
    [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter});

% Dirichlet
%     alpha = 5*ones(1,size(Xtrain{iter},2));
%     [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_dirichlet( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha);
% % Beta
    alpha0 = 1;
    beta0 = 1;
    [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB_beta( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter}, alpha0,beta0);
end
[mean(pr1) mean(re1) mean(f1) mean(pr2) mean(re2) mean(f2)]
save(['Q5Out/Q5Out_' mode '_' other '.mat'], 'pr1', 're1', 'f1', 'pr2', 're2', 'f2');
toc