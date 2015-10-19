function [ prf ] = getPRF( X )
%Get per class precision, recall, F-measure
    prf = zeros(size(X,1),3);
    for i = 1:size(X,1)
        prf(i,1) = X(i,i) / sum(X(:,i));
        prf(i,2) = X(i,i) / sum(X(i,:));
        prf(i,3) = 2*prf(i,1)*prf(i,2)/(prf(i,1)+prf(i,2));
    end
end

