def beta_estimation(trainMatrix,trainLabel,testMatrix,alpha,Beta):
#    as likelihood bernoulli
   trainMatrix=np.where(trainMatrix>0,1,0)
   testMatrix=np.where(testMatrix>0,1,0)
   #Training
   #separating into positive and negative
   pos_=np.vstack([trainMatrix[i] for i in range(trainMatrix.shape[0]) if trainLabel[i]==1])
   neg_=np.vstack([trainMatrix[i] for i in range(trainMatrix.shape[0]) if trainLabel[i]==0])
   #we add one here for add-ne smoothing
   #the observed proportion of the word changes as prior is beta
   token_sum_pos=np.array([col.sum()+alpha-1 for col in np.transpose(pos_)])
   token_sum_neg=np.array([col.sum()+Beta-1 for col in np.transpose(neg_)])
   condprob_token_given_pos=np.log([token/float(token_sum_pos.sum()+alpha-1+Beta-1) for token in token_sum_pos])
   condprob_token_given_neg=np.log([token/float(token_sum_neg.sum()+alpha-1+Beta-1) for token in token_sum_neg])
   #testing
   #note we dont consider priors becaues we are doing Maximum Likelihood Estimation
   prediction=[]
   for test in testMatrix:
       score_=np.zeros(2)
       score_[0]=np.log(Beta)
       score_[1]=np.log(alpha)
       score_[0]=score_[0]+np.sum(test*condprob_token_given_neg)
       score_[1]=score_[1]+np.sum(test*condprob_token_given_pos)
       prediction.append(np.argmax(score_))
   return prediction