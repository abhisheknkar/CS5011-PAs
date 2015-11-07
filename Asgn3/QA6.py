__author__ = 'Abhishek'
from QA3 import getPurity
from QA4 import getBatchPurity,getPurity,getPurityMissingValues

from scipy.io.arff import loadarff
import arff,os, operator
import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    # getBatchPurity("QA6Out_D31_DBSCAN/")
    # getBatchPurity("QA6Out_D31_Hierarchical/")
    getBatchPurity("QA6_Kmeans/")

'''
K-means recovers all 32 clusters

DBSCAN: Poor performance: eps=0.05, minpts=11...19 gives 5 clusters, purity=0.16129
Reason: Clusters not well separated. Density is significant even in cluster gaps

Hierarchical clustering gives a purity of 0.9632
Ward property?
'''
