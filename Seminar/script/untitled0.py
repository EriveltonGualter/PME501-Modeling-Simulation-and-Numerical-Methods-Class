# -*- coding: utf-8 -*-
"""
Created on Tue May 16 22:59:11 2017

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
cbar = plt.colorbar(cp)
plt.title('Torque para empinar')
plt.xlabel('Distancia Longitudinal (cm)')
plt.ylabel('Altura do Usuario')
cbar.ax.set_ylabel('Escala de Torque em Nm')


plt.show()