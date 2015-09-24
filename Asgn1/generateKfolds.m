function [ Xtrain, Ytrain, Xtest, Ytest ] = generateKfolds( X, Y, k, tonormalize)
% 
    Xtrain = cell(k,1);
    Xtest = cell(k,1);
    Ytrain = cell(k,1);
    Ytest = cell(k,1);
    perm = randperm(size(X,1));
    for i = 1:k
        foldsize = round(size(X,1)/5);
        foldind = perm((i-1)*foldsize+1:min(i*foldsize,size(X,1)));
        Xtrain{i} = X(setdiff(1:size(X,1),foldind),:);
        Xtest{i} = X(foldind,:);
        Ytrain{i} = Y(setdiff(1:size(X,1),foldind));
        Ytest{i} = Y(foldind,:);
        
        if tonormalize == 1
            [Xtrain{i} mu1 sigma1] = stdnormalize(Xtrain{i});
%             [Ytrain{i} mu2 sigma2] = stdnormalize(Ytrain{i});
%             Xtest{i} = stdnormalize(Xtest{i});
%             Ytest{i} = stdnormalize(Ytest{i});
            Xtest{i} = ( Xtest{i} - repmat(mu1, size(Xtest{i},1),1) )./ repmat(sigma1, size(Xtest{i},1),1);
%             Ytest{i} = ( Ytest{i} - repmat(mu2, size(Ytest{i},1),1) )./ repmat(sigma2, size(Ytest{i},1),1);
        end
    end
end