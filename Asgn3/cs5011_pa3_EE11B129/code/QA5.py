__author__ = 'Abhishek'
from QA3 import getPurity
from QA4 import getBatchPurity,getPurity,getPurityMissingValues

from scipy.io.arff import loadarff
import arff,os, operator
import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    # getBatchPurity("/home/csd154server/QA5Out_Spiral_DBSCAN/")
    # getBatchPurity("/home/csd154server/QA5Out_Path-based_DBSCAN/")
    # getBatchPurity("/home/csd154server/QA5Out_Flames_DBSCAN/")
    getBatchPurity("QA5_Hierarchical/")

'''
Spiral:
    DBSCAN:
        Best: minpts=2,eps=0.1,clusters=3.arff: purity = 1.0
    Hierarchical:
        Single link rules here. All correct.
Flames:
    DBSCAN:
        Extreme: minpts=1,eps=0.05,clusters=57.arff: purity = 1.0
        Best: minpts=9,eps=0.1,clusters=2.arff: purity = 0.975
    Hierarchical:
        Ward is the clear winner, perfect accuracy
Path-based:
    DBSCAN:
        Extreme: minpts=7,eps=0.05,clusters=30.arff: purity = 1.0
        Best: minpts=7,eps=0.05,clusters=3.arff: purity = 0.53333333
    Hierarchical:
        Ward does the best, but isn't a clear winner
'''