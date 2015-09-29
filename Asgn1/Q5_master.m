clc;clear all;close all;
tic
% mode = 'multinomial';
mode = 'binomial';
load(['Q5_' mode '.mat']);
disp('Data loaded!');

for iter = 1:5
    iter
    [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter});
end
toc