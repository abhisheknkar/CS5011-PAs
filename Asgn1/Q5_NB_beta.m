function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB_beta( Xtrain, Ytrain, Xtest, Ytest, Alpha, Beta, mode)
    %% Construct likelihood vectors
    spam_occ = [];
    spam_li = [];
    ham_occ = [];
    ham_li = [];
    
    spam_indices = find(Ytrain == 0);
    ham_indices = find(Ytrain == 1);
    spam_total = sum(sum(Xtrain(spam_indices,:)));
    ham_total = sum(sum(Xtrain(ham_indices,:)));

    pi_ham = Alpha / (Alpha + Beta);
    pi_spam = 1 - pi_ham;

    ham_occ = sum(Xtrain(ham_indices,:));
    spam_occ = sum(Xtrain(spam_indices,:));
    
<<<<<<< HEAD
    ham_li = betarnd(ham_occ+Alpha,ham_total-ham_occ+Beta);
    spam_li = betarnd(spam_occ+Alpha,spam_total-spam_occ+Beta);
%     ham_li = (ham_occ + Alpha - 1)./(sum(ham_occ)+Alpha-1+Beta-1);
%     spam_li = (spam_occ + Beta - 1)./(sum(spam_occ)+Alpha-1+Beta-1);
=======
%     ham_li = betarnd(ham_occ+Alpha,ham_total-ham_occ+Beta);
%     spam_li = betarnd(spam_occ+Alpha, spam_total-spam_occ+Beta);
    ham_li = (ham_occ + Alpha )./(sum(ham_occ)+Alpha+Beta);
    spam_li = (spam_occ + Alpha )./(sum(spam_occ)+Alpha+Beta);

>>>>>>> 3202e664e070c0ad8da897699d6810058688a54d
    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2) + log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2) + log(pi_ham);
    Yhattest = double(P_ham > P_spam)';
    [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    

Pnorm = norm01(P_ham-P_spam);
[Xpr,Ypr,Tpr,AUCpr] = perfcurve(1-Ytest, 1-Pnorm, 1, 'xCrit', 'reca', 'yCrit', 'prec');
plot(Xpr,Ypr);
xlabel('Recall'); ylabel('Precision')
title(['PR curve for model ' mode ', spam class']);
print(['Q5Out/PR_' mode 'spam'],'-dpng');
end
