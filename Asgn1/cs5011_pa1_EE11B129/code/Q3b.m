%% Perform LDA
% Plotting left
linclass = fitcdiscr(Xtrain,Ytrain);
YhattestLDA = predict(linclass, Xtest);
[pr1x re1x f1x pr2x re2x f2x] = PR2class(Ytest, YhattestLDA, 1, 2)

X_cl1_LDA = Xtest(YhattestLDA==1,:);
X_cl2_LDA = Xtest(YhattestLDA==2,:);
% Y_cl1_LDA = YhattestLDA(YhattestLDA==1);
% Y_cl2_LDA = YhattestLDA(YhattestLDA==2);

figure(1);
scatter3(X_cl1_LDA(:,1),X_cl1_LDA(:,2),X_cl1_LDA(:,3),'b');hold on;
scatter3(X_cl2_LDA(:,1),X_cl2_LDA(:,2),X_cl2_LDA(:,3),'r');
title('DS3 classified using LDA');
xlabel('X');
ylabel('Y');
zlabel('Z');
legend('Class:1','Class:2');

save('Q3Out/statsLDA.mat', 'pr1x', 're1x', 'f1x', 'pr2x', 're2x', 'f2x');