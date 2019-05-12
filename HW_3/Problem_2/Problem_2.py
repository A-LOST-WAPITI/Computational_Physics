from os import path
import matplotlib.pyplot as plt
from numpy import empty,array,vstack

dirPath=path.dirname(path.abspath(__file__))
filePath=dirPath+"/Problem_2.txt"

with open(filePath,"r") as f:
    strLists=f.readlines()
numArray=empty((0,7),float)
for line in strLists:
    numList=list(map(float,line.split()))
    numArray=vstack((numArray,array(numList)))
X=numArray[:,0]
f_raw=numArray[:,1]
f_exp=numArray[:,2]
d_raw=numArray[:,3]
d_exp=numArray[:,4]
q_raw=numArray[:,5]
q_exp=numArray[:,6]
f_re_err=f_exp-f_raw
d_re_err=d_exp-d_raw
q_re_err=q_exp-q_raw
plt.close('all')
plt.figure()
plt.subplot(221)
plt.title("float condition")
plt.plot(X,f_raw,"-",label="raw")
plt.plot(X,f_exp,".",label="expansion",ms=1.5)
plt.legend()
plt.subplot(222)
plt.title("double condition")
plt.plot(X,d_raw,"-",label="raw")
plt.plot(X,d_exp,".",label="expansion",ms=1.5)
plt.legend()
plt.subplot(223)
plt.title("quadmath condition")
plt.plot(X,q_raw,"-",label="raw")
plt.plot(X,q_exp,".",label="expansion",ms=1.5)
plt.legend()
plt.subplot(224)
plt.title("relative error")
plt.plot(X,f_re_err,".",label="float condition",ms=1.5)
plt.plot(X,d_re_err,".",label="double condition",ms=1.5)
plt.plot(X,q_re_err,"-",label="quadmath condition")
plt.legend()
plt.show()