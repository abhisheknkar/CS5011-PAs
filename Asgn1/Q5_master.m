clc;clear all;close all;
tic
mode = 'multinomial';
% mode = 'binomial';
load(['Q5Out/Q5_' mode '.mat']);
disp('Data loaded!');

for iter = 1:5
    iter
    [ pr1(iter), re1(iter), f1(iter), pr2(iter), re2(iter), f2(iter) ] = Q5_NB( Xtrain{iter}, Ytrain{iter}, Xtest{iter}, Ytest{iter});
end
save(['Q5Out/Q5Out_' mode '.mat'], 'pr1', 're1', 'f1', 'pr2', 're2', 'f2');
toc