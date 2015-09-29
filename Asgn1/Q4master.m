%% Train classifier and Evaluate
% Polynomial kernel:

clc;clear all;close all;
tic
addpath ../libsvm-3.20/libsvm-3.20/matlab
load('Q4Out/Q4folds.mat');
kernel = '0';
if exist(['Q4Out/out_kernel_' kernel '.mat'])
    load(['Q4Out/out_kernel_' kernel '.mat']);
else
    perf = [];
end

% Vary C and g
folds = size(Xtrainf,1);
acc = zeros(folds,3);
Yhattest = cell(folds,1);
C = cell(folds,1);
model = cell(folds,1);
prob = cell(folds,1);

cvals = 1.55;
gvals = 0.015;
% cvals = 2.^[-6:-3];
% gvals = 2.^[-6:-3];

for cc = 1:length(cvals)
    cval = cvals(cc);
    for gg = 1:length(gvals)
        gval = gvals(gg);
        [cval gval]
        for i = 1:folds
            Xtrainf{i} = stdnormalize(Xtrainf{i});
            Xtestf{i} = stdnormalize(Xtestf{i});
            
            model{i} = svmtrain(Ytrainf{i}, Xtrainf{i}, ['-s 0 -t ' kernel ' -g ' num2str(gval) ' -c ' num2str(cval) ' -b 1']);
            prob{i} = zeros(size(Xtestf{i},1),4);

            [Yhattest{i},acc(i,:),prob{i}] = svmpredict(Ytestf{i}, Xtestf{i}, model{i}, '-b 1');
        end
        perf = [perf;[cval,gval,mean(acc,1)]];
%         foutname = ['Q4gridout/c=10^' num2str(log(cval)/log(10)) ';g=10^' num2str(log(gval)/log(10)) '.mat']
    end
toc    
end
foutname = ['Q4Out/out_kernel_' kernel '.mat'];
% save(foutname, 'perf');