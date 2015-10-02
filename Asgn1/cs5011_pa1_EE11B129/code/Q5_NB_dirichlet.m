function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB_dirichlet( Xtrain, Ytrain, Xtest, Ytest, alpha, mode)
    %% Construct likelihood vectors
    spam_occ = [];
    spam_li = [];
    ham_occ = [];
    ham_li = [];
    
    spam_indices = find(Ytrain == 0);
    ham_indices = find(Ytrain == 1);
    spam_total = sum(sum(Xtrain(spam_indices,:)));
    ham_total = sum(sum(Xtrain(ham_indices,:)));

    ham_occ = sum(Xtrain(ham_indices,:));
    spam_occ = sum(Xtrain(spam_indices,:));
    
    ham_li = (ham_occ + alpha)./sum(ham_occ+alpha);
    spam_li = (spam_occ + alpha)./sum(spam_occ+alpha);
    
    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2);% + log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2);% + log(pi_ham);
    Yhattest = double(P_ham > P_spam)';
    [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    
% [Xpr,Ypr,Tpr,AUCpr] = perfcurve(Ytest, Pnorm, 1, 'xCrit', 'reca', 'yCrit', 'prec');
% plot(Xpr,Ypr);
% xlabel('Recall'); ylabel('Precision')
% title('PR curve for model');
Pnorm = norm01(P_ham-P_spam);
[Xpr,Ypr,Tpr,AUCpr] = perfcurve(1-Ytest, 1-Pnorm, 1, 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr);
xlabel('Recall'); ylabel('Precision')
title(['PR curve for model ' mode ', spam class']);
print(['Q5Out/PR_' mode 'spam'],'-dpng');

end

