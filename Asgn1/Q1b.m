%% Training the linear classifier
Xtrain = [TRAIN1ftrs;TRAIN2ftrs];
Ytrain = [class(1)*ones(600,1);class(2)*ones(600,1)];
BETA = Xtrain\Ytrain;
% plot(Xtrain*BETA)

%% Best fit for linear classifier
Xtest = [TEST1ftrs;TEST2ftrs];
Ytest = [class(1)*ones(400,1);class(2)*ones(400,1)];
OUT1a = Xtest*BETA;
% RMSE = norm(Ytest - OUT) / 800;

%% Misclassification error
OUT1b = OUT1a;
OUT1b(OUT1b <= mean(class)) = class(1);
OUT1b(OUT1b > mean(class)) = class(2);

% figure, plot(Xtest*BETA); hold on;
% plot(OUThat,'r');
getMCE(Ytest, OUT1b);