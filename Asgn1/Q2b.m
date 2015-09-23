% Linear Regression on the crime data
BETA1 = X1\Y1;
% RMSE = norm(Y1 - X1*BETA1)^2 / length(Y1)
RMSE = norm(Y1 - X1*BETA1)^2

% figure, plot(Y1), hold on, plot(X1*BETA1, 'r');
