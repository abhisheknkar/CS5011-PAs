function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB_beta( Xtrain, Ytrain, Xtest, Ytest, Alpha, Beta)
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

    for k = 1:size(Xtrain,2)
        ham_occ(k) = (sum(Xtrain(ham_indices,k)) + 1) / (ham_total + size(Xtrain,2));
    end
    for k = 1:size(Xtrain,2)
        spam_occ(k) = (sum(Xtrain(spam_indices,k)) + 1) / (spam_total + size(Xtrain,2));
    end
    
    ham_li = betarnd(ham_occ+Alpha,ham_total-ham_occ+Beta);
    spam_li = betarnd(spam_occ+Alpha,spam_total-spam_occ+Beta);
%     ham_li = (ham_occ + Alpha - 1)./(sum(ham_occ)+Alpha-1+Beta-1);
%     spam_li = (spam_occ + Beta - 1)./(sum(spam_occ)+Alpha-1+Beta-1);
    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2) + log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2) + log(pi_ham);
    Yhattest = double(P_ham > P_spam)';
    [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    
end

