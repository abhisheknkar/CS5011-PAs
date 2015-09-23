% Ridge Regression on the crime data
% Observed minimum at around lambda=2900
% lambdamat = 0:1000:100000;
lambdamat = 0:100:10000;
for n = 1:length(lambdamat)
    lambda = lambdamat(n);
    % Generate 5 folds of X and Y
    Xtrain = cell(5,1);
    Xtest = cell(5,1);
    Ytrain = cell(5,1);
    Ytest = cell(5,1);
    BETA = cell(5,1);
    % Random permutation:
    perm = randperm(size(X1,1));
    residue = zeros(5,1);

    for i = 1:5
        foldsize = round(size(X1,1)/5);
        foldind = perm((i-1)*foldsize+1:min(i*foldsize,size(X1,1)));
        Xtrain{i} = X1(setdiff(1:size(X1,1),foldind),:);
        Xtest{i} = X1(foldind,:);
        Ytrain{i} = Y1(setdiff(1:size(X1,1),foldind));
        Ytest{i} = Y1(foldind,:);

        BETA{i} = ridge(Ytrain{i}, Xtrain{i}, lambda);
%         residue(i) = norm(Ytest{i} - Xtest{i}*BETA{i})^2 / length(Ytest{i});
        residue(i) = norm(Ytest{i} - Xtest{i}*BETA{i})^2;

%   Perform the ridge regression for the fold      
    end
    disp(['Residue for lambda=' num2str(lambda) ' is ' num2str(mean(residue)) '.']);
end