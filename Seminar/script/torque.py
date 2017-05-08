# -*- coding: utf-8 -*-
"""
Created on Sun May 07 22:20:27 2017

@author: erive
"""

import scipy.io
from scipy.io import loadmat

data = {}
data.update(loadmat('data_torque.mat'))

X = data['X']
Y = data['Y']
torque_step = data['torque_step']

import numpy as np
import matplotlib.pyplot as plt

fig = plt.figure()

cp = plt.contourf(X*100, Y, torque_step)

plt.title('Torque para empinar')
plt.xlabel('Distancia Longitudinal (cm)')
plt.ylabel('Altura do Usuario')

cbar = plt.colorbar(cp)
cbar.ax.set_ylabel('Escala de Torque em Nm')

axes1 = fig.add_subplot(111)
axes2 = axes1.twinx()   # mirror them
axes2.set_ylabel('Massa do Usuario')


plt.show()


from IPython.display import display, Math, Latex
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
pd.set_option('max_colwidth', 100)
a = pd.read_csv('parameters.txt', sep=',')