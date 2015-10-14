__author__ = 'abhishek'

import numpy as np
from os import listdir


def output_activation(x,deriv=False):
    #Sigmoid
    1

def loadImageData(folder):
    subfolders = ['coast','forest','insidecity','mountain']
    modes = ['Test','Train']
    for subfolder in subfolders:
        for mode in modes:
        filenames = listdir(folder+subfolder)
        print filenames

    return (1,1)


if __name__ == '__main__':
    (Xdata,Ydata) = loadImageData('../Asgn1/data/DS4/data_students/')