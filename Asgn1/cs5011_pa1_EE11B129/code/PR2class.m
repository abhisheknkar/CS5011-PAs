function [ pr1, re1, f1, pr2, re2, f2 ] = PR2class( a, ahat, cl1, cl2 )
    %% Precision, Recall
    P = find(ahat == cl1);
    TP = intersect(P, find(a==cl1));
    FP = setdiff(P,TP);

    N = find(ahat == cl2);
    TN = intersect(N, find(a==cl2));
    FN = setdiff(N,TN);
    pr1 = length(TP)/length(P);
    re1 = length(TP)/(length(TP)+length(FN));
    f1 = 2*pr1*re1/(pr1+re1);
    pr2 = length(TN)/length(N);
    re2 = length(TN)/(length(FP)+length(TN));
    f2 = 2*pr2*re2/(pr2+re2);
%     C = confusionmat(a,ahat,'order',[cl1 cl2])
    
    
end

