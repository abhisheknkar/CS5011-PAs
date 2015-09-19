% Test the performance of a kNN model
% k = 10 works the best
for k = 1:20
    disp(['For k = ' num2str(k) ':']);
    mdl = fitcknn(Xtrain,Ytrain,'NumNeighbors',k);

    OUT2 = predict(mdl, Xtest);
    getMCE(Ytest, OUT2);
end