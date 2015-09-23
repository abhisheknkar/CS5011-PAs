%% Perform LDA
% Plotting left
linclass = fitcdiscr(Xtrain,Ytrain);
YhattestLDA = predict(linclass, Xtest);
[pr1x re1x f1x pr2x re1x f1x] = PR2class(Ytest, YhattestLDA, 1, 2);