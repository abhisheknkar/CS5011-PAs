% Ridge Regression on the crime data
% Observed minimum at around lambda=2900
% After normalizing, minimum occurs at around lambda = 130
% lambda=0 gives around the same residue as OLS regression
lambdamat = 0:10:200;
% Observed minimum at around lambda=3000
% lambdamat = 0:1000:20000;
% Generate 5 folds of X and Y
Xtrain = cell(5,1);
Xtest = cell(5,1);
Ytrain = cell(5,1);
Ytest = cell(5,1);
BETA_RR = cell(5,1);
BETA_LR = cell(5,1);
% Random permutation:
perm = randperm(size(X1,1));
residue_RR = zeros(5,1);
residue_LR = zeros(5,1);

for i = 1:5
    foldsize = round(size(X1,1)/5);
    foldind = perm((i-1)*foldsize+1:min(i*foldsize,size(X1,1)));
    Xtrain{i} = stdnormalize( X1(setdiff(1:size(X1,1),foldind),:));
    Xtest{i} = stdnormalize(X1(foldind,:));
    Ytrain{i} = stdnormalize(Y1(setdiff(1:size(X1,1),foldind)));
    Ytest{i} = stdnormalize(Y1(foldind,:));
end
for n = 1:length(lambdamat)
    lambda = lambdamat(n);
    for i = 1:5
        BETA_RR{i} = ridge(Ytrain{i}, Xtrain{i}, lambda);
        residue_RR(i) = norm(Ytest{i} - Xtest{i}*BETA_RR{i})^2;

        if n == 1
            BETA_LR{i} = Xtrain{i}\Ytrain{i};
            residue_LR(i) = norm(Ytest{i} - Xtest{i}*BETA_LR{i})^2;
        end
    end
%   Perform the ridge regression for the fold      
    disp(['Residue for lambda=' num2str(lambda) ' is ' num2str(mean(residue_RR)) '.']);
end
disp(['Residue for LR is ' num2str(mean(residue_LR)) '.']);
