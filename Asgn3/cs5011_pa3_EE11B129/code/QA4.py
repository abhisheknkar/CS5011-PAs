__author__ = 'Abhishek'
from QA3 import getPurity

from scipy.io.arff import loadarff
import arff,os, operator
import numpy as np
import matplotlib.pyplot as plt

def getPurityMissingValues(filename):
    # clusters = int(filename.split('=')[1].split('.')[0])
    countdict = {}

    try:
        x = loadarff(filename)
        for row in x[0]:
            # print len(x[1])
            # print x[i]
            # print 100000
            # clusterid = row.Cluster
            clusterid = row['Cluster']
            if clusterid not in countdict:
                countdict[clusterid] = {}
            if row[3] not in countdict[clusterid]:
                countdict[clusterid][row['f2']] = 1
            else:
                countdict[clusterid][row['f2']] += 1

        maxtotal = 0
        alltotal = 0
        for cluster in countdict:
            if cluster != '?':
                maxtotal += max(countdict[cluster].values())
            alltotal += sum(countdict[cluster].values())
        purity = float(maxtotal) / alltotal
    except:
        purity = -1
    return purity

def getBatchPurity(folder):
    filenames = os.listdir(folder)
    f = open(folder + "purity.txt", 'w')
    for file in filenames:
        # print "Purity for " + file + "is " + str(purity)
        if file.endswith('arff'):
            purity = getPurityMissingValues(folder + file)
            if purity != -1:
                f.writelines(file + ": purity = " + str(purity) + '\n')
    f.close()

if __name__ == "__main__":
    getBatchPurity("/home/csd154server/QA4Out/")
'''
Purity is always around 0.7
Having large eps gives just 1 cluster
Having large minpts gives noise labels
For values of epsilon = 0.1 and minpts between 11 and 17, we get more than 1 cluster. The
minpts=2,eps=0.05,clusters=12.arff: purity = 0.973190348525
minpts=17,eps=0.1,clusters=2.arff: purity = 0.857908847185
'''