__author__ = 'Abhishek'
import pandas as pd
import os

def set_column_sequence(dataframe, seq):
    '''Takes a dataframe and a subsequence of its columns, returns dataframe with seq as first columns'''
    cols = seq[:] # copy so we don't mutate seq
    for x in dataframe.columns:
        if x not in cols:
            cols.append(x)
    return dataframe[cols]

def get_ARFF_char(filename,outname=None,labelidx=0, delimiter0=','):
    if outname == None:
        outname = filename.split('.')[0] + '.arff'

    x = pd.read_csv(filename,delimiter=delimiter0, header=None)
    featuresidx = set(xrange(0,x.shape[1])) - set([labelidx])
    uniquelist = [[] for i in range(x.shape[1])]

    for i in xrange(x.shape[1]):
        uniquelist[i] = pd.unique(x[i])

    # Writing header
    header = []
    header.append('@relation ' + filename+ '\n\n')
    for i in featuresidx:
        header.append('@attribute f' + str(i) + ' {'+ ','.join(uniquelist[i]) + '}\n')
    header.append('@attribute f' + str(labelidx) + ' {'+ ','.join(uniquelist[labelidx]) + '}\n\n')
    header.append('@data\n')

    # Writing data
    correctorder=list(featuresidx)
    correctorder.append(labelidx)
    x[correctorder].to_csv('temp.csv', sep=',',header=False,index=False) #Don't write row names, column names
    f = open('temp.csv','r')
    f1 = open(outname,'w')
    f1.writelines(header)
    for line in f.readlines():
        f1.write(line)
    f.close()
    os.remove('temp.csv')

if __name__ == "__main__":
    get_ARFF_char('DecisionTreesDatasets/agaricus-lepiota_train.data',delimiter0=',')
    get_ARFF_char('DecisionTreesDatasets/agaricus-lepiota_test.data',delimiter0=',')