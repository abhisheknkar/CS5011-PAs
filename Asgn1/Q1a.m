% Generation of DS1
% Class 1 has mean of all features as 0
% Class 2 has mean of all features as 1
clc;clear all; close all;

%% Generation of the data
tic
Smat = [1e0,1e-1];
class = [0,1];
MU1 = zeros(1,10);
% S1d = 1e-1;
S1d = Smat(1);
SIGMA1 = S1d * eye(10);
% S1nd = 1e-2;
S1nd = Smat(2);
SIGMA1 = SIGMA1 - S1nd * eye(10) + S1nd * ones(10,10);
MVRV1 = mvnrnd(MU1,SIGMA1,1000);

MU2 = ones(1,10);
% S2d = 1e-1;
S2d = Smat(1);
SIGMA2 = S2d * eye(10);
% S2nd = 1e-2;
S2nd = Smat(2);
SIGMA2 = SIGMA2 - S2nd * eye(10) + S2nd * ones(10,10);
MVRV2 = mvnrnd(MU2,SIGMA2,1000);

TEST1idx = randperm(1000); TEST1idx = TEST1idx(1:400);
TEST1ftrs = MVRV1(TEST1idx,:);
TRAIN1ftrs = MVRV1(setdiff([1:1000],TEST1idx),:);
TEST2idx = randperm(1000); TEST2idx = TEST2idx(1:400);
TEST2ftrs = MVRV2(TEST2idx,:);
TRAIN2ftrs = MVRV2(setdiff([1:1000],TEST2idx),:);

Q1b
toc