__author__ = 'abhishek'

import numpy as np
from os import listdir
import pickle
from skimage import io
from sklearn.metrics import confusion_matrix
from matplotlib.pyplot import *
import math

def output_activation(x,deriv=False):
    #Sigmoid
    if deriv:
        return x*(1-x)
    else:
        return 1/(1+np.exp(-x))

def savepickle(var,filename):
    output = open(filename, 'wb')
    pickle.dump(var, output)
    output.close()

def loadpickle(filename):
    pkl_file = open(filename, 'rb')
    output = pickle.load(pkl_file)
    pkl_file.close()
    return output

def loadImageData(folder):
    count = 0
    subfolders = ['coast','forest','insidecity','mountain']
    modes = ['Test','Train']
    bins = 32
    Xtrain = np.zeros((1,3*bins))
    Ytrain = np.zeros((1,1))
    Xtest = np.zeros((1,3*bins))
    Ytest = np.zeros((1,1))
    hist = [[] for i in range(3)]

    for subfolder in subfolders:
        for mode in modes:
            prefix = folder+subfolder+'/'+mode+'/'
            filenames = listdir(prefix)
            for filename in filenames:
                I = io.imread(prefix+filename)
                features = []
                for layer in range(3):
                    [hist[layer] ,temp] = np.histogram(I[:,:,layer],np.arange(bins+1))
                    features += hist[layer].tolist()

                if mode == 'Train':
                    Xtrain = np.vstack((Xtrain,np.asarray(features)))
                    Ytrain = np.vstack((Ytrain,subfolders.index(subfolder)))
                else:
                    Xtest = np.vstack((Xtest,np.asarray(features)))
                    Ytest = np.vstack((Ytest,subfolders.index(subfolder)))
                print count
                count+=1
    return (Xtrain[1:,:],Ytrain[1:],Xtest[1:,:],Ytest[1:])

def encodeOneHot(Y):
    ymax = int(max(Y))
    T = np.zeros((Y.shape[0],ymax+1))
    for count,y in enumerate(Y):
        T[count][int(y)]=1
    return T

def softmax(Y):
    out = np.exp(Y)
    outsum = np.tile(np.sum(out,1),(Y.shape[1],1)).T

    return out/outsum

def normalize(X,colwise=True):
    dim = int(colwise)
    Xmean = np.array([np.mean(X,0),]*X.shape[0])
    Xstd = np.array([np.std(X,0),]*X.shape[0])
    Xnorm = (X - Xmean)/Xstd
    return Xnorm

def trainNetwork(hiddens=20, iterations=10000,mu_alpha=0.01,mu_beta=0.01):
    #Normalize X and encode Y
    X = normalize(Xtrain)
    T = encodeOneHot(Ytrain)
    np.random.seed(1)
    c1 = 0.1
    c2 = 0.1
    #Initialize weights
    alpha = c1*np.random.random((Xtrain.shape[1],hiddens))
    beta = c2*np.random.random((hiddens,4))  #GENERALIZE THIS!

    epochvals = []; errorvals = [];
    for j in range(iterations):
        Z = output_activation(np.dot(X,alpha))
        Y = output_activation(np.dot(Z,beta))
        # Y = softmax(Y)

        R = Y - T
        delta = R*output_activation(Y,deriv=True)
        dR_dbeta = np.dot(Z.T,delta)    #Captain here: In A(mXn)*B(nXp), the middle dimension is what is summed over! *flies away*

        s = np.dot(delta,beta.T) * output_activation(Z,deriv=True)
        dR_dalpha = np.dot(X.T,s)

        beta -= dR_dbeta*mu_beta
        alpha -= dR_dalpha*mu_alpha

        curr_error = np.sqrt(np.sum(map(sum, R*R)))/(R.shape[0]*R.shape[1])
        epochvals.append(j)
        errorvals.append(curr_error)

        if (j% 100) == 0:
            print "j = " + str(j) + ", Error:" + str(curr_error)
    # print Y
    plot(epochvals,errorvals)
    show()
    return (alpha,beta,curr_error)

def testNetwork(Xtest,alpha,beta):
    #Written for one-hot encoding, GENERALIZE THIS later
    #Getting the Y's
    Z = output_activation(np.dot(Xtest,alpha))
    Y = output_activation(np.dot(Z,beta))
    Y = softmax(Y)
    # print Y
    out = np.argmax(Y,1)
    return out

def getPRF(Ypred,Ytest,classes=4):
    # print Ypred.T
    # print Ytest.T
    cm = confusion_matrix(Ytest.astype(int), Ypred.astype(int))
    print cm
    PRFmat = np.zeros((classes,3))
    for i in range(classes):
        # print np.sum(cm[:,i])
        PRFmat[i,0] = float(cm[i,i]) / np.sum(cm[:,i])
        PRFmat[i,1] = float(cm[i,i]) / np.sum(cm[i,:])
        # print PRFmat[i,:]
        PRFmat[i,2] = 2*PRFmat[i,0]*PRFmat[i,1] / (PRFmat[i,0]+PRFmat[i,1])
    return PRFmat

if __name__ == '__main__':
    # ------Data acquisition-------
    # (Xtrain,Ytrain,Xtest,Ytest) = loadImageData('../Asgn1/data/DS4/data_students/')
    # savepickle((Xtrain,Ytrain,Xtest,Ytest),'Q1Out/data.pkl')
    (Xtrain,Ytrain,Xtest,Ytest) = loadpickle('Q1Out/data.pkl')

    # Network Parameters-----------
    hiddens=20; iterations=1000; mu_alpha=0.01; mu_beta=0.01
    trainfile = "Q1Out/"+"train_"+str(hiddens)+","+str(iterations)+","+str(mu_alpha)+","+str(mu_beta)+".p"

    # -----Training Network--------
    (alpha, beta, final_error) = trainNetwork(hiddens,iterations,mu_alpha,mu_beta)
    savepickle((alpha,beta,final_error),trainfile)

    # -----Testing Network---------
    (alpha,beta,final_error) = loadpickle(trainfile)
    Ypred = testNetwork(Xtest,alpha,beta)
    print getPRF(Ypred,Ytest)