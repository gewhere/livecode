"""
Live coding session with machine learning.
The script receives Chromagram data from SC3 and writes the raw data from onsets analysis to 'data.txt', and then it writes a file called 'data-pca.txt' with the iPCA results
"""
import argparse
import math
import lib.client_parasite

import numpy as np

#np.set_printoptions(threshold=np.nan)
from sklearn.decomposition import IncrementalPCA
from scipy import stats

from pythonosc import dispatcher
from pythonosc import osc_server

from bokeh.layouts import column
from bokeh.models import Button
from bokeh.palettes import RdYlBu3
from bokeh.plotting import figure, curdoc

from functools import partial
from random import random
from threading import Thread
import time

from bokeh.models import ColumnDataSource

from tornado import gen


def fw_pca(explained_variance, singular_values):
    """
    Write the results of the IPCA in data-pca.txt file
    """
    f = open('data-pca.txt', 'a')
    data_array = explained_variance + '\n' +  singular_values + '\n'
    f.write(data_array)
    f.close()


def write_data_array(x):
    """
    Write the results of the IPCA in data-pca.txt file
    """
    f = open('data-array.txt', 'w')
    f.write(x)
    f.close()



def pca(fname):
    """
    Perform IPCA on the features extracted from Chromagram in SC3
    """
    d = {}
    for x in range(0,12):
        d["val{0}".format(x)] = 0
        data_array = []
    with open(fname) as f:
        content = f.readlines()
        content = [x.strip() for x in content]
        #print('CONTENT: ', content)
        #print('CONTENT_SIZE: ', len(content))
    for elem in content:
        for i in range(0,12):
            if elem[0] == str(i) and elem[1] == ':':
                d['val'+str(i)] = float(elem.lstrip(str(i)+':').strip())
            elif elem[1] == '0':
                d['val10'] = float(elem.lstrip('10:').strip())
            elif elem[1] == '1':
                d['val11'] = float(elem.lstrip('11:').strip())
        data_array.append([d['val0'], d['val1'], d['val2'], d['val3'], d['val4'], d['val5'], d['val6'], d['val7'], d['val8'], d['val9'], d['val10'], d['val11']])
    write_data_array(str(data_array))
    #print('DATA_ARRAY_SIZE: ', len(data_array))
    try:
        X = np.array(data_array)
        print('X = ', X)
        Y = stats.zscore(X)
        mypca = IncrementalPCA(n_components=4, batch_size=None) # configure batch size
        mypca.fit(Y)
        print(mypca.explained_variance_ratio_)
        print(mypca.singular_values_)
        lib.client_parasite.read_pca_data(str(mypca.explained_variance_ratio_),str(mypca.singular_values_))
    except:
        pass
    return fw_pca(str(mypca.explained_variance_ratio_), str(mypca.singular_values_))


def write_chroma(unused_addr, args, data):
    """
    Write incoming acoustical features of Chromagram to data.txt file
    """
    if args[0] is not None:
        chromadata = "{}: {}\n".format(args, data)
        f = open('data.txt', 'a')
        f.write(chromadata)  # python will convert \n to os.linesep
        f.close()
        with open('data.txt') as fn: # readlines in every entry
            for i, l in enumerate(fn):
                pass
            lines = i + 1
            if lines % 360 == 0: # n_features=12 * 5
                pca('data.txt')
            return print(lines)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip",
                        default="127.0.0.1", help="The ip to listen on")
    parser.add_argument("--port",
                        type=int, default=5005, help="The port to listen on")
    args = parser.parse_args()

    dispatcher = dispatcher.Dispatcher()
    dispatcher.map("/chroma", print)
    dispatcher.map("/chroma", write_chroma)

    server = osc_server.ThreadingOSCUDPServer(
        (args.ip, args.port), dispatcher)
    print("Serving on {}".format(server.server_address))
    server.serve_forever()
