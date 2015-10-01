function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB_dirichlet( Xtrain, Ytrain, Xtest, Ytest, alpha)
    %% Construct likelihood vectors
    spam_occ = [];
    spam_li = [];
    ham_occ = [];
    ham_li = [];
    
    spam_indices = find(Ytrain == 0);
    ham_indices = find(Ytrain == 1);
    spam_total = sum(sum(Xtrain(spam_indices,:)));
    ham_total = sum(sum(Xtrain(ham_indices,:)));

    for k = 1:size(Xtrain,2)
        ham_occ(k) = (sum(Xtrain(ham_indices,k)) + 1) / (ham_total + size(Xtrain,2));
    end
    for k = 1:size(Xtrain,2)
        spam_occ(k) = (sum(Xtrain(spam_indices,k)) + 1) / (spam_total + size(Xtrain,2));
    end
    
    ham_li = drchrnd(ham_occ+alpha,1);
    spam_li = drchrnd(spam_occ+alpha,1);
    
    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2);% + log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2);% + log(pi_ham);
    Yhattest = double(P_ham > P_spam)';
    [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    

end

