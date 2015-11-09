__author__ = 'Abhishek'

import cPickle
import numpy as np
import os
import arff

#TODO : Make this function more generic
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

def get_ARFF(filename,delimiter0='\t',normalize=0):
    print "Converting following file to ARFF: " + filename
    features = np.loadtxt(open(filename,"rb"),delimiter=delimiter0,skiprows=0)
    # features = np.loadtxt(filename, delimiter=' ')
    if normalize == 1:
        features_norm = (features - np.mean(features))/ np.std(features)
        features_norm[:,-1] = features[:,-1]
        features = features_norm

    num_features = features.shape[1]
    features[:,-1] = map(int,features[:,-1])
    # print map(int,features[:,-1])
    unique_features = np.unique(features[:,-1])

    base_filename = filename.split('.')[0]
    arff_file = open(base_filename + '.arff', 'w')
    header = gen_ARFF_header(base_filename, num_features, unique_features)

    np.savetxt(base_filename+'.csv', features,delimiter=',', fmt=['%f', '%f', '%d'])
    feature_file = open(base_filename + '.csv', 'r')
    lines = feature_file.readlines()
    feature_file.close()

    #Temoporarily handling 'nan' values by putting them 0
    lines = map(lambda x: x.replace('nan', '0'), lines)
    header += lines
    arff_file.writelines(header)
#------------------ Globals -----------------------------

if __name__ == "__main__":
    TRAIN_DATASET_PATH = ""

    inputfiles = os.listdir('ClusteringDatasets/')
    inputfilesTXT = []
    inputfilesTXT += [each for each in inputfiles if each.endswith('.txt')]
    for file in inputfilesTXT:
        inputfile = 'ClusteringDatasets/'+file
        get_ARFF(inputfile,normalize=1)

    inputfilesCSV = []
    inputfilesCSV += [each for each in inputfiles if each.endswith('.csv')]
    for file in inputfilesCSV:
        os.remove('ClusteringDatasets/'+file)