function [ pr1, re1, f1, pr2, re2, f2 ] = Q5_NB( Xtrain, Ytrain, Xtest, Ytest)
    %% Construct likelihood vectors
    spam_li = [];
    ham_li = [];

    spam_indices = find(Ytrain == 0);
    ham_indices = find(Ytrain == 1);

    spam_count = length(spam_indices);
    ham_count = length(ham_indices);
    
    spam_total = sum(sum(Xtrain(spam_indices,:)));
    ham_total = sum(sum(Xtrain(ham_indices,:)));

    for k = 1:size(Xtrain,2)
        ham_li(k) = (sum(Xtrain(ham_indices,k)) + 1) / (ham_total + size(Xtrain,2));
    end
    for k = 1:size(Xtrain,2)
        spam_li(k) = (sum(Xtrain(spam_indices,k)) + 1) / (spam_total + size(Xtrain,2));
    end
    
    %% Construct the priors
    pi_ham = ham_count / (ham_count + spam_count);
    pi_spam = 1 - pi_ham;
%     P_ham = pi_ham; P_spam = pi_spam;

    P_spam = sum(log(repmat(spam_li,size(Xtest,1),1)).*Xtest,2) + log(pi_spam);
    P_ham = sum(log(repmat(ham_li,size(Xtest,1),1)).*Xtest,2) + log(pi_ham);
    Yhattest = double(P_ham > P_spam)';
    [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( Ytest, Yhattest, 1, 0 );    
%     conf_mat = confusionmat(Ytest, Yhattest);
% plot(Ytest-Yhattest);pause;
end

