function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB( Xtrain, Ytrain, Xtest, Ytest, mode)
    %% Construct likelihood vectors
    spam_li = [];
    ham_li = [];

    spam_indices = find(Ytrain == 0);
    ham_indices = find(Ytrain == 1);

    spam_count = length(spam_indices);
    ham_count = length(ham_indices);
    
    spam_total = sum(sum(Xtrain(spam_indices,:)));
    ham_total = sum(sum(Xtrain(ham_indices,:)));

    ham_li = (sum(Xtrain(ham_indices,:)) + 1) / (ham_total + size(Xtrain,2));
    spam_li = (sum(Xtrain(spam_indices,:)) + 1) / (spam_total + size(Xtrain,2));
    
    %% Construct the priors
    pi_ham = ham_count / (ham_count + spam_count);
    pi_spam = 1 - pi_ham;
%     P_ham = pi_ham; P_spam = pi_spam;

    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2); %+ log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2); %+ log(pi_ham);
    Yhattest = double(P_ham > P_spam)';

[ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    
%     conf_mat = confusionmat(Ytest, Yhattest);
Pnorm = norm01(P_ham-P_spam);
% [Xpr,Ypr,Tpr,AUCpr] = perfcurve(Ytest, Pnorm, 1, 'xCrit', 'reca', 'yCrit', 'prec');
% plot(Xpr,Ypr);
% xlabel('Recall'); ylabel('Precision')
% title(['PR curve for model ' mode ', ham class']);
% print(['Q5Out/PR_' mode 'ham'],'-dpng');
[Xpr,Ypr,Tpr,AUCpr] = perfcurve(1-Ytest, 1-Pnorm, 1, 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr);
xlabel('Recall'); ylabel('Precision')
title(['PR curve for model ' mode ', spam class']);
print(['Q5Out/PR_' mode 'spam'],'-dpng');
end