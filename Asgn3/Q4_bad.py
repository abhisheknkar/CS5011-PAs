__author__ = 'Abhishek'
import arff,os, operator
import numpy as np
import matplotlib.pyplot as plt
from Q3 import getPurity,plotPurity
# from createARFF import gen_ARFF_header, get_ARFF
def gen_ARFF_header(arff_name, num_features, unique_features):
    header = []
    header.append('@RELATION ' + arff_name + '\n\n')
    for i in range(num_features-1):
        header.append('@ATTRIBUTE f' + str(i) + ' REAL\n')

    # Generating output range:
    outputrange = "{" + str(map(int, unique_features))[1:-1] + "}"

    header.append('@ATTRIBUTE f' + str(num_features-1) + ' ' + outputrange+ '\n\n')
    header.append('@DATA\n')
    return header

def get_ARFF_char(filename,delimiter0='\t',labelidx=0,cols=23):
    print "Converting following file to ARFF: " + filename
    # features = np.loadtxt(open(filename,"rb"),delimiter=delimiter0,skiprows=0)

    attributes = set(xrange(0,cols)) - set([labelidx])

    features = []

    f = open(filename,"rb")
    for line in f.readlines():
        # features.append(line.split(delimiter0))
        linesplit = line.split(delimiter0)
        linesplit[-1] = linesplit[-1][0]
        label = linesplit[labelidx]
        features = linesplit[attributes]

    # # features = np.loadtxt(filename, delimiter=' ')
    # print features
    # num_features = features.shape[1]
    # features[:,-1] = map(int,features[:,-1])
    # # print map(int,features[:,-1])
    # unique_features = np.unique(features[:,-1])
    #
    # base_filename = filename.split('.')[0]
    # arff_file = open(base_filename + '.arff', 'w')
    # header = gen_ARFF_header(base_filename, num_features, unique_features)
    #
    # np.savetxt(base_filename+'.csv', features,delimiter=',', fmt=['%f', '%f', '%d'])
    # feature_file = open(base_filename + '.csv', 'r')
    # lines = feature_file.readlines()
    # feature_file.close()
    #
    # #Temoporarily handling 'nan' values by putting them 0
    # lines = map(lambda x: x.replace('nan', '0'), lines)
    # header += lines
    # arff_file.writelines(header)

if __name__ == "__main__":
    get_ARFF_char('DecisionTreesDatasets/agaricus-lepiota_train.data',delimiter0=',')