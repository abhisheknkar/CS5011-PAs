__author__ = 'abhishek'

import numpy as np
from os import listdir
import pickle
from skimage import io

def output_activation(x,deriv=False):
    #Sigmoid
    1

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


if __name__ == '__main__':
    (Xtrain,Ytrain,Xtest,Ytest) = loadImageData('../Asgn1/data/DS4/data_students/')
    savepickle((Xtrain,Ytrain,Xtest,Ytest),'Q1Out/data.pkl')
    (Xtrain,Ytrain,Xtest,Ytest) = loadpickle('Q1Out/data.pkl')
