% Test the performance of a kNN model
% k = 10 works the best
% Q1a
% Q1b
LRmisclass = wrongs;
% knnmisclass = [];
for k = 1:50
    [i k]
%     disp(['For k = ' num2str(k) ':']);
    mdl = fitcknn(Xtrain,Ytrain,'NumNeighbors',k);

    OUT2 = predict(mdl, Xtest);
    [wrongs MCE] = getMCE(Ytest, OUT2);
    knnmisclass(i,k) = wrongs;
end
if i == 50
cccend
toc