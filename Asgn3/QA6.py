__author__ = 'Abhishek'
from QA3 import getPurity
from QA4 import getBatchPurity,getPurity,getPurityMissingValues

from scipy.io.arff import loadarff
import arff,os, operator
import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    getBatchPurity("/home/csd154server/QA6Out_D31_DBSCAN/")
